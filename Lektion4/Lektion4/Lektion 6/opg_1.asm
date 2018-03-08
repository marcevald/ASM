;
; opg_2.asm
;
; Created: 04-03-2018 18:00:44
; Author : Marc 
; Solution for assignment, lecture 6
;
	.org 0

init:
	
	;Initialize STACK
	ldi r16,low(RAMEND) // RAMEND address 0x08ff
	out SPL,r16 // Stack Pointer Low SPL at i/o address 0x3d
	ldi r16,high(RAMEND)
	out SPH,r16 // Stack Pointer High SPH at i/o address 0x3e
	
	;SETUP SEGMENTS
	.equ a = 0b10111111
	.equ b = 0b11110111
	.equ c = 0b11111011
	.equ d = 0b11111101
	.equ e = 0b11111110
	.equ f = 0b11101111

	.def count = R24 ;Count register
	.def deb = R25 ;Debounce register

	.def delay = R23 ;Delay time register

	;Setup PORTC
	ldi R16, 0x00 
	out DDRC, R16 ;Set PORTC as input
	ldi R16, 0xFF
	out PORTC, R16 ;Enable Pull-Up on PORTC

	;Setup PORTB
	out DDRB, R16 ; Set PORTB as output
	ldi R16, a
	out PORTB, R16 ;Turn on segment a

	
	

main:










;-----DELAY SUBROUTINE-------	
delay: 
	mov R16, delay
again:
	NOP
	dec R16
	brne again
	ret ;return to where delay was called.