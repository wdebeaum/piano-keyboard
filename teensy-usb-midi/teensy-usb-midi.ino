#include <SPI.h>

#define MAX_OCTAVES 10

byte scan_count;
unsigned long switch_states[MAX_OCTAVES];
byte times_since_change[MAX_OCTAVES*24];
byte old_button_states;
byte buf[3];

// value that can be changed using buttons on end
struct Reg {
  byte value;
  byte small_step;
  byte large_step;
  byte maximum;
};

// indices of registers
#define LOWEST_PITCH_REG 0
#define PROGRAM_REG 1
#define CHANNEL_REG 2
#define NUM_REGS 3

Reg regs[NUM_REGS];
int current_reg;

// usbMIDI library accepts 1-based channel numbers, even though the wire protocol is for 0-based channel numbers
#define CHANNEL (regs[CHANNEL_REG].value + 1)

// potentiometer
struct Pot {
  int pin;
  long old;
  long sum;
  long minimum;
  long center;
  long center_midi;
  long maximum;
};

Pot pitch_bend;
Pot modulation;

void init_pot(Pot& pot, long center_midi, int pin) {
  pot.pin = pin;
  pinMode(pin, INPUT_DISABLE); // disable jumps around logic transition levels
  long val = analogRead(pin);
  pot.old = val;
  pot.sum = 0;
  pot.minimum = val;
  pot.center = val;
  pot.center_midi = center_midi;
  pot.maximum = val;
}

// return a midi control value corresponding to the read value of the pot
int pot_midi_value(Pot& pot, long val) {
  if (val < pot.center) {
    return (val - pot.minimum) * pot.center_midi / (pot.center - pot.minimum);
  } else {
    return (val - pot.center) * pot.center_midi / (pot.maximum - pot.center) + pot.center_midi;
  }
}

// return new midi value if it changed enough to warrant a message about it;
// otherwise return -1
long update_pot(Pot& pot) {
  long val = analogRead(pot.pin);
  pot.sum += val;
  if (scan_count % 64 == 0) { // 64 scans since last computed value
    val = pot.sum / 64;
    pot.sum = 0;
    long old_midi_val = pot_midi_value(pot, pot.old);
    if (pot.minimum > val) pot.minimum = val;
    if (pot.maximum < val) pot.maximum = val;
    long new_midi_val = pot_midi_value(pot, val);
    if (old_midi_val != new_midi_val) {
      pot.old = val;
      return new_midi_val;
    } else {
      return -1;
    }
  } else {
    return -1;
  }
}

void setup() {
  pinMode(9, OUTPUT);
  SPI.begin();
  SPI.beginTransaction(SPISettings(26000000, MSBFIRST, SPI_MODE0)); // was mode 1 on raspi?
  scan_count = 0;
  memset(switch_states, 0, MAX_OCTAVES*sizeof(long));
  memset(times_since_change, 0, MAX_OCTAVES*24);
  old_button_states = 0;
  regs[LOWEST_PITCH_REG].value = 12*5; // octave #5
  regs[LOWEST_PITCH_REG].small_step = 1; // half-step
  regs[LOWEST_PITCH_REG].large_step = 12; // octave
  regs[LOWEST_PITCH_REG].maximum = 0x3f-12; // just the highest single octave
  regs[PROGRAM_REG].value = 0; // piano
  regs[PROGRAM_REG].small_step = 1;
  regs[PROGRAM_REG].large_step = 8; // instrument family
  regs[PROGRAM_REG].maximum = 0x3f;
  regs[CHANNEL_REG].value = 0;
  regs[CHANNEL_REG].small_step = 1;
  regs[CHANNEL_REG].large_step = 4; // only 16 channels; 4 is half the bits
  regs[CHANNEL_REG].maximum = 0xf;
  init_pot(pitch_bend, 0x1fff, PIN_A0);
  init_pot(modulation, 0x3f, PIN_A1);
}

void loop() {
  scan_count++;
  unsigned long now = micros();
  // load key state into shift regs
  digitalWrite(9, LOW);
  delayMicroseconds(1); // min ~20ns
  digitalWrite(9, HIGH);
  delayMicroseconds(1); // min ~20ns
  // also tried this, to be able to use MOSI instead of a separate digital pin, but it has timing issues when >2 octaves are connected
  //SPI.transfer(B11111101);
  // read state of control buttons on end, and sustain pedal
  byte new_button_states = SPI.transfer(B11111111);
  // which states have changed?
  byte button_changes = new_button_states ^ old_button_states;

  // sustain pedal
  if (button_changes & 1) { // sus pedal changed
    if (new_button_states & 1) { // sus pedal pressed
      usbMIDI.sendControlChange(0x40, 0x7f, CHANNEL);
    } else { // sus pedal released
      usbMIDI.sendControlChange(0x40, 0x00, CHANNEL);
    }
  }

  // get just the buttons that just started being pressed
  byte button_presses = button_changes & new_button_states;
  // interpret button presses as changing register values or switching registers
  if (button_presses & (1<<1)) { // fast up
    regs[current_reg].value += regs[current_reg].large_step;
    if (regs[current_reg].value > regs[current_reg].maximum) {
      regs[current_reg].value -= regs[current_reg].maximum+1;
    }
  }
  if (button_presses & (1<<2)) { // up
    regs[current_reg].value += regs[current_reg].small_step;
    if (regs[current_reg].value > regs[current_reg].maximum) {
      regs[current_reg].value -= regs[current_reg].maximum+1;;
    }
  }
  if (button_presses & (1<<3)) { // left
    if (current_reg == 0) {
      current_reg = NUM_REGS;
    }
    current_reg--;
  }
  if (button_presses & (1<<4)) { // clear
    regs[current_reg].value = 0;
  }
  if (button_presses & (1<<5)) { // fast down
    regs[current_reg].value -= regs[current_reg].large_step;
    if (regs[current_reg].value < 0) {
      regs[current_reg].value += regs[current_reg].maximum+1;
    }
  }
  if (button_presses & (1<<6)) { // down
    regs[current_reg].value -= regs[current_reg].small_step;
    if (regs[current_reg].value < 0) {
      regs[current_reg].value += regs[current_reg].maximum+1;
    }
  }
  if (button_presses & (1<<7)) { // right
    current_reg++;
    if (current_reg == NUM_REGS) {
      current_reg = 0;
    }
  }
  if (current_reg == PROGRAM_REG && button_presses & B01100110) {
    // program register (instrument) changed
    usbMIDI.sendProgramChange(regs[PROGRAM_REG].value, CHANNEL);
  }
  // TODO? re-send the last note-on message if any register value changed, to reflect the new value

  // read key states and send note on/off messages
  for (int o = 0; o < MAX_OCTAVES; o++) {
    buf[0] = SPI.transfer(B11111111);
    buf[1] = SPI.transfer(B11111111);
    buf[2] = SPI.transfer(B11111111);
    // pullup resistor indicates high end of octave chain
    if (buf[0] == B11111111 && buf[1] == B11111111 && buf[2] == B11111111) {
      break;
    }
    unsigned long new_state =
      // force big-endian interpretation so that bits go in a consistent order
      ((unsigned long)buf[0])<<16 |
      ((unsigned long)buf[1])<<8 |
      (unsigned long)buf[2];
    unsigned long old_state = switch_states[o];
    switch_states[o] = new_state;
    unsigned long changes = new_state ^ old_state;
    for (int s = 0; s < 24; s++, new_state >>= 1, changes >>= 1) {
      int tsci = o * 24 + s;
      if (changes & 1) { // switch changed state
	times_since_change[tsci] = 0;
      // otherwise increment time since this switch changed state (clamped)
      } else if (times_since_change[tsci] < 0x80) {
	times_since_change[tsci]++;
	if (times_since_change[tsci] == 1 &&
	    (s&1) == 0 // key-fully-down bits are even, have 0 in the 1s place
	   ) {
	  // key-fully-down switch changed state last scan and stayed there
	  byte note_num = regs[LOWEST_PITCH_REG].value + (o + 1) * 12 - (s>>1) - 1;
	  if (new_state & 1) { // key pressed
	    // get the time since the key-partly-down switch changed and use it
	    // to compute velocity
	    int kpdi = tsci^1; // key-partly-down bits toggle the 1s place
	    byte velocity = 0x80 - times_since_change[kpdi];
	    usbMIDI.sendNoteOn(note_num, velocity, CHANNEL);
	  } else { // key released
	    usbMIDI.sendNoteOff(note_num, 0, CHANNEL);
	  }
	}
      }
    }
  }

  // read knob states
  long new_pitch_bend = update_pot(pitch_bend);
  if (new_pitch_bend >= 0) { // changed
    // the library function for this doesn't seem to work right
    //usbMIDI.sendPitchBend((unsigned int)new_pitch_bend, CHANNEL);
    // instead, do it ourselves:
    usbMIDI.send((byte)B11100000, // type
                 (byte)(new_pitch_bend & B01111111), // low 7 bits
                 (byte)((new_pitch_bend >> 7) & B01111111), // high 7 bits
                 CHANNEL, // channel
                 0 // cable (WTF, usbMIDI library?)
                );
  }
  long new_modulation = update_pot(modulation);
  if (new_modulation >= 0) { // changed
    usbMIDI.sendControlChange(0x01, (byte)new_modulation, CHANNEL);
  }

  usbMIDI.send_now(); // flush midi output buffer to usb

  while (usbMIDI.read()) {} // ignore midi input from usb

  // delay until time for next scan, 32CD audio samples (1/44100 second) after
  // start of this scan
  unsigned long later = now + 725; // microseconds
  now = micros();
  if (later > now) {
    delayMicroseconds(later - now);
  }
}
