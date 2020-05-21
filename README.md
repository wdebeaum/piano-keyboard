# Modular Piano Keyboard

By William de Beaumont

[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

![two octave modules being connected](data:image/gif;base64,R0lGODlhQQA+AIABAAAAAP///yH/C05FVFNDQVBFMi4wAwEAAAAh+QQAZAD/ACwAAAAAQQA+AAAC/oSPicHtD6OcQVlFs963mz0dYORdI7WcVYmpzfemHNu6K3zjKJ2oupzL8BYAnyiGO0qGwBOwp2E2nTLlTloU6hy97AwLmua8USwZchZbteaQVTwyr9Fv+FW+pf/md3y4/odnRzJIKPjEx1CIdCjiBWXz0NhkkhdI5MfoQQUFBjnW8VUlpQjJw2YKVloX2sfKAgr6uGn4KWuh+YG7uitZk9vKSyv8aeI7BNxLTFP7m9o1p3r8S7xcxqynzNVpuwQ7bZx9tLhMGdpdbTR8m4Q+ph5etE6tGVeSK7sNZ+k9v1tDz8W3cPXwRRpoStwscgpxQSvVbCE/N0wkKeqnhGE5k1g/KGoEh+mcPF4YJ3qEdi+LtoL2KrU6VavlP1ow0XACiGFkzmAHg7XQ5aimQJc79elilwgVN5qYkCYtOapThRtTdQp1tQZg1RVVSSk193NV1408QfJpCnEqWWxmz2pTeVROW35BxXLl2ijZGaMwkrxYe6rs375k9gI+5C0ICb6TAtJRe/FwYxRi88hrfI/y3a8FAAAh+QQAZAD/ACwAAAAAQQA+AAAC/oSPicHtD6OcQVlFs963mw2GjneJJkha50qlKguP7rJ+MTPTZxLnev0L+Q4mYoMnGhqFOgxHCXg+mkEJNPq04WjLFjTZdWaVRao2c+0ezzIiFpVmb9Vr+iTenNorewh+aSZX9vfGd4a0Qyj3Izb2dxdY6LXwGNEIZnRlaHepgfg1V7UpOQmYFrpHCsnoM4r1AhTUivpRMkg31EaSWAXqaguHWOdBO0wpaCX2uqsXibwq65LMJewJ+9sxTf3sZxv1jd1Jq2qtLO2qzd3snXktHsrEbkOsqx5c4sQ83kNcvW36Dk0uHIbWabnm6NwbXOZEQZvBp0JBS8IcUhxoLN2hhng5xtUiF/Bhx3B9qgmECM6NPoMcj1HbRLIkuYsYeBy0meKGJngjYymUOO/juVs4P22BGdPkSSSNlqX0SK/cp5pz6iQFJpLNN5ULq8bJSkoowa5cdxqUBbSWxIgEr670aOmI3LU3CRljyDSZW5QI5W4d0Wbv10leBA+eElHdVkXZ/KDphqAAADs=)

## Description

A DIY portable electronic piano keyboard with full-size keys, composed of several identical single-octave modules plugged together. Made using 3D printing, through-hole soldering, and easily obtainable parts.

Each key has two switches that close at different heights, in order to detect the velocity with which the key is pressed. Each octave (12 keys) has 3 8-bit shift registers that take input from the 24 switches in parallel, and shift output out serially, down towards the low (left) side of the keyboard. You can connect that end of the keyboard to a microcontroller, using an SPI port and one GPIO pin. The included `spi2midi` program will turn keypresses into MIDI commands on `stdout` if it is run on a Raspberry Pi connected to the keyboard as shown in [`wiring.h`](wiring.h).

## Bill of Materials

Quantities shown here are for one octave (though you probably want to make at least 3).

### Printed plastic parts

| Ref. | Qty | Description |
|:---- | ---:|:---- |
| `support` | 1 | support for whole octave (or two halves below) |
| `support_low_half` | 1 | support for C-F keys |
| `support_high_half` | 1 | support for F♯-B keys |
| `black_key` | 4 | regular black keys |
| `key_a_sharp` | 1 | A♯ key |
| `key_c` | 1 | C key |
| `key_d` | 1 | D key |
| `key_e` | 1 | E key |
| `key_f` | 1 | F key |
| `key_g` | 1 | G key |
| `key_a` | 1 | A key |
| `key_b` | 1 | B key |

### Electronic components

| Ref. | Qty | Mfg. part no. | Digikey part no. | Description |
|:---- | ---:|:------------- |:---------------- |:----------- |
| U1-3 | 3 | SN74HC165N | 296-8251-5-ND | 8-bit PISO shift register |
| C1-3 | 3 | K104Z15Y5VF5TL2 | BC1160CD-ND | 0.1μF capacitor |
| RN1-3 | 3 | 4609X-101-103LF | 4609X-101-103LF-ND | 8×10kΩ bussed resistor array |
| R1 | 1 | RNF14FTD10K0 | RNF14FTD10K0CT-ND | 10kΩ resistor |
| J1 | 1 | PPTC051LGBN-RC | S5441-ND | 5-pin horiz. 0.1" pitch header, female |
| J2 | 1 | PRPC005SBAN-M71RC | S1111EC-05-ND | 5-pin horiz. 0.1" pitch header, male |

Note that you might want to order 3 more resistors for the whole keyboard, so you can make the level shifter/voltage divider for connecting the 5V output of the keyboard to a 3.3V input on a Raspberry Pi or other microcontroller, as shown in `wiring.h`.

### Other parts and materials

| Qty | Description | How to get |
| ---:|:------------|:------------ |
| 12 | Bobby pin (metal) | Grocery store, hair care section, pack of 50, UPC 8 50899 00111 0 |
| 4 | M3 machine screw (length ~6mm) | Electronics/hardware store |
| 2 | Bamboo skewer (diameter 3mm, length >= 162.5mm) | Grocery store, barbecue section? pack of... many |
| 1 | Printed circuit board | OSH Park |
| ~30cm | Stranded copper wire | Cut from old telephone cord |
| ~60cm | 22 AWG solid copper wire | I got mine from Adafruit |
| 162.5×138.8mm | Corrugated cardboard | Cut from shipping boxes |
| ??? | Solder | been using the same spool forever... |
| ??? | Acetone | Grocery store, nail care section ("nail polish remover") |
| ??? | Cotton swab | Grocery store, probably near the acetone |
| ??? | Superglue | Grocery store, housewares section |

## Building Instructions

### Plastic Parts

The keys and their support structure can be printed on a 3D printer. Open `piano-keyboard.scad` in [OpenSCAD](https://www.openscad.org/). By default this shows one assembled octave, including ghosts for the non-printed parts. You can also see a version with a cutaway in the C key to show how things fit together, by commenting out `assembled();` and uncommenting `cutaway();`, at the end of the file.

You may need to adjust some parameters in the section labeled "parameters that depend on printer capabilities". I use an original [Printrbot](https://reprap.org/wiki/Printrbot), printing in ABS plastic onto blue painter's tape with a coating of ABS glue (made by dissolving waste ABS in a small amount of acetone to make it just gooey enough to spread). The Printrbot has a relatively small print bed (~ 124mm × 144mm, the white keys just barely fit), and printing in ABS onto tape means I have to worry a lot about prints curling up due to differential thermal contraction, especially with long thin pieces like piano keys. I also tend to have problems with close-fitting parts, solved with the `gap` parameter and a few others for specific situations. These issues are why I don't include my STL files here, only the original OpenSCAD file; you really should make your own STLs.

To show printable parts, comment out `assembled();` and uncomment one line at a time from the "recommended printing order" section (make sure to read the comments there for more tips). You can then generate an STL file for each print (`Design` > `Render`, then `File` > `Export` > `Export as STL...`). I use Slic3r to generate gcode from the STL, with 20% fill density, and 2 solid layers on all sides.

Note that you have a couple of options for printing the black keys and the supports. I use the separate low and high halves for both, but if your printer is big enough and you're not worried about curling, you can try printing a whole octave at a time.

White keys are printed two at a time, again for space and curling reasons, but also because fit issues are likely to show up here. You wouldn't want to print a whole octave of white keys only to find out they don't quite fit on the supports and you have to adjust the parameters slightly. If you do in fact want to print a whole octave of white keys, you can try calling `plated_white_keys();` instead. If you are having curling issues, I don't recommend trying to print the white keys one at a time diagonally; I tried that a couple of times and had bad results.

You should be checking that the keys fit on their supports immediately after printing them, so that you can either make adjustments to the parameters, or just shave or sand them down to make them slide freely up and down. See "Attach keys" below. You should also check that the bobby pins fit in each slot before soldering them to the PCB. You might want to assign specific pins to specific slots in order to fine tune how the pins are bent, so that the white keys sit at the same height and require the same force to press.

Be careful when testing the bobby pins in their slots. They can shoot out suddenly, so keep a finger on them to prevent that, if it would stick a pin in your eye.

### Printed Circuit Board (PCB)

The circuit is designed in [KiCAD](https://kicad-pcb.org/). You can open the project file `piano-keyboard-pcb/piano-keyboard-pcb-v2.pro` in KiCAD and use it to export Gerber files if you need to. I used [OSH Park](https://oshpark.com/)'s 2-layer prototype service, which accepts `.kicad_pcb` files directly. I got 3 copies of this board, unpopulated, for $44.45 delivered (this was by far the most expensive part, except for my own labor).

#### Solder components to the bottom

All the components on the PCB are through-hole soldered. Everything except for the switches (i.e. wires) goes on the bottom. I recommend leaving the switches for last, and doing everything else in order from thinnest to thickest:

 - Connectors J1-2. Do the male connector J1 first, while it's plugged into the female connector, to make sure there's enough space between the pins and the board.
 - Resistor R1.
 - Chips U1-3. Note that these set the maximum height of the board.
 - Capacitors C1-3. These are about the same height; if not, bend them over a little.
 - Resistor networks RN1-3. These are slightly taller than the chips, but you can bend them over slightly before soldering. I recommend bending them away from the adjacent chips, so that the pins poking through the other side go towards the chips, and thus towards the middle of the key they're under. This should make them fit in the hollow in the bottom of the key when it's pressed.

Cut off the excess leads from the resistor and capacitors, and optionally save them for later.

#### Make switches on the top

Make the switches from the bobby pins and wire, and solder them to the top side of the board (opposite all the other components):

 - Unbend the bobby pin slightly, so that it fits snugly in the slots in the support, and takes an appropriate amount of force to push down.
 - Remove any coating from the wavy (bottom) side of the bobby pin where you'll be soldering, and from the inside of the straight (top) side where the other wires will make contact when the switch is closed. You can do this with acetone and a cotton swab. Don't remove the coating from the bulbs on the ends or they'll fall off and leave you with a sharp edge. Also don't inhale the acetone.
 - Cut 2-3cm of uninsulated stranded copper wire and wrap one end around the wavy side of the bobby pin, with enough of the end of the wire hanging over the end of the pin so that you can poke it through the hole closest to the edge of the PCB. Solder the wire and the pin together where you wrapped it.
 - Solder that wire into that hole, making sure that the bottom side of the bobby pin ends right about where the PCB begins (no overlap, maybe a 1mm gap). If the wire is too short, the pin won't go all the way into its slot; if it's too long, it will arch up and interfere with the other wires.
 - Strip the ends of a ~2cm piece of solid copper wire, and solder it into the middle hole. You can reuse the leads cut off of the resistor and capacitors for some of these.
 - Similarly use ~3cm of solid copper wire with the last hole.
 - Bend the shorter, middle wire straight into the middle of the bobby pin, with the free end bent up a little.
 - Bend the longer wire away from the bobby pin, along the board, and then make a sharp U-shaped bend up and back towards the middle of the bobby pin, not as far as the shorter wire. Again, bend the free end up, a little less than the shorter wire.

You might want to save the wire bending steps for when the PCB is inserted into the plastic support. The goal is for the bobby pin, when pressed down, to make contact with the long wire first, and then the short wire. The U-bend in the long wire makes it so it can spring back instead of being permanently bent down when you first press the key. It will take some testing and iteration to get this right for each key. You can use an extra bobby pin or two as tools to help you adjust the positions of the wires while they are inside the support.

Note that the C and G keys have screw holes near where the longer wire is soldered. The U-bend in the longer wires for these keys should just about touch the screw heads. In general the U-bends for all the keys need to be tight in order to avoid having the key push down on the wire there and make it lose contact with the bobby pin.

After you're finished soldering, it's a good idea to check for short circuits with a multimeter. At least check that VCC and ground aren't shorted before plugging it in.

### Final Assembly

At this point, you should be sure that all the keys fit on their supports and slide freely.

#### Insert PCB into support

Line up all the bobby pins in their slots in the support, and start pushing them in. If you printed the support in two halves, you can do this one half at a time to make it easier. Be careful not to break the stranded wires connecting the pins to the PCB. You can use the top of one of the white keys as a tool to push on the top sides of all the pins at once, to make them go in evenly. Note that if the switch wires stick out of the bottom side of the board a little, they might catch on the part of the support under the PCB. You can wiggle the PCB up and down a little to get past this, and get the wires that stick out into the depressions for them in the PCB support struts. Push the bobby pins and PCB all the way in, so the back edge of the PCB is up against the front of the main part of the support. You should be able to see the back of the pins through the holes in the backs of the support walls. If you need to undo this step later you can poke another pin through those holes from the back, to loosen the pins.

#### Secure supports and PCB

Insert the skewers in the two horizontal holes in the bottom of the support (now is a good time, especially if you printed the support in two halves). You should cut them to the same length as the octave, 162.5mm. Insert them so that the back skewer hangs out of the left side by 1cm, and the front skewer hangs out of the right side by 1cm. If they're loose, you can glue them in place later. If they're too tight to insert, check for plastic blobs inside the holes getting in the way and remove them with a knife and/or a drill. If there's nothing in the way, try flexing the support to straighten the holes as you insert the skewers.

Insert the four screws through the PCB and into the corresponding holes in the support. You might need to use some force when screwing them in for the first time, in order to cut the threads into the plastic. Do this on a surface you don't care about the finish of, just in case the screws poke out a little from the bottom of the support.

#### Check switches

Make sure the switch wires are bent properly (see PCB instructions above). If you already bent them into place, check them again, since inserting the PCB into the support might have knocked them out of alignment. Look into the bobby pin slot from the front and press down on the top of the pin with your finger, so you can see if and when the wires make contact with the pin. You might also want to connect the electronics at this point so you can see when connections are being made that way.

#### Attach keys

Slide each key onto its support wall, and then slide it forward until the hinge snaps into place. Attach the white keys first and then the black keys. The white keys are C through B, left to right. The black keys are all the same except for the rightmost one, A♯, which has a notch on the bottom right side to accommodate one of the screw heads.

If you printed the support in two halves, check that the F key doesn't noisily rub against the F♯ and G keys. If it does, try to wiggle the support halves around until it doesn't. Failing that, shave down the keys where they rub.

#### Attach cardboard

Cut a rectangular piece of corrugated cardboard, 162.5mm × 138.8mm (these measurements are `echo`'d by OpenSCAD when you show the default `assembled();` scene). Cut it so that the corrugations run parallel to the keys (along the Y dimension). This cardboard helps the keyboard not to tip forward when you play chords, so you don't want it to fold up along the X dimension.

Turn the keyboard upside down and put a small amount of glue on each of the bottom surfaces (and on the skewers if they're still loose). Press the cardboard onto the glued surfaces, taking care to align the back corners of the support with the back corners of the cardboard. Turn the keyboard right side up again and let the glue set.

## Usage Instructions

Build up to 10 octaves by repeating the build instructions above. Connect them side to side on a flat surface, first lining up the skewers with their holes on the opposide side, and then pushing the octaves together so that the five-pin male connector on the right octave goes into the five-socket female connector on the left octave.

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

## Future work

 - Better integration with ALSA MIDI ports on RasPi, ultimately letting it act as a standalone musical instrument by connecting to a soft synth.

 - Code and PCB for connecting the keyboard to a Teensy 3.2/4.0 and having it identify itself as a USB MIDI controller. Include other controls e.g. octave selector, instrument selector, pedal, pitch bend/modulation wheels.

 - Surface-mount version of PCB for mass production? Switches are still labor-intensive, though.
