data segment
	filename db "myfile.txt",0
	handle dw ?
	works db "file created"
	lenworks equ $-works
	writef db "lets rock the world!!!"
	lenwritef equ $-writef
data ends

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
start:
		mov ax, data
		mov ds, ax
		mov ax, stk
		mov ss, ax
		
		;creating new file
		mov ah, 3ch ;for creating or truncating file
		mov cx, 0  ;normal - no attributes. 
		mov dx, offset filename
		int 21h
		jc er
		mov handle, ax
		mov cx, lenworks
		lea dx, works
		call write
		jmp con
er:			
		mov ah, 4ch
		int 21h
		
		;writing to new file
con:	mov bx, handle
		mov cx, lenwritef
		lea dx, writef
		mov ah, 40h
		int 21h
			
		;closing file
		mov bx, handle
		mov ah, 3eh
		int 21h
		
		mov ah, 4ch
		int 21h
		
code ends
	end start