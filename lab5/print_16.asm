EXTRN num: word
PUBLIC print_hex

DSegHex SEGMENT PARA PUBLIC 'DATA'
	print_msg db 'Signed hexidecimal number: $'
	hex db 4 dup(0), '$'
	sign db ' '
	hex_mask dw 15
DSegHex ENDS

CSegPrintHex SEGMENT PARA PUBLIC 'CODE'
	assume CS: CSegPrintHex, DS:DSegHex

to_hex:
	mov sign, ' '
    mov ax, es:num

    cmp ax, 32767
    jbe no_sign
	
    mov sign, '-'
    sub ax, 1
    not ax

    no_sign:
    mov bx, 3

    trans_hex:
        mov dx, ax
        and dx, hex_mask

        cmp dl, 10
        jb digit
		
		mov cl, 'A'
		sub cl, '9'
		sub cl, 1
        add dl, cl

        digit:
        add dl, '0'
        mov hex[bx], dl
		
		mov cl, 4
        sar ax, cl
        dec bx

        cmp bx, -1
        jne trans_hex

    ret

print_hex proc far
	mov ax, seg num
	mov es, ax
	
	mov ax, DSegHex
	mov ds, ax
	mov dx, offset print_msg
	mov ah, 9
	int 21h
	
	call to_hex

    mov dl, sign
    mov ah, 2
    int 21h
	
	mov dx, offset hex
	mov ah, 9
	int 21h
	
	ret
print_hex endp
	
CSegPrintHex ENDS
END