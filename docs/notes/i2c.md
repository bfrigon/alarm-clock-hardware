Devices address on bus i2c-0
============================

---------|------|-------|----------------|------|----------------|-------------------------------------------------------------------
Address  | Read | Write | Board          | Name | Device         | Description
---------|------|-------|----------------|------|----------------|-------------------------------------------------------------------
0101001X | 0x83 | 0x82  | CLK-PC-07      | U1   | TSL2561FN      | Ambient light sensor
1010001X | 0xA3 | 0xA2  | CLK-PC-07      | U2   | PCA9634PW      | 8-bit led dimmer for rgb lights,am-pm led ,alarm led and dots
1101000X | 0xD1 | 0xD0  | CLK-PC-05,#1   | U1   | PCA9634PW      | 8-bit led dimmer for 7 segment digit #1
1101001X | 0xD3 | 0xD2  | CLK-PC-05,#3   | U1   | PCA9634PW      | 8-bit led dimmer for 7 segment digit #3
1101010X | 0xD5 | 0xD4  | CLK-PC-05,#2   | U1   | PCA9634PW      | 8-bit led dimmer for 7 segment digit #2
1101011X | 0xD7 | 0xD6  | CLK-PC-05,#4   | U1   | PCA9634PW      | 8-bit led dimmer for 7 segment digit #4
0011111X | 0x3F | 0x3E  | CLK-PC-07      | U9   | MCP9804-E/MS   | Digital temperature sensor


Global call addresses used by PCA3634 :

---------|------|-------|-----------------------------------
Address  | Read | Write | Description
---------|------|-------|-----------------------------------
1110000X | 0xE1 | 0xE0  | All PCA9634PW devices
1110001X | 0xE3 | 0xE2  | Sub group #1
1110010X | 0xE5 | 0xE4  | Sub group #2
1110100X | 0xE9 | 0xE8  | Sub group #3