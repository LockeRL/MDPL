.model tiny

CSEG SEGMENT
	assume CS:CSEG
	org 100h

main:
	jmp init_proc
	
	handler_addr dd 0
	is_active db 1
	cur_speed db 00011111b
	cur_time db 0

update_speed proc near
	push ax
	push bx
	push cx
	push dx
	
	mov ah, 2
	int 1Ah
	
	cmp dh, cur_time
	je skip_change
	
	mov cur_time, dh
	dec cur_speed
	and cur_speed, 00011111b
	
set_speed:
	mov al, 0F3h
	out 60h, al
	
	mov al, cur_speed
	out 60h, al

skip_change:
	pop dx
	pop cx
	pop bx
	pop ax
	
	db 0EAh
	old_vector dd 0
update_speed endp

init_proc:
	mov ah, 35h
	mov al, 1Ch
	int 21h
	
	cmp es:is_active, 1
    je exit_proc
		
	mov word ptr old_vector, bx
	mov word ptr old_vector[2], es
	
	mov ah, 25h
	mov al, 1Ch
	mov dx, offset update_speed ; установка нового прерывания
	int 21h
	
	mov dx, offset init_msg
	mov ah, 9
	int 21h
	
	mov dx, offset init_proc ; сохранение состояния в dos и выход
	int 27h

exit_proc:
	mov dx, offset exit_msg
	mov ah, 9
	int 21h
	
	mov al, 0F3h
	out 60h, al
	
	mov al, 0
	out 60h, al
	
	mov dx, word ptr es:old_vector
	mov ds, word ptr es:old_vector[2]
	mov ah, 25h
	mov al, 1Ch
	int 21h
	
	mov ah, 49h
    int 21h
	
	mov ah, 4Ch
	int 21h
	
	init_msg db 'New interrupt handler installed.', '$'
    exit_msg db 'New interrupt handler uninstalled.', '$'

CSEG ENDS
END main