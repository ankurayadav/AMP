DATA SEGMENT
	STR1 DB "Enter password :"
	LENSTR1 EQU $-STR1
	STR2 DB "PASS"
	LENSTR2 EQU $-STR2
	STR3 DB 100 DUP(0)
	LENSTR3 EQU $-STR3
	STR4 DB "WORNG PASSWORD           "
	LENSTR4 EQU $-STR4
	STR5 DB "CORRECT PASSWORD         "
	LENSTR5 EQU $-STR5
DATA ENDS

CODE SEGMENT
	ASSUME CS: CODE, DS:DATA

WRITE PROC
		MOV AH, 40H
		MOV AL, 00H
		MOV BX, 0001H
		INT 21H
		RET
WRITE ENDP

READ PROC
		MOV AL, 00H
		MOV AH, 0AH
		INT 21H
		RET
READ ENDP
	
CHECK PROC
		LEA SI, STR3
		MOV AL, [SI+1]
		CMP AL, LENSTR2
		JNZ MISMATCH
		MOV CX, LENSTR2
		LEA BP, STR2
L:		MOV AL, [SI+2]
		MOV BL, [BP]
		CMP AL, BL
		JNZ MISMATCH
		INC SI
		INC BP
		LOOP L
		
		LEA DX, STR5
		MOV CX, LENSTR5
		RET
MISMATCH:	
		LEA DX, STR4
		MOV CX, LENSTR4
		RET
CHECK ENDP
	
START:	
		MOV AX, DATA
		MOV DS, AX
		
		MOV CX, LENSTR1
		LEA DX, STR1
		CALL WRITE
		
		LEA SI, STR3
		MOV BYTE PTR [SI], LENSTR3-2
		LEA DX, STR3
		CALL READ
		
		CALL CHECK
		
		CALL WRITE
		
		MOV AL,00H
		MOV AH,4CH
		INT 21H
CODE ENDS
	END START