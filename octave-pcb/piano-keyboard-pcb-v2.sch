EESchema Schematic File Version 4
LIBS:piano-keyboard-pcb-v2-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Modular Piano Keyboard"
Date "2020-03-01"
Rev "v2"
Comp ""
Comment1 ""
Comment2 "creativecommons.org/licenses/by/4.0/"
Comment3 "License: CC BY 4.0"
Comment4 "Author: William de Beaumont"
$EndDescr
$Comp
L 74xx_IEEE:74165 U1
U 1 1 5E5C2E31
P 1150 3450
F 0 "U1" H 1150 2335 50  0000 C CNN
F 1 "74165" H 1150 2426 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 1150 3450 50  0001 C CNN
F 3 "" H 1150 3450 50  0001 C CNN
	1    1150 3450
	-1   0    0    1   
$EndComp
$Comp
L Connector:Conn_01x05_Male J1
U 1 1 5E5CDE00
P 750 5200
F 0 "J1" H 858 5581 50  0000 C CNN
F 1 "Conn_01x05_Male" H 858 5490 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Horizontal" H 750 5200 50  0001 C CNN
F 3 "~" H 750 5200 50  0001 C CNN
	1    750  5200
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Network08_US RN1
U 1 1 5E5D6834
P 1800 1900
F 0 "RN1" V 2325 1900 50  0000 C CNN
F 1 "10k x8" V 2234 1900 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP9" V 2275 1900 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 1800 1900 50  0001 C CNN
	1    1800 1900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2150 2600 2150 1600
Wire Wire Line
	2350 2750 2350 1700
Wire Wire Line
	2000 1700 2350 1700
Connection ~ 2350 1700
Wire Wire Line
	2350 1700 2350 1400
Wire Wire Line
	2000 1600 2150 1600
Connection ~ 2150 1600
Wire Wire Line
	2150 1600 2150 1400
$Comp
L power:GND #PWR0101
U 1 1 5E5E2878
P 1500 2300
F 0 "#PWR0101" H 1500 2050 50  0001 C CNN
F 1 "GND" H 1505 2127 50  0000 C CNN
F 2 "" H 1500 2300 50  0001 C CNN
F 3 "" H 1500 2300 50  0001 C CNN
	1    1500 2300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5E5E387C
P 1150 4100
F 0 "#PWR0102" H 1150 3850 50  0001 C CNN
F 1 "GND" H 1155 3927 50  0000 C CNN
F 2 "" H 1150 4100 50  0001 C CNN
F 3 "" H 1150 4100 50  0001 C CNN
	1    1150 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 4100 1150 4000
$Comp
L power:GND #PWR0103
U 1 1 5E5E41E8
P 1900 3750
F 0 "#PWR0103" H 1900 3500 50  0001 C CNN
F 1 "GND" H 1905 3577 50  0000 C CNN
F 2 "" H 1900 3750 50  0001 C CNN
F 3 "" H 1900 3750 50  0001 C CNN
	1    1900 3750
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0104
U 1 1 5E5EAA5D
P 2250 900
F 0 "#PWR0104" H 2250 750 50  0001 C CNN
F 1 "VCC" H 2267 1073 50  0000 C CNN
F 2 "" H 2250 900 50  0001 C CNN
F 3 "" H 2250 900 50  0001 C CNN
	1    2250 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 1000 2250 950 
$Comp
L Connector:Conn_01x05_Female J2
U 1 1 5E5EDAC0
P 10400 5200
F 0 "J2" H 10428 5226 50  0000 L CNN
F 1 "Conn_01x05_Female" H 10428 5135 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x05_P2.54mm_Horizontal" H 10400 5200 50  0001 C CNN
F 3 "~" H 10400 5200 50  0001 C CNN
	1    10400 5200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5E5F46E6
P 1400 5400
F 0 "#PWR0105" H 1400 5150 50  0001 C CNN
F 1 "GND" V 1405 5272 50  0000 R CNN
F 2 "" H 1400 5400 50  0001 C CNN
F 3 "" H 1400 5400 50  0001 C CNN
	1    1400 5400
	0    -1   -1   0   
$EndComp
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5E5F4A40
P 1350 4950
F 0 "#FLG0101" H 1350 5025 50  0001 C CNN
F 1 "PWR_FLAG" H 1350 5123 50  0000 C CNN
F 2 "" H 1350 4950 50  0001 C CNN
F 3 "~" H 1350 4950 50  0001 C CNN
	1    1350 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  5000 1350 5000
Wire Wire Line
	1350 4950 1350 5000
Connection ~ 1350 5000
Wire Wire Line
	1350 5000 1400 5000
$Comp
L power:VCC #PWR0106
U 1 1 5E5F6303
P 1400 5000
F 0 "#PWR0106" H 1400 4850 50  0001 C CNN
F 1 "VCC" V 1417 5128 50  0000 L CNN
F 2 "" H 1400 5000 50  0001 C CNN
F 3 "" H 1400 5000 50  0001 C CNN
	1    1400 5000
	0    1    1    0   
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5E5F66AD
P 1350 5450
F 0 "#FLG0102" H 1350 5525 50  0001 C CNN
F 1 "PWR_FLAG" H 1350 5623 50  0000 C CNN
F 2 "" H 1350 5450 50  0001 C CNN
F 3 "~" H 1350 5450 50  0001 C CNN
	1    1350 5450
	-1   0    0    1   
$EndComp
Wire Wire Line
	950  5400 1350 5400
Wire Wire Line
	1350 5450 1350 5400
Connection ~ 1350 5400
Wire Wire Line
	1350 5400 1400 5400
$Comp
L power:VCC #PWR0107
U 1 1 5E5F8397
P 950 4100
F 0 "#PWR0107" H 950 3950 50  0001 C CNN
F 1 "VCC" H 968 4273 50  0000 C CNN
F 2 "" H 950 4100 50  0001 C CNN
F 3 "" H 950 4100 50  0001 C CNN
	1    950  4100
	-1   0    0    1   
$EndComp
Wire Wire Line
	950  4100 950  4000
Wire Wire Line
	2750 1300 2750 950 
Wire Wire Line
	2750 950  2250 950 
Connection ~ 2250 950 
Wire Wire Line
	2250 950  2250 900 
Wire Wire Line
	3350 1000 3350 950 
Wire Wire Line
	3350 950  2750 950 
Connection ~ 2750 950 
Wire Wire Line
	3850 1300 3850 950 
Wire Wire Line
	3850 950  3350 950 
Connection ~ 3350 950 
Wire Wire Line
	2650 1700 2650 1800
Wire Wire Line
	2850 1700 2850 1900
Wire Wire Line
	3250 1400 3250 2000
Wire Wire Line
	3450 1400 3450 2100
Wire Wire Line
	3750 1700 3750 2200
Wire Wire Line
	3950 1700 3950 2300
Wire Wire Line
	2000 1800 2650 1800
Connection ~ 2650 1800
Wire Wire Line
	2650 1800 2650 2850
Wire Wire Line
	2000 1900 2850 1900
Connection ~ 2850 1900
Wire Wire Line
	2850 1900 2850 2950
Wire Wire Line
	2000 2000 3250 2000
Connection ~ 3250 2000
Wire Wire Line
	3250 2000 3250 3050
Wire Wire Line
	2000 2100 3450 2100
Connection ~ 3450 2100
Wire Wire Line
	3450 2100 3450 3150
Wire Wire Line
	2000 2200 3750 2200
Connection ~ 3750 2200
Wire Wire Line
	3750 2200 3750 3250
Wire Wire Line
	2000 2300 3950 2300
Connection ~ 3950 2300
Wire Wire Line
	3950 2300 3950 3350
Wire Wire Line
	1600 2300 1500 2300
Wire Wire Line
	1700 2600 2150 2600
Wire Wire Line
	1700 2750 2350 2750
Wire Wire Line
	1700 2850 2650 2850
Wire Wire Line
	1700 2950 2850 2950
Wire Wire Line
	1700 3050 3250 3050
Wire Wire Line
	1700 3150 3450 3150
Wire Wire Line
	1700 3250 3750 3250
Wire Wire Line
	1700 3350 3950 3350
Wire Wire Line
	1700 3750 1900 3750
Wire Wire Line
	600  4650 600  2650
NoConn ~ 600  2550
$Comp
L 74xx_IEEE:74165 U2
U 1 1 5E644BCB
P 4600 3450
F 0 "U2" H 4600 2335 50  0000 C CNN
F 1 "74165" H 4600 2426 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 4600 3450 50  0001 C CNN
F 3 "" H 4600 3450 50  0001 C CNN
	1    4600 3450
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Network08_US RN2
U 1 1 5E644BD7
P 5250 1900
F 0 "RN2" V 5775 1900 50  0000 C CNN
F 1 "10k x8" V 5684 1900 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP9" V 5725 1900 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 5250 1900 50  0001 C CNN
	1    5250 1900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5600 2600 5600 1600
Wire Wire Line
	5800 2750 5800 1700
Wire Wire Line
	5450 1700 5800 1700
Connection ~ 5800 1700
Wire Wire Line
	5800 1700 5800 1400
Wire Wire Line
	5450 1600 5600 1600
Connection ~ 5600 1600
Wire Wire Line
	5600 1600 5600 1400
$Comp
L power:GND #PWR0108
U 1 1 5E644BF7
P 4950 2300
F 0 "#PWR0108" H 4950 2050 50  0001 C CNN
F 1 "GND" H 4955 2127 50  0000 C CNN
F 2 "" H 4950 2300 50  0001 C CNN
F 3 "" H 4950 2300 50  0001 C CNN
	1    4950 2300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 5E644BFD
P 4600 4100
F 0 "#PWR0109" H 4600 3850 50  0001 C CNN
F 1 "GND" H 4605 3927 50  0000 C CNN
F 2 "" H 4600 4100 50  0001 C CNN
F 3 "" H 4600 4100 50  0001 C CNN
	1    4600 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 4100 4600 4000
$Comp
L power:GND #PWR0110
U 1 1 5E644C04
P 5350 3750
F 0 "#PWR0110" H 5350 3500 50  0001 C CNN
F 1 "GND" H 5355 3577 50  0000 C CNN
F 2 "" H 5350 3750 50  0001 C CNN
F 3 "" H 5350 3750 50  0001 C CNN
	1    5350 3750
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0111
U 1 1 5E644C0A
P 5700 900
F 0 "#PWR0111" H 5700 750 50  0001 C CNN
F 1 "VCC" H 5717 1073 50  0000 C CNN
F 2 "" H 5700 900 50  0001 C CNN
F 3 "" H 5700 900 50  0001 C CNN
	1    5700 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 1000 5700 950 
$Comp
L power:VCC #PWR0112
U 1 1 5E644C11
P 4400 4100
F 0 "#PWR0112" H 4400 3950 50  0001 C CNN
F 1 "VCC" H 4418 4273 50  0000 C CNN
F 2 "" H 4400 4100 50  0001 C CNN
F 3 "" H 4400 4100 50  0001 C CNN
	1    4400 4100
	-1   0    0    1   
$EndComp
Wire Wire Line
	4400 4100 4400 4000
Wire Wire Line
	6200 1300 6200 950 
Wire Wire Line
	6200 950  5700 950 
Connection ~ 5700 950 
Wire Wire Line
	5700 950  5700 900 
Wire Wire Line
	6800 1000 6800 950 
Wire Wire Line
	6800 950  6200 950 
Connection ~ 6200 950 
Wire Wire Line
	7300 1300 7300 950 
Wire Wire Line
	7300 950  6800 950 
Connection ~ 6800 950 
Wire Wire Line
	6100 1700 6100 1800
Wire Wire Line
	6300 1700 6300 1900
Wire Wire Line
	6700 1400 6700 2000
Wire Wire Line
	6900 1400 6900 2100
Wire Wire Line
	7200 1700 7200 2200
Wire Wire Line
	7400 1700 7400 2300
Wire Wire Line
	5450 1800 6100 1800
Connection ~ 6100 1800
Wire Wire Line
	6100 1800 6100 2850
Wire Wire Line
	5450 1900 6300 1900
Connection ~ 6300 1900
Wire Wire Line
	6300 1900 6300 2950
Wire Wire Line
	5450 2000 6700 2000
Connection ~ 6700 2000
Wire Wire Line
	6700 2000 6700 3050
Wire Wire Line
	5450 2100 6900 2100
Connection ~ 6900 2100
Wire Wire Line
	6900 2100 6900 3150
Wire Wire Line
	5450 2200 7200 2200
Connection ~ 7200 2200
Wire Wire Line
	7200 2200 7200 3250
Wire Wire Line
	5450 2300 7400 2300
Connection ~ 7400 2300
Wire Wire Line
	7400 2300 7400 3350
Wire Wire Line
	5050 2300 4950 2300
Wire Wire Line
	5150 2600 5600 2600
Wire Wire Line
	5150 2750 5800 2750
Wire Wire Line
	5150 2850 6100 2850
Wire Wire Line
	5150 2950 6300 2950
Wire Wire Line
	5150 3050 6700 3050
Wire Wire Line
	5150 3150 6900 3150
Wire Wire Line
	5150 3250 7200 3250
Wire Wire Line
	5150 3350 7400 3350
Wire Wire Line
	5150 3750 5350 3750
NoConn ~ 4050 2550
$Comp
L 74xx_IEEE:74165 U3
U 1 1 5E65EAD8
P 8050 3450
F 0 "U3" H 8050 2335 50  0000 C CNN
F 1 "74165" H 8050 2426 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 8050 3450 50  0001 C CNN
F 3 "" H 8050 3450 50  0001 C CNN
	1    8050 3450
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Network08_US RN3
U 1 1 5E65EAE4
P 8700 1900
F 0 "RN3" V 9225 1900 50  0000 C CNN
F 1 "10k x8" V 9134 1900 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP9" V 9175 1900 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 8700 1900 50  0001 C CNN
	1    8700 1900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9050 2600 9050 1600
Wire Wire Line
	9250 2750 9250 1700
Wire Wire Line
	8900 1700 9250 1700
Connection ~ 9250 1700
Wire Wire Line
	9250 1700 9250 1400
Wire Wire Line
	8900 1600 9050 1600
Connection ~ 9050 1600
Wire Wire Line
	9050 1600 9050 1400
$Comp
L power:GND #PWR0113
U 1 1 5E65EB04
P 8400 2300
F 0 "#PWR0113" H 8400 2050 50  0001 C CNN
F 1 "GND" H 8405 2127 50  0000 C CNN
F 2 "" H 8400 2300 50  0001 C CNN
F 3 "" H 8400 2300 50  0001 C CNN
	1    8400 2300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 5E65EB0A
P 8050 4100
F 0 "#PWR0114" H 8050 3850 50  0001 C CNN
F 1 "GND" H 8055 3927 50  0000 C CNN
F 2 "" H 8050 4100 50  0001 C CNN
F 3 "" H 8050 4100 50  0001 C CNN
	1    8050 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 4100 8050 4000
$Comp
L power:GND #PWR0115
U 1 1 5E65EB11
P 8800 3750
F 0 "#PWR0115" H 8800 3500 50  0001 C CNN
F 1 "GND" H 8805 3577 50  0000 C CNN
F 2 "" H 8800 3750 50  0001 C CNN
F 3 "" H 8800 3750 50  0001 C CNN
	1    8800 3750
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0116
U 1 1 5E65EB17
P 9150 900
F 0 "#PWR0116" H 9150 750 50  0001 C CNN
F 1 "VCC" H 9167 1073 50  0000 C CNN
F 2 "" H 9150 900 50  0001 C CNN
F 3 "" H 9150 900 50  0001 C CNN
	1    9150 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 1000 9150 950 
$Comp
L power:VCC #PWR0117
U 1 1 5E65EB1E
P 7850 4100
F 0 "#PWR0117" H 7850 3950 50  0001 C CNN
F 1 "VCC" H 7868 4273 50  0000 C CNN
F 2 "" H 7850 4100 50  0001 C CNN
F 3 "" H 7850 4100 50  0001 C CNN
	1    7850 4100
	-1   0    0    1   
$EndComp
Wire Wire Line
	7850 4100 7850 4000
Wire Wire Line
	9650 1300 9650 950 
Wire Wire Line
	9650 950  9150 950 
Connection ~ 9150 950 
Wire Wire Line
	9150 950  9150 900 
Wire Wire Line
	10250 1000 10250 950 
Wire Wire Line
	10250 950  9650 950 
Connection ~ 9650 950 
Wire Wire Line
	10750 1300 10750 950 
Wire Wire Line
	10750 950  10250 950 
Connection ~ 10250 950 
Wire Wire Line
	9550 1700 9550 1800
Wire Wire Line
	9750 1700 9750 1900
Wire Wire Line
	10150 1400 10150 2000
Wire Wire Line
	10350 1400 10350 2100
Wire Wire Line
	10650 1700 10650 2200
Wire Wire Line
	10850 1700 10850 2300
Wire Wire Line
	8900 1800 9550 1800
Connection ~ 9550 1800
Wire Wire Line
	9550 1800 9550 2850
Wire Wire Line
	8900 1900 9750 1900
Connection ~ 9750 1900
Wire Wire Line
	9750 1900 9750 2950
Wire Wire Line
	8900 2000 10150 2000
Connection ~ 10150 2000
Wire Wire Line
	10150 2000 10150 3050
Wire Wire Line
	8900 2100 10350 2100
Connection ~ 10350 2100
Wire Wire Line
	10350 2100 10350 3150
Wire Wire Line
	8900 2200 10650 2200
Connection ~ 10650 2200
Wire Wire Line
	10650 2200 10650 3250
Wire Wire Line
	8900 2300 10850 2300
Connection ~ 10850 2300
Wire Wire Line
	10850 2300 10850 3350
Wire Wire Line
	8500 2300 8400 2300
Wire Wire Line
	8600 2600 9050 2600
Wire Wire Line
	8600 2750 9250 2750
Wire Wire Line
	8600 2850 9550 2850
Wire Wire Line
	8600 2950 9750 2950
Wire Wire Line
	8600 3050 10150 3050
Wire Wire Line
	8600 3150 10350 3150
Wire Wire Line
	8600 3250 10650 3250
Wire Wire Line
	8600 3350 10850 3350
Wire Wire Line
	8600 3750 8800 3750
NoConn ~ 7500 2550
Connection ~ 5150 5300
Wire Wire Line
	5150 5300 8600 5300
Connection ~ 8600 5300
Wire Wire Line
	8600 5300 10200 5300
Wire Wire Line
	600  4650 1950 4650
Wire Wire Line
	7500 2650 7500 3450
Wire Wire Line
	7500 3450 5150 3450
Wire Wire Line
	4050 2650 4050 3450
Wire Wire Line
	4050 3450 1700 3450
$Comp
L power:GND #PWR0118
U 1 1 5E6FF2AE
P 10100 5400
F 0 "#PWR0118" H 10100 5150 50  0001 C CNN
F 1 "GND" V 10105 5272 50  0000 R CNN
F 2 "" H 10100 5400 50  0001 C CNN
F 3 "" H 10100 5400 50  0001 C CNN
	1    10100 5400
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR0119
U 1 1 5E6FF9F9
P 10100 5000
F 0 "#PWR0119" H 10100 4850 50  0001 C CNN
F 1 "VCC" V 10118 5127 50  0000 L CNN
F 2 "" H 10100 5000 50  0001 C CNN
F 3 "" H 10100 5000 50  0001 C CNN
	1    10100 5000
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10100 5400 10200 5400
$Comp
L pspice:C C1
U 1 1 5E70D174
P 2700 6800
F 0 "C1" H 2878 6846 50  0000 L CNN
F 1 "0.1μF" H 2878 6755 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 2700 6800 50  0001 C CNN
F 3 "~" H 2700 6800 50  0001 C CNN
	1    2700 6800
	1    0    0    -1  
$EndComp
$Comp
L pspice:C C2
U 1 1 5E7104A9
P 3400 6800
F 0 "C2" H 3578 6846 50  0000 L CNN
F 1 "0.1μF" H 3578 6755 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3400 6800 50  0001 C CNN
F 3 "~" H 3400 6800 50  0001 C CNN
	1    3400 6800
	1    0    0    -1  
$EndComp
$Comp
L pspice:C C3
U 1 1 5E710D52
P 4100 6800
F 0 "C3" H 4278 6846 50  0000 L CNN
F 1 "0.1μF" H 4278 6755 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 4100 6800 50  0001 C CNN
F 3 "~" H 4100 6800 50  0001 C CNN
	1    4100 6800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0120
U 1 1 5E7112C5
P 2700 7150
F 0 "#PWR0120" H 2700 6900 50  0001 C CNN
F 1 "GND" H 2705 6977 50  0000 C CNN
F 2 "" H 2700 7150 50  0001 C CNN
F 3 "" H 2700 7150 50  0001 C CNN
	1    2700 7150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0121
U 1 1 5E711C1C
P 2700 6450
F 0 "#PWR0121" H 2700 6300 50  0001 C CNN
F 1 "VCC" H 2717 6623 50  0000 C CNN
F 2 "" H 2700 6450 50  0001 C CNN
F 3 "" H 2700 6450 50  0001 C CNN
	1    2700 6450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 7050 2700 7100
Wire Wire Line
	2700 6450 2700 6500
Wire Wire Line
	3400 6550 3400 6500
Wire Wire Line
	3400 6500 2700 6500
Connection ~ 2700 6500
Wire Wire Line
	2700 6500 2700 6550
Wire Wire Line
	4100 6550 4100 6500
Wire Wire Line
	4100 6500 3400 6500
Connection ~ 3400 6500
Wire Wire Line
	3400 7050 3400 7100
Wire Wire Line
	3400 7100 2700 7100
Connection ~ 2700 7100
Wire Wire Line
	2700 7100 2700 7150
Wire Wire Line
	4100 7050 4100 7100
Wire Wire Line
	4100 7100 3400 7100
Connection ~ 3400 7100
$Comp
L Device:R_US R1
U 1 1 5E73DD7B
P 9550 4750
F 0 "R1" H 9618 4796 50  0000 L CNN
F 1 "10k" H 9618 4705 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 9590 4740 50  0001 C CNN
F 3 "~" H 9550 4750 50  0001 C CNN
	1    9550 4750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0122
U 1 1 5E73E6C4
P 9550 4450
F 0 "#PWR0122" H 9550 4300 50  0001 C CNN
F 1 "VCC" H 9567 4623 50  0000 C CNN
F 2 "" H 9550 4450 50  0001 C CNN
F 3 "" H 9550 4450 50  0001 C CNN
	1    9550 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 4600 9550 4450
Wire Wire Line
	8600 3650 9050 3650
Wire Wire Line
	8600 3450 9250 3450
Wire Wire Line
	5150 3650 5600 3650
$Comp
L Switch:SW_SPDT SW12
U 1 1 5E65EAF6
P 10750 1500
F 0 "SW12" V 10704 1648 50  0000 L CNN
F 1 "SW_SPDT" V 10795 1648 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 10750 1500 50  0001 C CNN
F 3 "~" H 10750 1500 50  0001 C CNN
	1    10750 1500
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW11
U 1 1 5E65EAF0
P 10250 1200
F 0 "SW11" V 10204 1348 50  0000 L CNN
F 1 "SW_SPDT" V 10295 1348 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 10250 1200 50  0001 C CNN
F 3 "~" H 10250 1200 50  0001 C CNN
	1    10250 1200
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW10
U 1 1 5E65EAEA
P 9650 1500
F 0 "SW10" V 9604 1648 50  0000 L CNN
F 1 "SW_SPDT" V 9695 1648 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 9650 1500 50  0001 C CNN
F 3 "~" H 9650 1500 50  0001 C CNN
	1    9650 1500
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW9
U 1 1 5E65EADE
P 9150 1200
F 0 "SW9" V 9104 1348 50  0000 L CNN
F 1 "SW_SPDT" V 9195 1348 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 9150 1200 50  0001 C CNN
F 3 "~" H 9150 1200 50  0001 C CNN
	1    9150 1200
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW8
U 1 1 5E644BE9
P 7300 1500
F 0 "SW8" V 7254 1648 50  0000 L CNN
F 1 "SW_SPDT" V 7345 1648 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 7300 1500 50  0001 C CNN
F 3 "~" H 7300 1500 50  0001 C CNN
	1    7300 1500
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW7
U 1 1 5E644BE3
P 6800 1200
F 0 "SW7" V 6754 1348 50  0000 L CNN
F 1 "SW_SPDT" V 6845 1348 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 6800 1200 50  0001 C CNN
F 3 "~" H 6800 1200 50  0001 C CNN
	1    6800 1200
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW6
U 1 1 5E644BDD
P 6200 1500
F 0 "SW6" V 6154 1648 50  0000 L CNN
F 1 "SW_SPDT" V 6245 1648 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 6200 1500 50  0001 C CNN
F 3 "~" H 6200 1500 50  0001 C CNN
	1    6200 1500
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW5
U 1 1 5E644BD1
P 5700 1200
F 0 "SW5" V 5654 1348 50  0000 L CNN
F 1 "SW_SPDT" V 5745 1348 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 5700 1200 50  0001 C CNN
F 3 "~" H 5700 1200 50  0001 C CNN
	1    5700 1200
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW4
U 1 1 5E5DF24E
P 3850 1500
F 0 "SW4" V 3804 1648 50  0000 L CNN
F 1 "SW_SPDT" V 3895 1648 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 3850 1500 50  0001 C CNN
F 3 "~" H 3850 1500 50  0001 C CNN
	1    3850 1500
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW3
U 1 1 5E5DF248
P 3350 1200
F 0 "SW3" V 3304 1348 50  0000 L CNN
F 1 "SW_SPDT" V 3395 1348 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 3350 1200 50  0001 C CNN
F 3 "~" H 3350 1200 50  0001 C CNN
	1    3350 1200
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW2
U 1 1 5E5DDF8E
P 2750 1500
F 0 "SW2" V 2704 1648 50  0000 L CNN
F 1 "SW_SPDT" V 2795 1648 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 2750 1500 50  0001 C CNN
F 3 "~" H 2750 1500 50  0001 C CNN
	1    2750 1500
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_SPDT SW1
U 1 1 5E5D321F
P 2250 1200
F 0 "SW1" V 2204 1348 50  0000 L CNN
F 1 "SW_SPDT" V 2295 1348 50  0000 L CNN
F 2 "piano-keyboard-pcb-v2:keysw213" H 2250 1200 50  0001 C CNN
F 3 "~" H 2250 1200 50  0001 C CNN
	1    2250 1200
	0    1    1    0   
$EndComp
Wire Wire Line
	1700 3650 2150 3650
Wire Wire Line
	10100 5000 10200 5000
Wire Wire Line
	2150 5200 950  5200
Wire Wire Line
	950  5300 2050 5300
Wire Wire Line
	1700 3900 2050 3900
Connection ~ 2050 5300
Wire Wire Line
	2050 5300 5150 5300
Wire Wire Line
	10200 5200 9050 5200
Connection ~ 9050 5200
Connection ~ 2150 5200
Wire Wire Line
	9050 5200 5600 5200
Wire Wire Line
	5600 5200 2150 5200
Connection ~ 5600 5200
Wire Wire Line
	2050 3900 2050 5300
Wire Wire Line
	2150 3650 2150 5200
Wire Wire Line
	5150 3900 5150 5300
Wire Wire Line
	5600 3650 5600 5200
Wire Wire Line
	8600 3900 8600 5300
Wire Wire Line
	9050 3650 9050 5200
Wire Wire Line
	10200 5100 9550 5100
Wire Wire Line
	9250 3450 9250 5100
Wire Wire Line
	9550 4900 9550 5100
Connection ~ 9550 5100
Wire Wire Line
	9550 5100 9250 5100
Wire Wire Line
	950  5100 1950 5100
Wire Wire Line
	1950 5100 1950 4650
Text Label 950  5100 0    50   ~ 0
DATA_OUT
Text Label 950  5200 0    50   ~ 0
CLOCK
Text Label 950  5300 0    50   ~ 0
SHIFT
Text Label 10200 5100 2    50   ~ 0
DATA_IN
Text Label 10200 5200 2    50   ~ 0
CLOCK
Text Label 10200 5300 2    50   ~ 0
SHIFT
$EndSCHEMATC
