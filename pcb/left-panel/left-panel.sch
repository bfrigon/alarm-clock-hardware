EESchema Schematic File Version 2
LIBS:connectors
LIBS:ic-cpu
LIBS:ic-power
LIBS:passive
LIBS:power
LIBS:switches
LIBS:left-panel-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "LEFT PANEL"
Date "Thu 19 Mar 2015"
Rev "A"
Comp ""
Comment1 "CLK-PC-04"
Comment2 "CLK-SCH-04"
Comment3 "ALARM CLOCK"
Comment4 ""
$EndDescr
$Comp
L HEADER-1x04 J1
U 1 1 54E037EF
P 6500 5050
F 0 "J1" H 6450 5300 60  0000 L BNB
F 1 "DF3A-4P-2DSA" V 6650 5050 40  0000 C CNN
F 2 "Conn-Hirose:DF3A-4P-2DSA" H 6500 5050 60  0001 C CNN
F 3 "" H 6500 5050 60  0001 C CNN
F 4 "Connector" H 6500 5050 60  0001 C CNN "Family"
F 5 "Hirose" H 6500 5050 60  0001 C CNN "MFG"
	1    6500 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 5200 6350 5200
Wire Wire Line
	4450 2500 4450 5200
Wire Wire Line
	4450 3950 4950 3950
Wire Wire Line
	4450 3250 4950 3250
Connection ~ 4450 3950
Wire Wire Line
	4450 2500 4950 2500
Connection ~ 4450 3250
Wire Wire Line
	5150 3950 5850 3950
Wire Wire Line
	5850 3950 5850 5100
Wire Wire Line
	5850 5100 6350 5100
Wire Wire Line
	5150 3250 5950 3250
Wire Wire Line
	5950 3250 5950 5000
Wire Wire Line
	5950 5000 6350 5000
Wire Wire Line
	5150 2500 6050 2500
Wire Wire Line
	6050 2500 6050 4900
Wire Wire Line
	6050 4900 6350 4900
Text Label 5350 2500 0    60   ~ 0
MUTE
Text Label 5350 3250 0    60   ~ 0
VOL-
Text Label 5350 3950 0    60   ~ 0
VOL+
Text Label 5350 5200 0    60   ~ 0
~SSPND
$Comp
L MOM-SPST-GND SW1
U 1 1 54E06BA8
P 5050 2500
F 0 "SW1" H 5125 2600 60  0000 L BNB
F 1 "B3F-3150" H 5125 2400 40  0000 L TNN
F 2 "Switches:B3F-315X" H 5125 2325 40  0001 L TNN
F 3 "" H 4950 2600 60  0001 C CNN
F 4 "Switch" H 5050 2500 60  0001 C CNN "Family"
	1    5050 2500
	1    0    0    -1  
$EndComp
$Comp
L MOM-SPST-GND SW2
U 1 1 54E06CF8
P 5050 3250
F 0 "SW2" H 5125 3350 60  0000 L BNB
F 1 "B3F-3150" H 5125 3150 40  0000 L TNN
F 2 "Switches:B3F-315X" H 5125 3075 40  0001 L TNN
F 3 "" H 4950 3350 60  0001 C CNN
F 4 "Switch" H 5050 3250 60  0001 C CNN "Family"
	1    5050 3250
	1    0    0    -1  
$EndComp
$Comp
L MOM-SPST-GND SW3
U 1 1 54E06D88
P 5050 3950
F 0 "SW3" H 5125 4050 60  0000 L BNB
F 1 "B3F-3150" H 5125 3850 40  0000 L TNN
F 2 "Switches:B3F-315X" H 5125 3775 40  0001 L TNN
F 3 "" H 4950 4050 60  0001 C CNN
F 4 "Switch" H 5050 3950 60  0001 C CNN "Family"
	1    5050 3950
	1    0    0    -1  
$EndComp
NoConn ~ 5050 2600
NoConn ~ 5050 3350
NoConn ~ 5050 4050
$Comp
L Hole H1
U 1 1 550951CD
P 8450 1800
F 0 "H1" H 8400 1900 60  0000 L BNB
F 1 "Hole" H 8500 1700 40  0001 L TNN
F 2 "Conn-Wire-Pads:Hole-Screw-NP-#4" H 8500 1625 40  0001 L TNN
F 3 "" H 8400 1875 60  0001 C CNN
F 4 "Virtual" H 8450 1800 60  0001 C CNN "Family"
	1    8450 1800
	1    0    0    -1  
$EndComp
$Comp
L Hole H2
U 1 1 55095353
P 8900 1800
F 0 "H2" H 8850 1900 60  0000 L BNB
F 1 "Hole" H 8950 1700 40  0001 L TNN
F 2 "Conn-Wire-Pads:Hole-Screw-NP-#4" H 8950 1625 40  0001 L TNN
F 3 "" H 8850 1875 60  0001 C CNN
F 4 "Virtual" H 8900 1800 60  0001 C CNN "Family"
	1    8900 1800
	1    0    0    -1  
$EndComp
NoConn ~ 8450 1950
NoConn ~ 8900 1950
$EndSCHEMATC
