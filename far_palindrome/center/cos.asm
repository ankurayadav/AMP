data segment
	ask db 'Enter any string :'
	asklen equ $-ask
	string db 100 dup(0)
	strlen equ $-string
data ends

stk segment stack
	db 100 dup(0)
	tos label word
stk ends

procedure segment
	assume cs:procedure, ds:data, ss:stk
	read proc far
		lea si, string
		mov byte ptr [si], strlen-2
		mov ah, 0ah
		lea dx, string
		int 21h
		retf
	read endp
		
	write proc far
		mov ah, 40h
		mov bx, 0001h
		int 21h
		retf
	write endp
	
	center proc far
		mov ah, 06h
		mov al, 00h
		mov bh, 07h
		mov cx, 00h
		mov dx, 184fh
		int 10h
		
		lea si, string
		mov al, [si+1]
		mov ah, 00h
		mov bl,02h
		div bl
		
		mov ah,40
		
		sub ah,al
		
		mov dh, 12
		mov dl, ah
		mov bh, 0
		mov ah, 2
		int 10h
		
		mov cl, [si+1]
		mov ch, 00h
		lea dx, string
		inc dx
		inc dx
		call write
		retf
	center endp
procedure ends

code segment
	assume cs:code, ds:data, ss:stk
start:
		mov ax, data
		mov ds, ax
		mov ax, stk
		mov ss, ax
		
		mov cx, asklen
		lea dx, ask
		call write
		
		call read
		
		call center
		
		mov ah, 4ch
		int 21h
code ends
	end start