CC := gcc
CFLAGS := -std=c99 -Wall -Werror
AC := nasm
AFLAGS := -felf64

app.exe: strcpy.o main.o
	gcc -o app.exe $^

strcpy.o: strcpy.asm
	$(AC) $(AFLAGS) $< -o $@

main.o: main.c
	$(CC) $(CGLAGS) -c $<

run: app.exe
	./app.exe

clean:
	rm -f *.o *.exe *.s
