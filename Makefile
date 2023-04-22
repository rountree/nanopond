cc=clang-13
warn: nanopond.c Makefile
	${cc} -std=c2x -Wall -Wextra -c nanopond.c

obfuscate:
	${cc} -std=c2x -Wall -Wextra -DDISABLE_INCLUDE -E nanopond.c > obfuscated.c
	# Replaces C operators, keywords, library symbols and user symbols, and user strings with tokens.
	./obfuscate.sh obfuscated.c
	# Restores C operators, keywords, library symbols and user strings.
	./unobfuscate.sh obfuscated.c
	# Restores header files.
	sed --in-place --expression "1s/^/#include <stdint.h>\n#include <inttypes.h>\n#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#include <time.h>\n/" obfuscated.c
	# Add a bit of formatting.
	clang-format -i obfuscated.c


test:
	cp test.orig test.c
	./obfuscate.sh test.c

original:
	cc -I/usr/local/include -L/usr/local/lib -Ofast -o nanopond nanopond.c -lSDL2

clean:
	rm -rf *.o nanopond *.dSYM nanopond.o
