data segment
	filename db "myfile.txt",0
	handle dw ?
	buffer db 100 dup(0)
data ends

stk segment stack
	db 100 dup(0)
	tos label word
stk ends

code segment
	assume cs:code, ds:data, ss:stk
start:
	mov ax, data
	mov ds, ax
	mov ax, stk
	mov ss, ax
	
	;opening a file
	mov al, 0 ;read only
	lea dx, filename
	mov ah, 3dh
	int 21h
	mov handle, ax
	
	;obtaining file size using seek
	mov al, 2
	mov bx, handle
	mov dx, handle
	mov ah,42h
	int 21h
	mov cx, ax
	;obtaining file size using seek
	mov al, 0
	mov bx, handle
	mov dx, handle
	mov ah,42h
	int 21h
	
	;read file
	mov bx, handle
	;mov cx, ax
	lea dx, buffer
	mov ah, 3fh
	int 21h
	
	;closing file
	mov bx, handle
	mov ah, 3eh
	int 21h
	
	mov ah, 4ch
	int 21h
code ends
	end start