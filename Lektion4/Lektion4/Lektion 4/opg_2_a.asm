;
; Lektion4_opgaver.asm
;
; Created: 04-03-2018 18:00:44
; Author : Marc
;

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
	in R16, PINC ; Read PORTC
	out PORTB, R16 ; Output PORTB on PORT C

	rjmp main ; Loop main
	
