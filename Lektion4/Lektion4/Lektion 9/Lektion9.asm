/*
 * AsmFile1.asm
 *
 *  Created: 05-06-2018 21:22:55
 *   Author: Marc
 */ 
 
 
 .DEF fivehz = R20
 .DEF twohz = R21
 .DEF onehz = R22
 .DEF temp = R16
 .DEF temp1 = R17
 .DEF tick = R23

 .equ segA = 0b01000000
 .equ segG = 0b00100000
 .equ segD = 0b00000010

 .org 0
 JMP SETUP
 
 .org 0x14 ; Timer0 Compare Interrupt

 JMP OFC0_ISR

 .org 0x30
 
 SETUP: 
	 
	 ;----------------------STACK INIT------------------

	 LDI temp, LOW(RAMEND)
	 OUT SPL, temp
	 LDI temp, HIGH(RAMEND)
	 OUT SPH, temp

	 ;----------------------OUTPUT------------------------

	 LDI temp, 0xFF
	 OUT DDRB, temp ; Setup PORTB as OUTPUT
	 OUT PORTB, temp
	
	 ;--------------------TIMER0 to CTC mode--------------

	 LDI temp, (1<<OCF0)
	 OUT TIFR, temp
	 LDI temp, 0
	 OUT TCNT0, temp
	 LDI temp, 9
	 OUT OCR0, temp ; Count 10 ticks
	 LDI temp, (1<<OCIE0) ; Enable on compare interrupt.
	 OUT TIMSK, temp
	 LDI temp, 0b00001101
	 OUT TCCR0, temp ; Setup CTC and prescaler 1024
	

	 SEI ; Enable global interrupts

	 CLR temp
	 CLR temp1
	 CLR fivehz
	 CLR twohz
	 CLR onehz
	 CLR tick
 
 MAIN:

 CPI tick, 1
 BRSH RUN
 RJMP MAIN

 RUN:

 DEC tick

 timeout5hz:
	INC fivehz
	CPI fivehz, 10
	BRNE timeout2hz
	CLR fivehz
	IN temp, PORTB
	LDI temp1, segA
	EOR temp, temp1
	OUT PORTB, temp

 
 timeout2hz:
	INC twohz
	CPI twohz, 25
	BRNE timeout1hz
	CLR twohz
	IN temp, PORTB
	LDI temp1, segG
	EOR temp, temp1
	OUT PORTB, temp
 
 timeout1hz:
	INC onehz
	CPI onehz, 50
	BRNE MAIN
	CLR onehz
	IN temp, PORTB
	LDI temp1, segD
	EOR temp, temp1
	OUT PORTB, temp

RJMP MAIN	 
	  

 OFC0_ISR:

 INC tick
 
 RETI