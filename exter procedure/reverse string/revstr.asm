data segment
	tinp db "Enter any string :"
	lentinp equ $-tinp
	inp db 100 dup(0)
	leninp equ $-inp
	goutp db "Reversed string is :"
	lengoutp equ $-goutp
	outp db 100 dup(0)
	lenoutp equ $-outp 
data ends

extrn revstr:far
public inp, outp

stk segment stack
	db 100 dup(0)
	tos label word
stk ends

code segment 
	assume cs:code, ds:data, ss:stk
	
write proc
		mov ah, 40h
		mov al, 00h
		mov bx, 0001h
		int 21h
		ret
write endp

read proc
		mov al, 00h
		mov ah, 0ah
		int 21h
		ret
read endp

;pos macro row, col
;	mov ah, 02h
;	mov dh, row
;	mov dl, col
;	mov bh, 0
;	int 10h
;pos endm

start:
	mov ax, data
	mov ds, ax
	
	mov ax, stk
	mov ss, ax
	
	mov cx, lentinp
	lea dx, tinp
	call write
	
	lea si, inp
	mov byte ptr [si], leninp-2
	lea dx, inp
	call read
;	pos 1,0
	
	call revstr
	
	mov cx, lengoutp
	lea dx, goutp
	call write
	
	mov cx, lenoutp
	lea dx, outp
	call write
	
	mov ah,4ch
	int 21h
code ends
	end start
	