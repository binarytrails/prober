root_sh_asm:
	gcc -fpic -shared -nostdlib -o root_sh.out root_sh_asm.c

libcrypt1.9.0:
	gcc -Wall -Wextra -g libcrypt1.9.0.c -o libcrypt1.9.0.out -I libgcrypt/src libgcrypt/libs/libgcrypt.so.20.3.0 -lgpg-error -Wl,-rpath,libgcrypt/libs

clean:
	rm -f *.out
