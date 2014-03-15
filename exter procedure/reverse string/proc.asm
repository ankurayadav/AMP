public revstr
extrn inp:byte, outp:byte

procedure segment
	assume cs:procedure
	revstr proc far
		lea si, inp
		inc si
		mov cl, [si]
		mov ch,00h
		
		lea di, outp
		add di, cx
		
		inc si
		dec di
		
l:		mov al, [si]
		mov [di], al
		inc si
		dec di
		loop l
		
	retf
	revstr endp
	
procedure ends
end
