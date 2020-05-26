# Modular Piano Keyboard

## Bill of Materials

![picture of the parts listed below, laid out on a table](images/all_parts.jpg)

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

These total about 40cm<sup>3</sup> of black plastic, 60cm<sup>3</sup> of white plastic, and 50cm<sup>3</sup> of additional plastic of any color (the color of the supports doesn't matter).

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
| 141 joints' worth | Solder | been using the same spool forever... |
| ~6 | Cotton swab | Grocery store, probably near the acetone |
| enough to soak the swabs | Acetone | Grocery store, nail care section ("nail polish remover") |
| ~16 drops | Superglue | Grocery store, housewares section |

