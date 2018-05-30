;
; opgave7.asm
;
; Created: 30-05-2018 21:51:20
; Author : Marc
;

.def NUMH = R19
.def NUML = R18
.def DEN = R16
.def QL = R30
.def QH = R31


.org 0


SUM16:
	ADD R18, R16 ;Add lowest pair
	ADC R19, R17 ;Add with carry
	ret

DIV16_8:
	
	clr QL ;Clear quotient low
	clr QH ;Clear quotient high
DO:
	adiw QL, 1 ;add one to quotient
	sub NUML, DEN ;Subtract denominator fra numerator low
	sbci NUMH, 0 ; 
	brcc DO ; Do again if carry is not set.

;One time to many.

subi QL, 1
sbci QH, 0

add DEN, NUML

movw NUML, QL

ret
	



