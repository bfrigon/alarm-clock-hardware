;******************************************************************************
;*   Project:      PBX Front panel lcd                                        *
;*   Version:      0.1                                                        *
;*                                                                            *
;*   Filename:     delay.asm                                                  *
;*   Description:  Delay subroutines                                          *
;*   Last mod:     11 august 2012                                             *
;*                                                                            *
;*   Author:       Benoit Frigon                                              *
;*   Email:        <bfrigon@gmail.com>                                        *
;*                                                                            *
;******************************************************************************
processor 16f1826
#include <p16f1826.inc>



;==============================================================================
;==============================================================================
;
;                                   Symbols 
;------------------------------------------------------------------------------
; *** Subroutines ***
GLOBAL  delay10tcy
GLOBAL  delay100tcy
GLOBAL  delay1ktcy
GLOBAL  delay10ktcy



;==============================================================================
;==============================================================================
;
;                                     Data   
;------------------------------------------------------------------------------
.d_delay		UDATA
d1            	RES		0x01				; Delay counters
d2            	RES		0x01				; 
d3            	RES		0x01				;  



;==============================================================================
;==============================================================================
;
;                                Subroutines 
;------------------------------------------------------------------------------		
.c_delay		CODE
  

;******************************************************************************
; delay10tcy : delay 10 cycles (1.25us @ 32Mhz)
;
; Arguments : W= cycles count (W x 10 cycles)
; Return	: None
;******************************************************************************
delay10tcy:
    movwf   d1
    decfsz  d1
    bra     loop_delay10tcy
    nop
    nop
    return
        
loop_delay10tcy:
    nop
    bra     $+1
    nop
    bra     $+1
    nop
        
    decfsz  d1
    bra     loop_delay10tcy
    bra     $+1
    return
        


;******************************************************************************
; delay100tcy : delay 100 cycles (12.5us @ 32Mhz)
;
; Arguments : W= cycles count (W x 100 cycles)
; Return	: None
;******************************************************************************
delay100tcy:
    movwf   d2
        
loop_delay100tcy:
    movlw   D'9'
    call    delay10tcy
        
    decf    d2
    btfsc   STATUS, Z
    bra     delay100tcy_done

    nop
    bra     loop_delay100tcy
    nop

delay100tcy_done:
    return

        

;******************************************************************************
; delay1ktcy : delay 1000 cycles (0.125ms @ 32Mhz)
;
; Arguments : W= cycles count (W x 1000 cycles)
; Return	: None
;******************************************************************************
delay1ktcy:
    movwf   d2
        
loop_delay1ktcy:
    movlw   D'99'
    call   	delay10tcy
        
    decf    d2
    btfsc   STATUS, Z
    bra     delay1ktcy_done
        
    nop
    bra     loop_delay1ktcy
    nop

delay1ktcy_done:
    return        

        

;******************************************************************************
; delay10ktcy : delay 10000 cycles (1.25ms @ 32Mhz)
;
; Arguments : W= cycles count (W x 10000 cycles)
; Return	: None
;******************************************************************************
delay10ktcy:
    movwf   d3

loop_delay10ktcy:        
    movlw   D'10'
    call    delay1ktcy
        
    decfsz  d3
    bra     loop_delay10ktcy
        
    return


;==============================================================================
;==============================================================================
        END