/*
 * AsmFile1.asm
 *
 *  Created: 04-03-2018 21:23:35
 *   Author: Marc
 */ 
 
	.org 0

	rjmp init

init:
	;Setup PORTC

	ldi R16, 0x00
	out DDRC, R16 ; Set PORTC as input
	ldi R16, 0xFF
	out PORTC, R16 ;Enable Pull-Up on PORTC

	;Setup PORTB

	out DDRB, R16 ; Set PORTB as output

	rjmp main

main:

	in R16, PINC ; Load PORTC to R16
	ldi R17, 0xFF ; Load 0xFF to R17
	sub R17, R16 ; Subtract PINC from 0xFF
	breq second	; If no pins activated jump to second
	ldi R18, 0b01111111 ; Load 0b01111111 to R18
	out PORTB, R18 ; Output 01111111 on PORTB

	rjmp main

second:
	ldi R19, 0xFF ; Load 0xFF to R18
	out PORTB, R19 ; Turn of segment-display

	rjmp main