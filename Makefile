warn: nanopond.c Makefile
	clang-13 -std=c2x -Wall -Wextra -c nanopond.c

preprocess:
	clang-13 -std=c2x -Wall -Wextra -DDISABLE_INCLUDE -E nanopond.c > np1.c
	sed --in-place --expression "/^#/d" np1.c
	./obfuscate.sh np1.c


original:
	cc -I/usr/local/include -L/usr/local/lib -Ofast -o nanopond nanopond.c -lSDL2

clean:
	rm -rf *.o nanopond *.dSYM nanopond.o
