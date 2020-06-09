# Modular Piano Keyboard

## Building Instructions

### Plastic Parts

The keys and their support structure can be printed on a 3D printer. Open `octave.scad` in [OpenSCAD](https://www.openscad.org/). By default this shows one assembled octave, including ghosts for the non-printed parts. You can also see a version with a cutaway in the C key to show how things fit together, by commenting out `assembled();` and uncommenting `cutaway();`, at the end of the file.

You may need to adjust some parameters in the section labeled "parameters that depend on printer capabilities". I use an original [Printrbot](https://reprap.org/wiki/Printrbot), printing in ABS plastic onto blue painter's tape with a coating of ABS glue (made by dissolving waste ABS in a small amount of acetone to make it just gooey enough to spread). The Printrbot has a relatively small print bed (~ 124mm × 144mm, the white keys just barely fit), and printing in ABS onto tape means I have to worry a lot about prints curling up due to differential thermal contraction, especially with long thin pieces like piano keys. I also tend to have problems with close-fitting parts, solved with the `gap` parameter and a few others for specific situations. These issues are why I don't include my STL files here, only the original OpenSCAD file; you really should make your own STLs.

To show printable parts, comment out `assembled();` and uncomment one line at a time from the "recommended printing order" section (make sure to read the comments there for more tips). You can then generate an STL file for each print (`Design` > `Render`, then `File` > `Export` > `Export as STL...`). I use Slic3r to generate gcode from the STL, with 20% fill density, and 2 solid layers on all sides.

Note that you have a couple of options for printing the black keys and the supports. I use the separate low and high halves for both, but if your printer is big enough and you're not worried about curling, you can try printing a whole octave at a time.

White keys are printed two at a time, again for space and curling reasons, but also because fit issues are likely to show up here. You wouldn't want to print a whole octave of white keys only to find out they don't quite fit on the supports and you have to adjust the parameters slightly. If you do in fact want to print a whole octave of white keys, you can try calling `plated_white_keys();` instead. If you are having curling issues, I don't recommend trying to print the white keys one at a time diagonally; I tried that a couple of times and had bad results.

You should be checking that the keys fit on their supports immediately after printing them, so that you can either make adjustments to the parameters, or just shave or sand them down to make them slide freely up and down. See "Attach keys" below. You should also check that the bobby pins fit in each slot before soldering them to the PCB. You might want to assign specific pins to specific slots in order to fine tune how the pins are bent, so that the white keys sit at the same height and require the same force to press.

Be careful when testing the bobby pins in their slots. They can shoot out suddenly, so keep a finger on them to prevent that, if it would stick a pin in your eye.

### Printed Circuit Board (PCB)

The circuit is designed in [KiCAD](https://kicad-pcb.org/). You can open the project file `octave-pcb/piano-keyboard-pcb-v2.pro` in KiCAD and use it to export Gerber files if you need to. I used [OSH Park](https://oshpark.com/)'s 2-layer prototype service, which accepts `.kicad_pcb` files directly. I got 3 copies of this board, unpopulated, for $44.45 delivered (this was by far the most expensive part, except for my own labor).

#### Solder components to the bottom

All the components on the PCB are through-hole soldered. Everything except for the switches (i.e. wires) goes on the bottom. I recommend leaving the switches for last, and doing everything else in order from thinnest to thickest:

 - Connectors J1-2. Do the male connector J1 first, while it's plugged into the female connector, to make sure there's enough space between the pins and the board.<br>![how to solder J1](images/soldering_j1.jpg)
 - Resistor R1.
 - Chips U1-3. Note that these set the maximum height of the board.
 - Capacitors C1-3. These are about the same height; if not, bend them over a little.
 - Resistor networks RN1-3. These are slightly taller than the chips, but you can bend them over slightly before soldering. I recommend bending them away from the adjacent chips, so that the pins poking through the other side go towards the chips, and thus towards the middle of the key they're under. This should make them fit in the hollow in the bottom of the key when it's pressed.<br>![how to bend RN1-3](images/bending_rn.jpg)

Cut off the excess leads from the resistor and capacitors, and optionally save them for later.

![board with most components soldered and leads trimmed](images/most_soldered.jpg)

#### Make switches on the top

Make the switches from the bobby pins and wire, and solder them to the top side of the board (opposite all the other components):

 - Unbend the bobby pin slightly, so that it fits snugly in the slots in the support, and takes an appropriate amount of force to push down. If it doesn't go in all the way, try reaming out the slot with a drill bit to remove any extra blobs of plastic that may be interfering (especially from the top, where the bridging might have sagged into the slot).<br>![making the pin fit](images/making_pin_fit.jpg)
 - Remove any coating from the wavy (bottom) side of the bobby pin where you'll be soldering, and from the inside of the straight (top) side where the other wires will make contact when the switch is closed. You can do this with acetone and a cotton swab. Don't remove the coating from the bulbs on the ends or they'll fall off and leave you with a sharp edge. Also don't inhale the acetone.
 - Cut 2-3cm of uninsulated stranded copper wire and wrap one end around the wavy side of the bobby pin, with enough of the end of the wire hanging over the end of the pin so that you can poke it through the hole closest to the edge of the PCB. Solder the wire and the pin together where you wrapped it.<br>![preparing the bobby pin](images/preparing_bobby_pin.jpg)
 - Solder that wire into that hole, making sure that the bottom side of the bobby pin ends right about where the PCB begins (no overlap, maybe a 1mm gap). If the wire is too short, the pin won't go all the way into its slot; if it's too long, it will arch up and interfere with the other wires.
 - Strip the ends of a ~2cm piece of solid copper wire, and solder it into the middle hole. You can reuse the leads cut off of the resistor and capacitors for some of these.
 - Similarly use ~3.5cm of solid copper wire with the last hole.<br>![wire lengths](images/wire_lengths.jpg)
 - Bend the shorter, middle wire straight into the middle of the bobby pin, with the free end bent up a little.
 - Bend the longer wire away from the bobby pin, along the board, and then make a sharp U-shaped bend up and back towards the middle of the bobby pin, not as far as the shorter wire. Again, bend the free end up, a little less than the shorter wire.

![bent wires](images/wires_bent.jpg)

The wire bending doesn't have to be perfect for now; save that for when the PCB is inserted into the plastic support. The goal is for the bobby pin, when pressed down, to make contact with the long wire first, and then the short wire. The U-bend in the long wire makes it so it can spring back instead of being permanently bent down when you first press the key.

Note that the C and G keys have screw holes near where the longer wire is soldered. The U-bend in the longer wires for these keys should just about touch the screw heads. In general the U-bends for all the keys need to be tight in order to avoid having the key push down on the wire there and make it lose contact with the bobby pin.

After you're finished soldering, it's a good idea to check for short circuits with a multimeter. At least check that VCC and ground aren't shorted before plugging it in.

### Final Assembly

At this point, you should be sure that all the keys fit on their supports and slide freely. But leave the keys off for the next step.

#### Insert PCB into support

Line up all the bobby pins in their slots in the support, and start pushing them in. If you printed the support in two halves, you can do this one half at a time to make it easier. Be careful not to break the stranded wires connecting the pins to the PCB. You can use the top of one of the white keys as a tool to push on the top sides of all the pins at once, to make them go in evenly. Be patient. Note that if the switch wires stick out of the bottom side of the board a little, they might catch on the part of the support under the PCB. You can wiggle the PCB up and down a little to get past this, and get the wires that stick out into the depressions for them in the PCB support struts. Push the bobby pins and PCB all the way in, so the back edge of the PCB is up against the front of the main part of the support.

![inserting one pin](images/inserting_bobby_pin.gif)
![half the switches inserted](images/half_the_switches_inserted.jpg)

You should be able to see the back of the pins through the holes in the backs of the support walls. If you need to undo this step later you can poke another pin through those holes from the back, to loosen the pins.

![ejecting a pin from the back](images/ejecting_bobby_pin.gif)

#### Secure supports and PCB

Insert the skewers in the two horizontal holes in the bottom of the support (now is a good time, especially if you printed the support in two halves). You should cut them to the same length as the octave, 162.5mm. Insert them so that the back skewer hangs out of the left side by 1cm, and the front skewer hangs out of the right side by 1cm. If they're loose, you can glue them in place later. If they're too tight to insert, check for plastic blobs inside the holes getting in the way and remove them with a knife and/or a drill. If there's nothing in the way, try flexing the support to straighten the holes as you insert the skewers.

Insert the four screws through the PCB and into the corresponding holes in the support. You might need to use some force when screwing them in for the first time, in order to cut the threads into the plastic. Do this on a surface you don't care about the finish of, just in case the screws poke out a little from the bottom of the support.

![skewers and screws inserted](images/skewers_and_screws_inserted.jpg)

#### Check switches

Make sure the switch wires are bent properly (see PCB instructions above), since inserting the PCB into the support might have knocked them out of alignment. Look into the bobby pin slot from the front and press down on the top of the pin with your finger, so you can see if and when the wires make contact with the pin. You might also want to connect the electronics at this point so you can see when connections are being made that way. It will take some testing and iteration to get this right for each key. You can use an extra bobby pin or two as tools to help you adjust the positions of the wires while they are inside the support.

![adjusting the switch wires for C♯ key with another bobby pin](images/tuning_switch.jpg)

#### Attach keys

Slide each key onto its support wall, and then slide it forward until the hinge snaps into place. Attach the white keys first and then the black keys. The white keys are C through B, left to right. The black keys are all the same except for the rightmost one, A♯, which has a notch on the bottom right side to accommodate one of the screw heads.

If you printed the support in two halves, check that the F key doesn't noisily rub against the F♯ and G keys. If it does, try to wiggle the support halves around until it doesn't. Failing that, shave down the keys where they rub.

#### Attach cardboard

Cut a rectangular piece of corrugated cardboard, 162.5mm × 138.8mm (these measurements are `echo`'d by OpenSCAD when you show the default `assembled();` scene). Cut it so that the corrugations run parallel to the keys (along the Y dimension). This cardboard helps the keyboard not to tip forward when you play chords, so you don't want it to fold up along the X dimension.

![cardboard cut to size](images/cardboard_cut.jpg)

Turn the keyboard upside down and put a small amount of glue on each of the bottom surfaces (and on the skewers if they're still loose). Press the cardboard onto the glued surfaces, taking care to align the back corners of the support with the back corners of the cardboard. Turn the keyboard right side up again and let the glue set.

