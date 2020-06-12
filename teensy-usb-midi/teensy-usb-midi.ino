#include <SPI.h>

// from https://github.com/joshnishikawa/MIDIcontroller
#include <MIDIcontroller.h>

#define MAX_OCTAVES 10

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

// potentiometer
struct Pot {
  int old;
  int minimum;
  int center;
  int center_midi;
  int maximum;
};

Pot pitch_bend;
Pot modulation;

void init_pot(Pot& pot, int center_midi, int val) {
  pot.old = val;
  pot.minimum = val;
  pot.center = val;
  pot.center_midi = center_midi;
  pot.maximum = val;
}

// return a midi control value corresponding to the read value of the pot
int pot_midi_value(Pot& pot, int val) {
  if (val < pot.center) {
    return (val - pot.minimum) * pot.center_midi / (pot.center - pot.minimum);
  } else {
    return (val -  pot.center) * pot.center_midi / (pot.maximum - pot.center);
  }
}

// return new midi value if it changed enough to warrant a message about it;
// otherwise return -1
int update_pot(Pot& pot, int val) {
  byte old_midi_val = pot_midi_value(pot, pot.old);
  if (pot.minimum > val) pot.minimum = val;
  if (pot.maximum < val) pot.maximum = val;
  byte new_midi_val = pot_midi_value(pot, val);
  if (old_midi_val != new_midi_val) {
    return new_midi_val;
  } else {
    return -1;
  }
}

void setup() {
  SPI.begin();
  SPI.beginTransaction(SPISettings(30000000, MSBFIRST, SPI_MODE1));
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
  init_pot(pitch_bend, 0x1fff, analogRead(PIN_A0));
  init_pot(modulation, 0x3f, analogRead(PIN_A1));
}

void loop() {
  unsigned long now = micros();
  SPI.transfer(B11111110); // load key state into shift regs on last bit

  // read state of control buttons on end, and sustain pedal
  byte new_button_states = SPI.transfer(B11111111);
  // which states have changed?
  byte button_changes = new_button_states ^ old_button_states;

  // sustain pedal
  if (button_changes & 1) { // sus pedal changed
    if (new_button_states & 1) { // sus pedal pressed
      usbMIDI.sendControlChange(0x40, 0x7f, regs[CHANNEL_REG].value);
    } else { // sus pedal released
      usbMIDI.sendControlChange(0x40, 0x00, regs[CHANNEL_REG].value);
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
    usbMIDI.sendProgramChange(regs[PROGRAM_REG].value, regs[CHANNEL_REG].value);
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
	    usbMIDI.sendNoteOn(note_num, velocity, regs[CHANNEL_REG].value);
	  } else { // key released
	    usbMIDI.sendNoteOff(note_num, 0, regs[CHANNEL_REG].value);
	  }
	}
      }
    }
  }

  // read knob states
  int new_pitch_bend = update_pot(pitch_bend, analogRead(PIN_A0));
  if (new_pitch_bend >= 0) { // changed
    usbMIDI.sendPitchBend(new_pitch_bend, regs[CHANNEL_REG].value);
  }
  int new_modulation = update_pot(modulation, analogRead(PIN_A1));
  if (new_modulation >= 0) { // changed
    usbMIDI.sendControlChange(0x01, new_modulation, regs[CHANNEL_REG].value);
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
