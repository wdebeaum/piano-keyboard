# Modular Piano Keyboard

## Usage Instructions

Build up to 10 octaves by repeating the [octave building instructions](BUILD.md). Connect them side to side on a flat surface, first lining up the skewers with their holes on the opposide side, and then pushing the octaves together so that the five-pin male connector on the right octave goes into the five-socket female connector on the left octave.

You have a number of options for connecting the octaves to something that will actually play notes:

### With a Teensy 4.0

Build the end piece using the [end building instructions](BUILD.md) (scroll down). Connect the left (five-pin male) connector on the lowest (leftmost) octave to the (five-pin female) connector on the right side of the end piece. Then connect the micro-USB connector on the back of the end piece to a computer or other device that understands USB MIDI devices. Optionally, connect a pedal switch to the 1/4" sustain pedal jack on the front of the end piece.

The front knob is a pitch bend knob. The back knob is for modulation. Not all MIDI synthesizers or instruments support these functions.

The buttons allow you to adjust a few settings. The left and right buttons select which setting is being changed. The inner up and down buttons adjust the currently selected setting in fine increments, and the outer ones adjust it in coarse increments. The rectangular button in the bottom left resets the currently selected setting to the minimum possible value. There are currently 3 different settings you can change:

 1. Transposition. Fine adjustment is by semitone, coarse adjustment is by octave. On startup the lowest pitch on the keyboard is C5.
 2. Instrument (MIDI program). Fine adjustment is by instrument, coarse adjustment is by family (group of 8 instruments in the General MIDI instrument list). On startup this is the first instrument, Acoustic Grand Piano.
 3. MIDI channel. Fine adjustment moves by 1 channel at a time, coarse adjustment moves by 4 channels at a time. On startup this is the first channel.

When you push one of the buttons, the last note you played (or the lowest key if you haven't played any yet) is played again, with any changes applied: it is transposed, or on the new instrument, or on the new channel. This lets you know what you just did.

### With a Raspberry Pi

Connect the left connector on the lowest (leftmost) octave to a Raspberry Pi's 5V power, SPI port, and one GPIO pin, as shown in the comments in `wiring.h`. If you connect to different pins, change the `#define`s in this file.

Copy this repo to the Pi, and run `make` there to compile the `spi2midi` program. If you run that program, it will write MIDI events to `stdout` for each keypress and release. It will also write debugging information to `stderr`, so it might be useful to do this to just see the debugging information while tuning the key switches:

    ./spi2midi >/dev/null

If, like me, you have a synthesizer connected to a MIDI port on your Linux computer, and you're accessing your Pi over ssh, you can route the MIDI events from the keyboard to the synthesizer with a command like this on your computer:

    ssh pi@pi path/to/spi2midi >/dev/snd/midiC0D0

### With another microcontroller

Connect the left connector on the lowest (leftmost) octave to a microcontroller with a 5V power source, an SPI port, and a GPIO pin. Back to front, the pins are:

 1. +5V VCC
 2. SPI MISO (5V!)
 3. SPI clock (~30MHz)
 4. Shift/load (connect to GPIO output pin; low loads switch state into the shift registers, high shifts state out of the registers)
 5. Ground

Note that while the circuit will tolerate 3.3V inputs on pins 3 and 4, it will still output 5V on pin 2. If your microcontroller can't tolerate 5V on its SPI MISO pin, you should make a voltage divider to change it to something close to what it will tolerate. An easy way to do that is to arrange 3 extra 10kΩ resistors (the same kind you used for R1) like this:

                     SPI MISO on μcontroller (3.3V)
                                ^
                                |
    ground>---/\/\/\---/\/\/\---*---/\/\/\---<pin 2 of keyboard (5V)
               10kΩ     10kΩ         10kΩ

Your code should momentarily (min. 14ns) drive pin 4 low, and then keep it high while reading from the SPI port. The first bit you receive will be the pre-press bit for the lowest key (nearest the controller) followed by the full press bit for the same key, followed by the same pattern for each higher key. The bits are labeled in a big-endian fashion within each byte on the PCB; full press bits are even, pre-press bits are odd.

You should read an octave at a time, and stop when you see an octave with all bits set (`0xffffff`); that's the pull-up resistor R1 in the highest octave, terminating the data line.

You should do a complete scan of the keyboard on the order of 1000 times a second. Note the time when the pre-press bit of a given key goes high, and then when you see the full press bit also go high (for two scans, to debounce), compute the time between the two transitions and use that as the velocity of the keypress. When you later see the full press bit go back to low, emit a key release.

Read `spi2midi.c` for an example of how to do all this.


