#include <stdio.h>

void my_strcpy(char *dst, char *src, int len);

int my_strlen(char *s)
{
    int len = 0;

    // синтаксис AT&T, поэтому команды записываются так:
    // <команда> <источник>, <приемник>
    asm (
        "movl %%edi, %%ebx\n\t"
        "xorb %%al, %%al\n\t" // al = 0
        "next_symb:\n\t"
            "scasb\n\t" // команда сравнивает значения al и символа строки по адресу es:di, увеличивает di на 1
            "jne next_symb\n\t"
        
        "subl %%ebx, %%edi\n\t" // разность адресов
        "decl %%edi\n\t"
        : "=D"(len) // ответ получить из регитсра edi
        : "D"(s) // запись адреса строки в регистр edi
        : "ebx", "al"
    );

    return len;
}

int main(void)
{
    char before[30], *middle = before + 3, *after = middle + 3;
    char msg[] = "I love assembly (not)";

    int len = my_strlen(msg);
    printf("String lenght = %d\n", len);
    
    printf("Start string: %s\n", msg);

    //         rdi    rsi    edx
    my_strcpy(middle, msg, len);
    printf("Coppied string: %s\n", middle);

    my_strcpy(before, middle, len);
    printf("Span before: %s\n", before);

    my_strcpy(after, before, len);
    printf("Span after: %s\n", after);

    my_strcpy(after, after, len);
    printf("Same string: %s\n", after);

    return 0;
}
