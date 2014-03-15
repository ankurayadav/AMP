data segment
	ask db 'Enter any string :'
	asklen equ $-ask
	string db 100 dup(0)
	strlen equ $-string
	palin db "The string is in palindrome"
	palinlen equ $-palin
	npalin db "The string is not in palindrome"
	npalinlen equ $-npalin
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
	
	cpalin proc far
		lea si, string
		mov al, [si+1]

		inc si
		inc si
		
		
		mov di, si
		mov ah,00h
		add di, ax
		dec di
		
				
		mov ah,00h
		mov bl, 02h
		div bl
		
		
		mov ch, 00h
		mov cl, al
l:		mov al, [si]
		mov bl, [di]
		cmp al, bl
		jnz mismatch
		inc si
		dec di
		loop l
		
		mov cx, palinlen
		lea dx, palin
		call write
		jmp exit
mismatch:
		mov cx, npalinlen
		lea dx, npalin
		call write
exit:
		retf
	cpalin endp
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
		
		call cpalin
		
		mov ah, 4ch
		int 21h
code ends
	end start