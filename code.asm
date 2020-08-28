[org 0x0100]
       jmp start
       oldisr: dd 0           ; space for saving old isr keyboard interrupt service routine
 kbisr:

push ax
push es
mov ax, 0xb800
mov es, ax                    ;point es to video memory
in al, 0x60                   ;read a char from keyboard port
cmp al, 0x31                  ;is to hold the key in N   
jne nextcmp                   ;no, try next comparison
mov byte [es:0],'A'         ;yes, print ABCD at top left 
mov byte [es:2],'n'  
mov byte [es:4],'a'  
mov byte [es:6],'m'  

jmp nomatch                   ;leave interrupt routine

nextcmp:
cmp al, 0xB1                  ; is the key n is release
jne nomatch                   ; no, leave interrupt routine 
mov byte [es:0],''          ; yes, print space at top left
mov byte [es:2],''   
mov byte [es:4],''  
mov byte [es:6],''  



nomatch:
pop es
pop ax
jmp far [cs:oldisr]            ;call the original ISR

start:
xor ax, ax
mov es, ax                     ;point es to IVT base
mov ax, [es:9*4]
mov [oldisr], ax               ;save offset of old routine
mov ax, [es:9*4+2]
mov [oldisr+2], ax             ;save segment of old routine
cli                            ; disable interrupts
mov word [es:9*4], kbisr       ;store offset at n*4
mov [es:9*4+2],cs              ;store segment at n*4+2
sti                            ;enable interrupts

exit:
     mov ah, 0                 ;service 0 - get keystroke 
     int 0x16                  ;call BIOS keyboard service

     mov ax, 0x4c00                  ; terminate program
     int 0x21 
