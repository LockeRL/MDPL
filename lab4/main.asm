PUBLIC n
PUBLIC m
PUBLIC mat
EXTRN input_matrix: far
EXTRN print_matrix: far
EXTRN del_row: far


Stk SEGMENT PARA STACK 'STACK'
	db 200 dup(0)
Stk ENDS

DSegMat SEGMENT PARA PUBLIC 'DATA'
	n db 0
	m db 0
	mat db 9 * 9 dup (0)
DSegMat ENDS

CSeg SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSeg, SS:Stk, DS:DSegMat

exit:
	mov ah, 4ch
	int 21h
	
main:
	call input_matrix
	
	call del_row
	
	call print_matrix
	
	call exit
	
CSeg ENDS

END main