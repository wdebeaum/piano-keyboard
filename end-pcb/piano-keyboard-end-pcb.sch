EESchema Schematic File Version 4
LIBS:piano-keyboard-end-pcb-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Modular Piano Keyboard End"
Date "2020-06-06"
Rev "v2"
Comp ""
Comment1 ""
Comment2 "creativecommons.org/licenses/by/4.0/"
Comment3 "License: CC BY 4.0"
Comment4 "Author: William de Beaumont"
$EndDescr
$Comp
L Connector:Conn_01x05_Female J6
U 1 1 5E5EDAC0
P 10400 5200
F 0 "J6" H 10428 5226 50  0000 L CNN
F 1 "Conn_01x05_Female" H 10428 5135 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x05_P2.54mm_Horizontal" H 10400 5200 50  0001 C CNN
F 3 "~" H 10400 5200 50  0001 C CNN
	1    10400 5200
	1    0    0    -1  
$EndComp
$Comp
L 74xx_IEEE:74165 U1
U 1 1 5E65EAD8
P 6750 3450
F 0 "U1" H 6750 2335 50  0000 C CNN
F 1 "74165" H 6750 2426 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 6750 3450 50  0001 C CNN
F 3 "" H 6750 3450 50  0001 C CNN
	1    6750 3450
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Network08_US RN1
U 1 1 5E65EAE4
P 7400 1900
F 0 "RN1" V 7925 1900 50  0000 C CNN
F 1 "10k x8" V 7834 1900 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP9" V 7875 1900 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 7400 1900 50  0001 C CNN
	1    7400 1900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7750 2600 7750 1600
Wire Wire Line
	8150 2750 8150 1700
Wire Wire Line
	7600 1600 7750 1600
$Comp
L power:GND #PWR013
U 1 1 5E65EB04
P 7100 2300
F 0 "#PWR013" H 7100 2050 50  0001 C CNN
F 1 "GND" H 7105 2127 50  0000 C CNN
F 2 "" H 7100 2300 50  0001 C CNN
F 3 "" H 7100 2300 50  0001 C CNN
	1    7100 2300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR012
U 1 1 5E65EB0A
P 6750 4100
F 0 "#PWR012" H 6750 3850 50  0001 C CNN
F 1 "GND" H 6755 3927 50  0000 C CNN
F 2 "" H 6750 4100 50  0001 C CNN
F 3 "" H 6750 4100 50  0001 C CNN
	1    6750 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 4100 6750 4000
$Comp
L power:GND #PWR014
U 1 1 5E65EB11
P 7500 3750
F 0 "#PWR014" H 7500 3500 50  0001 C CNN
F 1 "GND" H 7505 3577 50  0000 C CNN
F 2 "" H 7500 3750 50  0001 C CNN
F 3 "" H 7500 3750 50  0001 C CNN
	1    7500 3750
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR011
U 1 1 5E65EB1E
P 6550 4100
F 0 "#PWR011" H 6550 3950 50  0001 C CNN
F 1 "VCC" H 6568 4273 50  0000 C CNN
F 2 "" H 6550 4100 50  0001 C CNN
F 3 "" H 6550 4100 50  0001 C CNN
	1    6550 4100
	-1   0    0    1   
$EndComp
Wire Wire Line
	6550 4100 6550 4000
Connection ~ 8650 1800
Wire Wire Line
	8650 1800 8650 2850
Connection ~ 9050 1900
Wire Wire Line
	9050 1900 9050 2950
Wire Wire Line
	9450 2000 9450 3050
Wire Wire Line
	9850 2100 9850 3150
Connection ~ 10150 2200
Wire Wire Line
	10150 2200 10150 3250
Connection ~ 10550 2300
Wire Wire Line
	10550 2300 10550 3350
Wire Wire Line
	7200 2300 7100 2300
Wire Wire Line
	7300 2600 7750 2600
Wire Wire Line
	7300 3750 7500 3750
NoConn ~ 6200 2550
$Comp
L power:GND #PWR017
U 1 1 5E6FF2AE
P 10100 5400
F 0 "#PWR017" H 10100 5150 50  0001 C CNN
F 1 "GND" V 10105 5272 50  0000 R CNN
F 2 "" H 10100 5400 50  0001 C CNN
F 3 "" H 10100 5400 50  0001 C CNN
	1    10100 5400
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR016
U 1 1 5E6FF9F9
P 10100 5000
F 0 "#PWR016" H 10100 4850 50  0001 C CNN
F 1 "VCC" V 10118 5127 50  0000 L CNN
F 2 "" H 10100 5000 50  0001 C CNN
F 3 "" H 10100 5000 50  0001 C CNN
	1    10100 5000
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10100 5400 10200 5400
Wire Wire Line
	7300 3650 7750 3650
Wire Wire Line
	7300 3450 7950 3450
Wire Wire Line
	10100 5000 10200 5000
Wire Wire Line
	7300 3900 7300 5300
Wire Wire Line
	7750 3650 7750 5200
Wire Wire Line
	7950 3450 7950 5100
Text Label 10200 5100 2    50   ~ 0
DATA_IN
Text Label 10200 5200 2    50   ~ 0
CLOCK
Text Label 10200 5300 2    50   ~ 0
SHIFT
$Comp
L Connector:Conn_01x03_Male J1
U 1 1 5EDDCBA7
P 2800 2650
F 0 "J1" H 2908 2931 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2908 2840 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 2800 2650 50  0001 C CNN
F 3 "~" H 2800 2650 50  0001 C CNN
	1    2800 2650
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J3
U 1 1 5EDDE3D9
P 2800 3550
F 0 "J3" H 2908 3731 50  0000 C CNN
F 1 "Conn_01x02_Male" H 2908 3640 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 2800 3550 50  0001 C CNN
F 3 "~" H 2800 3550 50  0001 C CNN
	1    2800 3550
	1    0    0    -1  
$EndComp
Text Label 3000 2550 0    50   ~ 0
SCK-CLOCK
Text Label 3000 2650 0    50   ~ 0
A0-PITCH
Text Label 3000 2750 0    50   ~ 0
A1-MOD
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5EDE80D3
P 3650 3550
F 0 "#FLG02" H 3650 3625 50  0001 C CNN
F 1 "PWR_FLAG" H 3650 3723 50  0000 C CNN
F 2 "" H 3650 3550 50  0001 C CNN
F 3 "~" H 3650 3550 50  0001 C CNN
	1    3650 3550
	1    0    0    -1  
$EndComp
Connection ~ 3650 3550
Wire Wire Line
	3650 3550 3800 3550
$Comp
L power:PWR_FLAG #FLG03
U 1 1 5EDE8340
P 3650 3650
F 0 "#FLG03" H 3650 3725 50  0001 C CNN
F 1 "PWR_FLAG" H 3650 3823 50  0000 C CNN
F 2 "" H 3650 3650 50  0001 C CNN
F 3 "~" H 3650 3650 50  0001 C CNN
	1    3650 3650
	-1   0    0    1   
$EndComp
Connection ~ 3650 3650
Wire Wire Line
	3650 3650 3800 3650
$Comp
L power:GND #PWR03
U 1 1 5EDE8643
P 4100 3500
F 0 "#PWR03" H 4100 3250 50  0001 C CNN
F 1 "GND" H 4105 3327 50  0000 C CNN
F 2 "" H 4100 3500 50  0001 C CNN
F 3 "" H 4100 3500 50  0001 C CNN
	1    4100 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 3550 3800 3450
Wire Wire Line
	3800 3450 4100 3450
Wire Wire Line
	4100 3450 4100 3500
Wire Wire Line
	3800 3650 3800 3800
Wire Wire Line
	3800 3800 3900 3800
Wire Wire Line
	3900 3800 3900 3700
$Comp
L Device:R_POT_US RV1
U 1 1 5EDF0383
P 3900 1350
F 0 "RV1" H 3833 1396 50  0000 R CNN
F 1 "R_POT_US" H 3833 1305 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_PTV09A-2_Single_Horizontal" H 3900 1350 50  0001 C CNN
F 3 "~" H 3900 1350 50  0001 C CNN
	1    3900 1350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5EDF4D3B
P 3900 1600
F 0 "#PWR05" H 3900 1350 50  0001 C CNN
F 1 "GND" H 3905 1427 50  0000 C CNN
F 2 "" H 3900 1600 50  0001 C CNN
F 3 "" H 3900 1600 50  0001 C CNN
	1    3900 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 1200 3900 1100
Wire Wire Line
	3900 1500 3900 1600
$Comp
L Device:R_POT_US RV2
U 1 1 5EDFA29D
P 4550 1350
F 0 "RV2" H 4483 1396 50  0000 R CNN
F 1 "R_POT_US" H 4483 1305 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_PTV09A-2_Single_Horizontal" H 4550 1350 50  0001 C CNN
F 3 "~" H 4550 1350 50  0001 C CNN
	1    4550 1350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5EDFA2A3
P 4550 1600
F 0 "#PWR07" H 4550 1350 50  0001 C CNN
F 1 "GND" H 4555 1427 50  0000 C CNN
F 2 "" H 4550 1600 50  0001 C CNN
F 3 "" H 4550 1600 50  0001 C CNN
	1    4550 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 1200 4550 1100
Wire Wire Line
	4550 1500 4550 1600
Wire Wire Line
	4050 2650 4050 1350
Wire Wire Line
	3000 2650 4050 2650
Wire Wire Line
	4700 2750 4700 1350
Wire Wire Line
	3000 2750 4700 2750
Wire Wire Line
	5500 2550 5500 5200
Text Label 3000 4150 0    50   ~ 0
MISO-DATA_OUT
Text Label 3000 4400 0    50   ~ 0
9-SHIFT
Wire Wire Line
	5450 5300 7300 5300
$Comp
L Connector:AudioJack2 J7
U 1 1 5EE1C0C0
P 10950 950
F 0 "J7" H 10982 1275 50  0000 C CNN
F 1 "AudioJack2" H 10982 1184 50  0000 C CNN
F 2 "piano-keyboard-end-pcb:Switchcraft_RA49B11" H 10950 950 50  0001 C CNN
F 3 "~" H 10950 950 50  0001 C CNN
	1    10950 950 
	-1   0    0    1   
$EndComp
$Comp
L Switch:SW_Push SW7
U 1 1 5EE1D0FD
P 7750 850
F 0 "SW7" V 7704 998 50  0000 L CNN
F 1 "SW_Push" V 7795 998 50  0000 L CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 7750 1050 50  0001 C CNN
F 3 "~" H 7750 1050 50  0001 C CNN
	1    7750 850 
	0    1    1    0   
$EndComp
Wire Wire Line
	3000 2550 5500 2550
Wire Wire Line
	3000 4150 5700 4150
Connection ~ 7300 5300
Connection ~ 7750 5200
Wire Wire Line
	7300 5300 10200 5300
Wire Wire Line
	7750 5200 10200 5200
Wire Wire Line
	5500 5200 7750 5200
Wire Wire Line
	7600 1700 8150 1700
Wire Wire Line
	7600 1800 8650 1800
Wire Wire Line
	7600 1900 9050 1900
Wire Wire Line
	7600 2000 9450 2000
Wire Wire Line
	7600 2100 9850 2100
Wire Wire Line
	7600 2200 10150 2200
Wire Wire Line
	7600 2300 10550 2300
Wire Wire Line
	7300 2750 8150 2750
Wire Wire Line
	7300 2850 8650 2850
Wire Wire Line
	7300 2950 9050 2950
Wire Wire Line
	7300 3050 9450 3050
Wire Wire Line
	7300 3150 9850 3150
Wire Wire Line
	7300 3250 10150 3250
Wire Wire Line
	7300 3350 10550 3350
$Comp
L Switch:SW_Push SW6
U 1 1 5EE6489C
P 8150 1200
F 0 "SW6" V 8104 1348 50  0000 L CNN
F 1 "SW_Push" V 8195 1348 50  0000 L CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 8150 1400 50  0001 C CNN
F 3 "~" H 8150 1400 50  0001 C CNN
	1    8150 1200
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_Push SW5
U 1 1 5EE676A9
P 8650 850
F 0 "SW5" V 8604 998 50  0000 L CNN
F 1 "SW_Push" V 8695 998 50  0000 L CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 8650 1050 50  0001 C CNN
F 3 "~" H 8650 1050 50  0001 C CNN
	1    8650 850 
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_Push SW4
U 1 1 5EE676AF
P 9050 1200
F 0 "SW4" V 9004 1348 50  0000 L CNN
F 1 "SW_Push" V 9095 1348 50  0000 L CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 9050 1400 50  0001 C CNN
F 3 "~" H 9050 1400 50  0001 C CNN
	1    9050 1200
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_Push SW3
U 1 1 5EE6C3B8
P 9450 850
F 0 "SW3" V 9404 998 50  0000 L CNN
F 1 "SW_Push" V 9495 998 50  0000 L CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 9450 1050 50  0001 C CNN
F 3 "~" H 9450 1050 50  0001 C CNN
	1    9450 850 
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 5EE6C3BE
P 9850 1200
F 0 "SW2" V 9804 1348 50  0000 L CNN
F 1 "SW_Push" V 9895 1348 50  0000 L CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 9850 1400 50  0001 C CNN
F 3 "~" H 9850 1400 50  0001 C CNN
	1    9850 1200
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 5EE7093D
P 10150 850
F 0 "SW1" V 10104 998 50  0000 L CNN
F 1 "SW_Push" V 10195 998 50  0000 L CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 10150 1050 50  0001 C CNN
F 3 "~" H 10150 1050 50  0001 C CNN
	1    10150 850 
	0    1    1    0   
$EndComp
Wire Wire Line
	7750 1050 7750 1600
Connection ~ 7750 1600
Wire Wire Line
	8150 1400 8150 1700
Connection ~ 8150 1700
Wire Wire Line
	8650 1050 8650 1800
Wire Wire Line
	9050 1400 9050 1900
Wire Wire Line
	9450 1050 9450 2000
Connection ~ 9450 2000
Wire Wire Line
	9850 1400 9850 2100
Connection ~ 9850 2100
Wire Wire Line
	10150 1050 10150 2200
Wire Wire Line
	10550 1050 10750 1050
Wire Wire Line
	10750 950  10750 650 
Wire Wire Line
	10750 650  10150 650 
Wire Wire Line
	7750 650  8150 650 
Connection ~ 10150 650 
Connection ~ 8650 650 
Wire Wire Line
	8650 650  9050 650 
Connection ~ 9450 650 
Wire Wire Line
	9450 650  9850 650 
Wire Wire Line
	9850 1000 9850 650 
Connection ~ 9850 650 
Wire Wire Line
	9850 650  10150 650 
Wire Wire Line
	9050 1000 9050 650 
Connection ~ 9050 650 
Wire Wire Line
	9050 650  9450 650 
Wire Wire Line
	8150 1000 8150 650 
Connection ~ 8150 650 
Wire Wire Line
	8150 650  8650 650 
$Comp
L power:VCC #PWR015
U 1 1 5EE8EBBA
P 7550 650
F 0 "#PWR015" H 7550 500 50  0001 C CNN
F 1 "VCC" V 7568 777 50  0000 L CNN
F 2 "" H 7550 650 50  0001 C CNN
F 3 "" H 7550 650 50  0001 C CNN
	1    7550 650 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7550 650  7750 650 
Connection ~ 7750 650 
Wire Wire Line
	10550 1050 10550 2300
$Comp
L pspice:C C1
U 1 1 5E70D174
P 6400 1600
F 0 "C1" H 6578 1646 50  0000 L CNN
F 1 "0.1μF" H 6578 1555 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 6400 1600 50  0001 C CNN
F 3 "~" H 6400 1600 50  0001 C CNN
	1    6400 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5E7112C5
P 6400 1950
F 0 "#PWR010" H 6400 1700 50  0001 C CNN
F 1 "GND" H 6405 1777 50  0000 C CNN
F 2 "" H 6400 1950 50  0001 C CNN
F 3 "" H 6400 1950 50  0001 C CNN
	1    6400 1950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR09
U 1 1 5E711C1C
P 6400 1250
F 0 "#PWR09" H 6400 1100 50  0001 C CNN
F 1 "VCC" H 6417 1423 50  0000 C CNN
F 2 "" H 6400 1250 50  0001 C CNN
F 3 "" H 6400 1250 50  0001 C CNN
	1    6400 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 1250 6400 1350
Wire Wire Line
	6400 1850 6400 1950
Wire Wire Line
	7950 5100 10200 5100
Wire Wire Line
	3000 3550 3650 3550
Wire Wire Line
	3000 3650 3650 3650
Text Label 3000 3550 0    50   ~ 0
GND
Text Label 3000 3650 0    50   ~ 0
3.3V
$Comp
L Connector:Conn_01x01_Male J4
U 1 1 5EE819A7
P 2800 4150
F 0 "J4" H 2908 4331 50  0000 C CNN
F 1 "Conn_01x01_Male" H 2908 4240 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x01_P2.54mm_Vertical" H 2800 4150 50  0001 C CNN
F 3 "~" H 2800 4150 50  0001 C CNN
	1    2800 4150
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x01_Male J5
U 1 1 5EE8217E
P 2800 4400
F 0 "J5" H 2908 4581 50  0000 C CNN
F 1 "Conn_01x01_Male" H 2908 4490 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x01_P2.54mm_Vertical" H 2800 4400 50  0001 C CNN
F 3 "~" H 2800 4400 50  0001 C CNN
	1    2800 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 4400 5450 5300
Wire Wire Line
	3000 4400 5450 4400
$Comp
L power:VCC #PWR?
U 1 1 5F132000
P 3900 3700
F 0 "#PWR?" H 3900 3550 50  0001 C CNN
F 1 "VCC" H 3917 3873 50  0000 C CNN
F 2 "" H 3900 3700 50  0001 C CNN
F 3 "" H 3900 3700 50  0001 C CNN
	1    3900 3700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5F137220
P 3900 1100
F 0 "#PWR?" H 3900 950 50  0001 C CNN
F 1 "VCC" H 3917 1273 50  0000 C CNN
F 2 "" H 3900 1100 50  0001 C CNN
F 3 "" H 3900 1100 50  0001 C CNN
	1    3900 1100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5F1375ED
P 4550 1100
F 0 "#PWR?" H 4550 950 50  0001 C CNN
F 1 "VCC" H 4567 1273 50  0000 C CNN
F 2 "" H 4550 1100 50  0001 C CNN
F 3 "" H 4550 1100 50  0001 C CNN
	1    4550 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 2650 6200 2650
Wire Wire Line
	5700 2650 5700 4150
$EndSCHEMATC
