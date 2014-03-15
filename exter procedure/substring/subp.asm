public subs
extrn inp:byte, inp2:byte

procedure segment
	assume cs:procedure
	subs proc far
		lea si, inp
		lea di, inp2
		
		inc si
		inc di
		
		mov al, [si]
		mov ah, [di]
		cmp al, ah
		jc notthere
		
		mov ch, 00h
		mov cl, [si]
		inc si
		inc di
		
l:		mov al, [si]
		mov ah, [di]
		cmp al, ah
		jnz next
			push cx
			mov cl, [di-1]
			mov ch, 00h
	lin:	
			mov al, [si]
			mov ah, [di]
			cmp al, ah
			jnz n
			inc si
			inc di
			loop lin
			jmp bingo
	n:	pop cx
		lea di, inp2
	next:
		inc si
		loop l
		
notthere:	mov al, 00h
	retf
bingo:	
	pop cx
	mov al, 01h
	retf
	subs endp
	
procedure ends
end
