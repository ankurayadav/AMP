data segment
        num1 dw 1000h
        num2 dw 2000h
data ends

mystack segment stack
        dw 50 dup(0)
        tos label word
mystack ends
procedure segment
        assume cs:procedure, ss:mystack, ds:data


        myadd proc far
        ; input ax and bx regs
                add ax,bx
                retf
        myadd endp
procedure ends

code segment
        assume cs:code

start: mov ax, data
        mov ds, ax
        mov ax, mystack

        mov ss, ax
        lea sp, tos

        mov ax, num1
        mov bx, num2
        call myadd

        mov ah, 4ch
        int 21h

code ends
        end start
