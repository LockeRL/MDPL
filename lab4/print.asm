EXTRN n: byte
EXTRN m: byte
EXTRN mat: byte
PUBLIC print_matrix

DSegOut SEGMENT PARA PUBLIC 'DATA'
	elems_label db 'Matrix: ', 13, 10, '$'
	new_line db 13, 10, '$'
	space db ' $'
DSegOut ENDS

CSegOut SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSegOut

print_symbol:
	mov ah, 2
	int 21h
	
	ret

print_matrix_label:
	mov ax, DSegOut
	mov ds, ax
	mov dx, offset elems_label
	
	mov ah, 9
	int 21h
	
	ret

new_line_print:
	mov ax, DSegOut
	mov ds, ax
	mov dx, offset new_line
	
	mov ah, 9
	int 21h
	
	ret

space_print:
	mov ax, DSegOut
	mov ds, ax
	mov dx, offset space
	
	mov ah, 9
	int 21h
	
	ret
	
print_matrix proc far
	mov ax, seg n
	mov es, ax
	mov ax, 0
	
	call print_matrix_label
	
	mov cx, 0
	mov cl, es:n
	mov si, 0
	rows_loop:
		mov bx, cx
		mov cl, es:m
		cols_loop:
			mov dl, es:mat[si]
			inc si
			
			call print_symbol
			call space_print
			
			loop cols_loop
		
		call new_line_print
		
		mov ax, 9
        sub al, es:m
        add si, ax

        mov cx, bx
		
		loop rows_loop
	
	ret
print_matrix endp

CSegOut ENDS
END