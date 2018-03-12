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
	.equ ze = 0b00000000

	.def count = R24 ;Count register
	.def delay = R23 ;Delay time register


	;Setup PORTC
	ldi R16, 0x00 
	out DDRC, R16 ;Set PORTC as input
	ldi R16, 0xFF
	out PORTC, R16 ;Enable Pull-Up on PORTC

	;Setup PORTB
	out DDRB, R16 ; Set PORTB as output
	

	; Infinte loop 

	;LOOP:
	;NOP
	;BRNE LOOP

	;Eventuelt iJMP
	;Start med at tjek switches
	;Ijmp kør loop med tidsforsinkelse afhængig af switches.

main:

debounce:
	in R16, PINC ;Load PORTC to R16
	com R16 ;Complement R16
	rcall time2
	in R17, PINC ;After delay load PORTC to R17
	com R17
	cp R16, R17 ;Compare PORTC before and after delay
	brne debounce ;If not the same do again

	mov delay, R16 ;Set delay time to switch input.

test:
sega:
	ldi R16, a ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	rcall time
segb:
	ldi R16, b ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	rcall time
segc:
	ldi R16, c ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	rcall time
segd:
	ldi R16, d ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	rcall time
sege:
	ldi R16, e ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	rcall time
segf:
	ldi R16, f ;Load output value of segment
	out PORTB, R16 ;Output value to PORTB
	rcall time

	rjmp main




;-----DELAY SUBROUTINE-------	

time:

mov R20, delay
LOOP1:
ldi R21, 250
LOOP2:
DEC R21
BRNE LOOP2
DEC R20
BRNE LOOP1
ret

;-------Delay 2 subroutine------------

time2:

ldi R21, 250
LOOP:
DEC R21
BRNE LOOP
ret