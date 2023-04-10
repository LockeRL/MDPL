EXTRN num: word
PUBLIC input_dec

DSegInputDec SEGMENT PARA PUBLIC 'DATA'
	inp db 'Input signed decimal number: $'
	sign dw 0
DSegInputDec ENDS

CSegInputDec SEGMENT PARA PUBLIC 'CODE'
	assume CS: CSegInputDec, DS:DSegInputDec
	
input_dec proc far
	mov ax, seg num
	mov es, ax
	
	mov ax, DSegInputDec
	mov ds, ax
	mov dx, offset inp
	mov ah, 9
	int 21h
	
	mov sign, 1
	mov cx, 0
	mov bx, 0
	input_symb:
		mov ah, 1
		int 21h
		
		cmp al, '-'
		jne continue
		mov sign, -1
		jmp input_symb
		
		continue:
		cmp al, 13
		je exit_input
		
		mov cl, al
		sub cl, '0'
		
		mov ax, 10
		mul bx
		mov bx, ax
		add bx, cx
		
		jmp input_symb
	
	exit_input:
	mov ax, sign
	mul bx
	mov es:num, ax
	
	ret
input_dec endp
	
CSegInputDec ENDS
END