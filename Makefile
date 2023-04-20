warn: nanopond.c Makefile
	clang-13 -std=c2x -Wall -Wextra -c nanopond.c

original:
	cc -I/usr/local/include -L/usr/local/lib -Ofast -o nanopond nanopond.c -lSDL2

clean:
	rm -rf *.o nanopond *.dSYM nanopond.o
