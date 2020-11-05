;originate at 100
[org 0x0100]

mov ax, [num1];5
mov bx, [num2];1
add ax, bx;5+1=6
mov bx, [num3];2
add ax, bx;6+2=8
mov [tot], ax;8



;end program
mov ax, 0x4c00
int 0x21
;dd = 4 bytes
;dw = 2 bytes
;db = 1 bytes

num1:   dw  5
num2:   dw  1
num3:   dw  2
tot:    dw  0
