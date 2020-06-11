#include <SPI.h>

// from https://github.com/joshnishikawa/MIDIcontroller
#include <MIDIcontroller.h>

void setup() {
  SPI.begin();
  SPI.beginTransaction(SPISettings(30000000, MSBFIRST, SPI_MODE1));
}

void loop() {
  // library calls I'll have to use:
  //SPI.transfer(data);
  //usbMIDI.sendNoteOn(notenum,velocity,channel);
  //usbMIDI.sendNoteOff(");
  //usbMIDI.sendProgramChange(program,channel);
  //analogRead(PIN_A0);
  //usbMIDI.sendPitchBend(value,channel);
  //analogRead(PIN_A1);
  //usbMIDI.sendControlChange(control,value,channel);
  //usbMIDI.send_now();
  //micros(); // read timestamp
  //delayMicroseconds(725);// less, to account for above
  while (usbMIDI.read()) {} // ignore midi input from usb
}
