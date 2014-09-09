;******************************************************************************
;*   Project:      Clock led matrix display                                   *
;*   Version:      0.1                                                        *
;*                                                                            *
;*   Filename:     main.asm                                                   *
;*   Description:                                                             *
;*   Last mod:     30 dec. 2012                                               *
;*                                                                            *
;*   Author:       Benoit Frigon                                              *
;*   Email:        <bfrigon@gmail.com>                                        *
;*                                                                            *
;******************************************************************************
processor 16f1826
#include <p16f1826.inc>


#define COL_MR		PORTA, RA0
#define COL_CLK		PORTA, RA1



;==============================================================================
;==============================================================================
;
;                                   Symbols 
;------------------------------------------------------------------------------
; *** Subroutines ***
EXTERN  delay10tcy
EXTERN  delay100tcy
EXTERN  delay1ktcy
EXTERN  delay10ktcy
EXTERN  i2c_init_slave


;==============================================================================
;==============================================================================
;
;                              Configuration bits
;------------------------------------------------------------------------------
	__CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON
	__CONFIG _CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LVP_OFF

	

;==============================================================================
;==============================================================================
;
;                                     Data   
;------------------------------------------------------------------------------
.d_main			UDATA
columns         RES     0x18                ; Columns data
current_col     RES     0x01
i               RES     0x01                ; Counter
pwm_count       RES     0x01	
pwm_value       RES     0x01	
init_pwm        RES     0x01

;==============================================================================
;==============================================================================
;
;                                       IVT
;------------------------------------------------------------------------------
.i_reset  		CODE    0x00
        goto    main

.i_isr          CODE    0x04
        goto    interrupts



;==============================================================================
;==============================================================================
;
;                                      Main  
;------------------------------------------------------------------------------
.c_main			CODE
	
main:

	;--------------------------------
	; Configure oscillator
	;--------------------------------
	movlb   1                               ; Select bank 1
	
    movlw   b'11110000'                     ; 4x PLL, 32MHZ HF
	movwf	OSCCON
	
	clrf	OSCTUNE                         ; Default factory calibration
		
	
	
	;--------------------------------
    ; Configure ports
    ;--------------------------------
    movlb   0                               ; Select bank 0
    bsf     COL_MR
    bsf     COL_CLK
    
    movlb   1                               ; Select bank 1
	clrf    TRISB                           ; PORTB as outputs
	
	movlw   b'11111100'                     ; RA0,RA1 as output, RA2-RA7 as input
	movwf   TRISA
	
	
	call    i2c_init_slave                  ; Initialize I2C bus
	
	
	
	
	;--------------------------------
    ; Configure timer0
    ;--------------------------------
    movlb   1                               ; Select bank 1
	movlw   b'11000000'                     ; No pre-scaler (PSA=0), 
                                            ; Internal clock source (CS=0)
	movwf   OPTION_REG
	
	bsf     INTCON, TMR0IE                  ; Enable Timer0 interrupt
	
	movlb   0                               ; Select bank 0
	
	movlw   D'1'
	movwf   TMR0                            ; Set Timer0 counter
	

	
	
    ;--------------------------------
    ; Reset columns driver
    ;--------------------------------   
    call    reset_columns
    
	
	;--------------------------------
    ; Erase column data buffer
    ;--------------------------------
    movlw   columns + D'0'
    movwf   FSR0L
    clrf    FSR0H
    
    movlw   D'24'
    movwf   i
    nop
    
loop_erase_cols:
	movlw   0x41
	movwi   FSR0++
	
	decfsz  i
	bra     loop_erase_cols
	
	
    ;--------------------------------
    ; Enable interrupts
    ;--------------------------------	
	bsf     INTCON, PEIE
	bsf     INTCON, GIE
	
	
	movlw   0xFF
	movwf   columns + D'0'
	
	movlw   0xFF
    movwf   columns + D'23'
    
    movlw   0xFF
    movwf   columns + D'22'
    
    movlw   0xFF
    movwf   columns + D'4'
	
	movlw   d'32'
	movwf   pwm_value
	
main_loop:







    goto    main_loop



    

;==============================================================================
;==============================================================================
;
;                                
;------------------------------------------------------------------------------    
reset_columns:
    bsf     COL_MR
    nop
    bcf     COL_MR

    movlw   D'25'                       ; Reset column counter
    movwf   current_col    
    
    decf    pwm_count
    btfsc   STATUS, Z
    call    reset_pwm    

    movf    pwm_value
    btfss   STATUS, Z
    decf    pwm_value
    
    return

reset_pwm:    
    
    movlw   D'32'
    movwf   pwm_count
    
    movlw   D'32'
    movwf   pwm_value
    
    return


    
    
    
    
	
;==============================================================================
;==============================================================================
;
;                                Interrupt handler
;------------------------------------------------------------------------------
interrupts:

    btfsc   INTCON, TMR0IF
    bra    isr_timer0

    retfie
    
    
isr_timer0:
    bcf     INTCON, TMR0IF
    bcf     INTCON, TMR0IE
    
    clrf    PORTB

    bcf     COL_CLK
    nop
    bsf     COL_CLK
    
    decf    current_col
    btfsc   STATUS, Z
    call    reset_columns

    movf    pwm_value, W
    btfsc   STATUS, Z
    bra     skip_set_column_data
    
    clrf    FSR0H
    movlw   columns + D'24'
    movwf   FSR0L
    movf    current_col, W
    subwf   FSR0L

    moviw   FSR0
    movwf   PORTB

skip_set_column_data:    
    nop
    
    ;--------------------------------
    ; Re-enable timer0
    ;--------------------------------    
skip_timer0_isr:
    bsf     INTCON, TMR0IE
	
	movlb   0
	movlw   D'180'
	movwf   TMR0

	retfie
	
	nop
	
	
;==============================================================================
;==============================================================================
	END
	
	
	