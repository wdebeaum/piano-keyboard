#ifndef _WIRING_H_
#define _WIRING_H_

// Wiring diagram
//
// Raspberry Pi side:
// <--rest of board   hole   edge of board-->
//                   01  02
//                   03  04->Vcc
//                   05  06->GND
//                   07  08
//                   09  10
//                   11  12
//                   13  14
//                   15  16
//                   17  18
//                   19  20
// (SPI0 MISO)QH3v3->21  22
// (SPI0 SCLK) CLK <-23  24
//                   25  26
//                   27  28
//               SH<-29  30
//                   31  32
//                   33  34
//                   35  36
//                   37  38
//                   39  40
// <--rest of board   hole   edge of board-->
//
// Level shifter for QH line (the only SN74HC165N->RasPi connection):
//
//                   QH3v3
//                     ^
//                     |
//  QH5v-> ---/\/\/\---*---/\/\/\--- <-GND
//            n ohms      2n ohms
//
// I use n ∈ [1kΩ, 10kΩ]
//
// In the other direction, level shifting is unnecessary, since SN74HC165N will
// accept 3.3V logic levels on its inputs.

// relates to CLK and QH3v3
#define SPIDEV_PATH "/dev/spidev0.0"

// Broadcom pin number corresponding to SH/~LD pin on SN74HC165N (set high for
// serial shifting, low for parallel loading)
#define SH 5

#endif
