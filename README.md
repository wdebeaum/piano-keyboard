# Modular Piano Keyboard

By William de Beaumont

[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

![two octave modules being connected](images/two_octaves_connecting.gif)

## Description

A DIY portable electronic piano keyboard with full-size keys, composed of several identical single-octave modules plugged together. Made using 3D printing, through-hole soldering, and easily obtainable parts.

Each key has two switches that close at different heights, in order to detect the velocity with which the key is pressed. Each octave (12 keys) has 3 8-bit shift registers that take input from the 24 switches in parallel, and shift output out serially, down towards the low (left) side of the keyboard.

That side may be connected to an end piece that uses a Teensy 4.0 to drive the shift registers and act as a USB MIDI controller. The end piece also has pitch bend and modulation wheels, a connection for a sustain pedal, and buttons to adjust a few settings.

Alternatively, you can connect that side of the keyboard to your own microcontroller, using an SPI port and one GPIO pin. The included `spi2midi` program will turn keypresses into MIDI commands on `stdout` if it is run on a Raspberry Pi connected to the keyboard as shown in [`wiring.h`](wiring.h).

## Instructions

 - [Bill of Materials](BOM.md)

 - [Building Instructions](BUILD.md)

 - [Usage Instructions](USAGE.md)

## Future work

 - Better integration with ALSA MIDI ports on RasPi, ultimately letting it act as a standalone musical instrument by connecting to a soft synth.

 - Surface-mount version of octave PCB for mass production? Switches are still labor-intensive, though.
