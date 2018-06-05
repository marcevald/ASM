/*
 * AsmFile1.asm
 *
 *  Created: 05-06-2018 19:36:51
 *   Author: Marc
 */ 

 .org 0

 SETUP:

 ;------------SETUP STACKPOINTER----------

 LDI R16, LOW(RAMEND)
 OUT SPL, R16
 LDI R16, HIGH(RAMEND)
 OUT SPH, R16 

 ;------------SETUP USART------------------
  
 LDI R16, (1 << RXEN) | (1 << TXEN)
 OUT UCSRB, R16 ; Enable Serial RX and TX. 

 LDI R16, (1 << URSEL) | (1 << UCSZ1) | (1 << UCSZ0)
 OUT UCSRA, R16 ; Setup 8-bit data. REMEMBER URSEL = 1 to access UCRSA istead of UBBRH

 LDI R16, (1 << U2X)
 OUT UCSRA, R16 ; Enable U2X.

 LDI R16, 12
 OUT UBRRL, R16 ; Baud-Rate = 9600, when U2X is enabled.
 
 MAIN:
 
 SBIS UCSRA, RXC ; Skip next line if reception finished.
 RJMP MAIN
 IN R16, UDR ; Put recieved in R16

 CPI R16, 65
 BRSH UPPER_CASE

 CPI R16, 97
 BRSH LOWER_CASE

 CALL SEND

 UPPER_CASE:
  CPI R16, 91
  BRLO UPPER_CASE1

 LOWER_CASE:
  CPI R16, 123
  BRLO LOWER_CASE1

  LOWER_CASE1:
   CALL LC
  UPPER_CASE1:
   CALL UC


 RJMP MAIN

  UC:
	LDI R17, 32
	ADD R16, R17
	CALL SEND
	RET

 LC:
	LDI R17, 32
	SUB R16, R17
	CALL SEND
	RET

 SEND: 
 
 ;SBIS UCSRA, TXC ; Check if ready to transmit
 ;RJMP SEND
 OUT UDR, R16; Send contents of R16

  RET


 ;SBIS UCSRA, UDRE ; Skip to next line if UDRE bit is high - meaning data has been sent. And is ready for new data
 ;RJMP MAIN ; If not send, skip til MAIN.
 ;LDI R16, 'A'
 ;OUT UDR, R16 ; Put 'A' in UDR register. The send register.
 
 ;RJMP MAIN
  

