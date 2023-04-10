EXTERN n: byte
EXTERN m: byte
EXTERN mat: byte
PUBLIC del_row

DSegRow SEGMENT PARA PUBLIC 'DATA'
	row db 0
	cur_row db 0
	cur db 0
	max db 0
DSegRow ENDS

CSegProc SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSegProc, DS:DSegRow

change_max_row_val:
	mov al, cur
	mov max, al
	mov al, cur_row
	mov row, al
	
	ret

change_col_si:
	mov al, es:m
	mov si, ax ; помещение количества столбцов
	sub si, bx ; вычитание итераций до конца
	add si, 1 ; сх еще не уменьшился
	
	ret

refresh_max:
	mov al, cur
	cmp max, al
	je skip_max_refresh
	jg skip_max_refresh
	jmp change
		
	change:
		call change_max_row_val
			
	skip_max_refresh:
	ret

refresh_odd_num:
	mov al, es:mat[si]
	sub al, '0'
	test al, 1
			
	jnz skip_refresh_odd_num
	jz even_label
			
	even_label:
		add cur, 1
				
	skip_refresh_odd_num:
	ret
	
max_even_row:
	mov cl, es:m
	mov si, 0
	mov ax, 0
	
	cols_loop:
		mov bx, cx
		mov cl, es:n
		mov cur, 0
		rows_loop:
			call refresh_odd_num
			
			add si, 9
			
			loop rows_loop
		
		call refresh_max
		call change_col_si
			
		mov cx, bx
		add cur_row, 1
		
	loop cols_loop
	
	ret

init_regs:
	mov ax, 0
	mov cx, 0
	
	ret

move_to_line_start:
	mov ax, 9
    sub al, es:m
    add si, ax
	
	ret

move_elem:
	mov al, es:mat[si + 1]
    mov es:mat[si], al
	
	ret

move_rows:
	call init_regs
	mov cl, es:n
	mov al, row
	mov si, 0
	
	rows__loop:
        mov bx, cx
        mov cl, es:m
		sub cl, row
		
		mov al, row
		add si, ax
        cols__loop:
			call move_elem
            inc si

            loop cols__loop

        call move_to_line_start

        mov cx, bx

        loop rows__loop
	ret

del_row proc far
	mov ax, seg n
	mov es, ax
	mov ax, DSegRow
	mov ds, ax
	
	call max_even_row
	
	sub es:m, 1
	call move_rows
	
	ret

del_row endp

CSegProc ENDS
END