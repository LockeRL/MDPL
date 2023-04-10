PUBLIC num

EXTRN print_menu: far
EXTRN input_dec: far
EXTRN print_hex: far
EXTRN print_ubin: far


Stk SEGMENT PARA STACK 'STACK'
	db 200 dup(0)
Stk ENDS

DSeg SEGMENT PARA PUBLIC 'DATA'
	num dw 0
	point_arr dd input_dec, print_ubin, print_hex, exit
	new_line_label db 13, 10, '$'
DSeg ENDS

CSeg SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSeg, SS:Stk, DS:DSeg

exit proc far
	mov ah, 4ch
	int 21h
exit endp

new_line:
	mov ax, DSeg
	mov ds, ax
	mov dx, offset new_line_label
	mov ah, 9
	int 21h
	ret

input_command:
	mov ah, 1
	int 21h
	sub al, '1'
	
	mov bl, 4
	mul bl
	
	mov ah, 0
	ret
	
main:	
	loop_label:
		call print_menu
		
		call input_command
		
		mov si, ax
		
		call new_line
		
		call point_arr[si]
		
		jmp loop_label
	
CSeg ENDS
END main