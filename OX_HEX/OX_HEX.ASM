DATA SEGMENT
	NUM DW 07535H
	NUM1 DW 0000H
DATA ENDS

STK SEGMENT STACK
	DB 100 DUP(0)
	TOC LABEL WORD
STK ENDS

CODE SEGMENT
	ASSUME CS: CODE, DS: DATA, SS: STK
START:	MOV AX, DATA
		MOV DS, AX
		MOV AX, STK
		MOV SS, AX
		
		MOV CX, 04H
L:		
		ROL NUM, 01H
		ROL NUM, 01H
		RCL NUM1, 01H
		
		ROL NUM, 01H
		RCL NUM1, 01H
		
		ROL NUM, 01H
		RCL NUM1, 01H
		LOOP L
		
		MOV AH, 4CH
		INT 21H
CODE ENDS
	END START