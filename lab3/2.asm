PUBLIC read

SC2 SEGMENT para public 'CODE'
	assume CS:SC2
read proc far
	mov ah, 8
	int 21h
	
	ret
read endp
SC2 ENDS
END