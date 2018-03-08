;
; opg_2.asm
;
; Created: 04-03-2018 18:00:44
; Author : Marc 
; Solution for assignment 3, lecture 5
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

	.equ count = 0x6B ;Count variable adress
	.equ deb = 0x60 ;Debounce variable adress


	;Setup PORTC
	ldi R16, 0x00 
	out DDRC, R16 ;Set PORTC as input
	ldi R16, 0xFF
	out PORTC, R16 ;Enable Pull-Up on PORTC

	
	;Setup PORTB
	out DDRB, R16 ; Set PORTB as output
	out PORTB, R16; Turn off segments by sending 0xFF

	ldi R16, 0x01
	sts count, R16 ;Set Counter to 1

	in R16, PINC ;Load PINC to R16
	sts deb, R16 ;Load value to PINC to debounce memory

main:
	lds R19, deb ;Load debounce variable to R19

debounce:
	in R16, PINC ;Load PORTC to R16
	rcall delay
	in R17, PINC ;After delay load PORTC to R17
	cp R16, R17 ;Compare PORTC before and after delay
	brne debounce ;If not the same do again
	
	STS deb, R16 ;Store debounced value of PORTC to debounce variable in memory
	cp R19,R16 ;Compare the debounced value with the last debounced value
	breq main ;If the same -> do again, if changed, switch has been toggled -> continue code. 


	lds R16, count ;Load count variable from memory
	ldi R17, 0x01 ;Load compare value 
	cp R16,R17 ;Compare to find segment value
	breq sega ;If this segment -> seg

	lds R16, count ;Load count variable from memory
	ldi R17, 0x02 ;Load compare value 
	cp R16,R17 ;Compare to find segment value
	breq segb ;If this segment -> seg

	lds R16, count ;Load count variable from memory
	ldi R17, 0x03 ;Load compare value 
	cp R16,R17 ;Compare to find segment value
	breq segc ;If this segment -> seg

	lds R16, count ;Load count variable from memory
	ldi R17, 0x04 ;Load compare value 
	cp R16,R17 ;Compare to find segment value
	breq segd ;If this segment -> seg

	lds R16, count ;Load count variable from memory
	ldi R17, 0x05 ;Load compare value 
	cp R16,R17 ;Compare to find segment value
	breq sege ;If this segment -> seg

	lds R16, count ;Load count variable from memory
	ldi R17, 0x06 ;Load compare value 
	cp R16,R17 ;Compare to find segment value
	breq segf ;If this segment -> seg

	rjmp main

sega:
	ldi R16, a ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	lds R16, count ;Load count variable from memory to R19
	inc R16 ;Increment count variable
	sts count, R16 ;Store incremented count variable in memory
	rjmp main
segb:
	ldi R16, b ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	lds R16, count ;Load count variable from memory to R19
	inc R16 ;Increment count variable
	sts count, R16 ;Store incremented count variable in memory
	rjmp main
segc:
	ldi R16, c ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	lds R16, count ;Load count variable from memory to R19
	inc R16 ;Increment count variable
	sts count, R16 ;Store incremented count variable in memory
	rjmp main
segd:
	ldi R16, d ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	lds R16, count ;Load count variable from memory to R19
	inc R16 ;Increment count variable
	sts count, R16 ;Store incremented count variable in memory
	rjmp main
sege:
	ldi R16, e ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	lds R16, count ;Load count variable from memory to R19
	inc R16 ;Increment count variable
	sts count, R16 ;Store incremented count variable in memory
	rjmp main
segf:
	ldi R16, f ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	ldi R16, 0x01 
	sts count, R16 ;Store Count variable 0x01 in memory. Next segment to light after f, is a.
	rjmp main
	
;-----DELAY SUBROUTINE-------	
delay: 
	ldi R20, 250
again:
	NOP
	dec R20
	brne again
	ret ;return to where delay was called.