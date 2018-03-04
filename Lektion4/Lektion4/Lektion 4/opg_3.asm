/*
 * opg_3.asm
 *
 *  Created: 04-03-2018 22:08:15
 *   Author: Marc
 */ 

 	.org 0

	.equ seg0 = 0b10100000 ;0
	.equ seg1 = 0b11110011 ;1
	.equ seg2 = 0b10010100 ;2
	.equ seg3 = 0b10010001 ;3
	.equ seg4 = 0b11000011 ;4
	.equ seg5 = 0b10001001 ;5
	.equ seg6 = 0b10001000 ;6
	.equ seg7 = 0b10110011 ;7
	.equ seg8 = 0b10000000 ;8
	.equ segE = 0b10001100 ;ERROR

	.equ in0 = 0b11111111
	.equ in1 = 0b11111110
	.equ in2 = 0b11111101
	.equ in3 = 0b11111011
	.equ in4 = 0b11110111
	.equ in5 = 0b11101111
	.equ in6 = 0b11011111
	.equ in7 = 0b10111111
	.equ in8 = 0b01111111


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

; if 0
ldi R17, in0 ; 
sub R17, R16
breq n0 ; if 0

; if 1
ldi R17, in1 ; 
sub R17, R16
breq n1 ; if 1

; if 2
ldi R17, in2 ; 
sub R17, R16
breq n2 ; if 2

; if 3
ldi R17, in3 ; 
sub R17, R16
breq n3 ; if 3

; if 4
ldi R17, in4 ;
sub R17, R16
breq n4 ; if 4

; if 5
ldi R17, in5 ; 
sub R17, R16
breq n5 ; if 5

; if 6
ldi R17, in6 ; 
sub R17, R16
breq n6 ; if 6

; if 7
ldi R17, in7 ; 
sub R17, R16
breq n7 ; if 7

; if 8
ldi R17, in8 ; 
sub R17, R16
breq n8 ; if 8

rjmp nE

n0:
ldi R16, seg0
out PORTB, R16
rjmp main

n1:
ldi R16, seg1
out PORTB, R16
rjmp main


n2:
ldi R16, seg2
out PORTB, R16
rjmp main


n3:
ldi R16, seg3
out PORTB, R16
rjmp main


n4:
ldi R16, seg4
out PORTB, R16
rjmp main


n5:
ldi R16, seg5
out PORTB, R16
rjmp main


n6:
ldi R16, seg6
out PORTB, R16
rjmp main


n7:
ldi R16, seg7
out PORTB, R16
rjmp main


n8:
ldi R16, seg8
out PORTB, R16
rjmp main


nE:
ldi R16, segE
out PORTB, R16
rjmp main
