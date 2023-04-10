EXTRN n: byte
EXTRN m: byte
EXTRN mat: byte
PUBLIC input_matrix

DSegInp SEGMENT PARA PUBLIC 'DATA'
	n_label db 'Enter the number of lines: $'
	m_label db 'Enter the number of columns: $'
	elems_label db 'Enter the elements: ', 13, 10, '$'
	new_line db 13, 10, '$'
	space db ' $'
DSegInp ENDS

CSegInp SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSegInp, DS:DSegInp

n_input_print:
	mov ax, DSegInp
	mov ds, ax
	mov dx, offset n_label
	
	mov ah, 9
	int 21h
	
	ret

m_input_print:
	mov ax, DSegInp
	mov ds, ax
	mov dx, offset m_label
	
	mov ah, 9
	int 21h
	
	ret

new_line_print:
	mov ax, DSegInp
	mov ds, ax
	mov dx, offset new_line
	
	mov ah, 9
	int 21h
	
	ret

space_print:
	mov ax, DSegInp
	mov ds, ax
	mov dx, offset space
	
	mov ah, 9
	int 21h
	
	ret

elements_label_print:
	mov ax, DSegInp
	mov ds, ax
	mov dx, offset elems_label
	
	mov ah, 9
	int 21h
	
	ret

input_symb:
	mov ah, 1
	int 21h
	
	ret

n_input:
	call n_input_print
	call input_symb
	
	mov es:n, al
	sub es:n, '0'
	
	call new_line_print
	ret

m_input:
	call m_input_print
	call input_symb
	
	mov es:m, al
	sub es:m, '0'
	
	call new_line_print
	ret

move_to_line_start:
	mov ax, 9
    sub al, es:m
    add si, ax
	
	ret

elements_input:
	call elements_label_print
	
	mov cl, es:n
	mov si, 0
	rows_loop:
        mov bx, cx
        mov cl, es:m

        cols_loop:
            call input_symb
            mov es:mat[si], al
            inc si

            call space_print

            loop cols_loop
        
        call new_line_print

        call move_to_line_start

        mov cx, bx

        loop rows_loop

    call new_line_print
	
	ret


input_matrix proc far
	mov ax, seg n
	mov es, ax
	call n_input
	
	call m_input
	
	call elements_input
	
	ret
input_matrix endp
	
CSegInp ENDS
END