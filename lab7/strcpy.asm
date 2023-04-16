global my_strcpy

section .text
my_strcpy:
    xor rcx, rcx ; rcx - длина строки
    mov ecx, edx ; Количество символов для записи
    add ecx, 2 ; Нулевой символ тоже переписать
    dec rdi ; На первый символ
    dec rsi ; На первый символ

    ; rsi - которую копируем
    ; rdi - куда копируем
    cmp rdi, rsi
    JE cpy_exit
    JB cpy_forward ; если меньше
    JMP cpy_backward

    cpy_forward:
        rep movsb ; копирует из rsi в rdi ecx раз
        ret

    cpy_backward:
        add rsi, rcx
        add rdi, rcx
        
        std ; Устанавливает флаг DF в 1, так что при последующих строковых операциях
            ; регистры DI и SI будут уменьшаться.
        rep movsb
        cld ; Сбрасывает флаг DF в 0, так что при последующих строковых операциях регистры DI и SI будут увеличиваться.
        ret

    cpy_exit:
    ret
