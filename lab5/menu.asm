PUBLIC print_menu

DSegMenu SEGMENT PARA PUBLIC 'DATA'
	menu_label  db 13, 10, 'Menu:', 13, 10
				db '1) Input signed decimal number', 13, 10
				db '2) Convert to unsigned binary and print', 13, 10
				db '3) Convert to signed hexidecimal and print', 13, 10
				db '4) Exit', 13, 10, 13, 10
				db 'Enter command: $'
DSegMenu ENDS

CSegMenu SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSegMenu, DS:DSegMenu
	
print_menu proc far
	mov ax, DSegMenu
	mov ds, ax
	mov dx, offset menu_label
	mov ah, 9
	int 21h
	
	ret
print_menu endp

CSegMenu ENDS
END