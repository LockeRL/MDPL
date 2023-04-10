EXTRN num: word
PUBLIC print_ubin

DSegBin SEGMENT PARA PUBLIC 'DATA'
	print_msg db 'Unsigned binary number: $'
	bin db 16 dup(0), '$' 
	bin_mask dw 1
DSegBin ENDS

CSegPrintUBin SEGMENT PARA PUBLIC 'CODE'
	assume CS: CSegPrintUBin, DS:DSegBin

to_ubin:
    mov ax, es:num
    mov si, 15
    c_ubin:
        mov dx, ax
        and dx, bin_mask
        add dl, '0'
        mov bin[si], dl

        sar ax, 1
        dec si

        cmp si, -1
        jne c_ubin

    ret
	
print_ubin proc far
	mov ax, seg num
	mov es, ax
	
	mov ax, DSegBin
	mov ds, ax
	mov dx, offset print_msg
	mov ah, 9
	int 21h
	
	call to_ubin

    mov dx, offset bin
	mov ah, 9
	int 21h
	
	ret
print_ubin endp
	
CSegPrintUBin ENDS
END