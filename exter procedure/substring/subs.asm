data segment
	tinp db "Enter any string :"
	lentinp equ $-tinp
	inp db 100 dup(0)
	leninp equ $-inp
	tinp2 db "Enter substring :"
	lentinp2 equ $-tinp2
	inp2 db 100 dup(0)
	leninp2 equ $-inp2 
	found db "string found :"
	lenfound equ $-found
	nfound db "string not found :"
	lennfound equ $-nfound
data ends

extrn subs:far
public inp, inp2


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
	
	mov cx, lentinp2
	lea dx, tinp2
	call write
	
	lea si, inp2
	mov byte ptr [si], leninp2-2
	lea dx, inp2
	call read
	
	call subs
	
	cmp al, 01h
	jnz notfound
	mov cx, lenfound
	lea dx, found
	call write
	jmp quit
notfound:
	mov cx, lennfound
	lea dx, nfound
	call write
quit:
	mov ah,4ch
	int 21h
code ends
	end start
	