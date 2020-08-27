;// created by Umair mehmood
; date 27 August 2020 
;program to calculate x^n ( x to the power n)

[org 0x0100]

jmp start

;data
x: dw 2
n: dw 5 
result: dw 0

;code
start:
		mov cx,[n] 
		mov ax,[x]
doit:	
		mov dx,[x]
		mul dx
		dec cx
		cmp cx,1
		jne doit
	
		;save result into result
		mov [result],ax
;terminate program
		mov ax,0x4c00
		int 0x21 