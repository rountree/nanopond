# Known to work with
# 	GNU sed 4.7
# 	GNU make 4.3
# 	clang-format 11.0.1-2
# 	clang 13.0.1-6~deb11u1

CC=clang-13
CFLAGS=-std=c2x -Wall -Wextra -O3
LFLAGS=-s

all: np no

np: nanopond.c Makefile
	# np -- nanopond
	# Stock deterministic nanopond, no graphics or multithreading.
	#
	${CC} ${CFLAGS} -DDETERMINISTIC -c nanopond.c
	${CC} ${CFLAGS} ${LFLAGS} -s -o np nanopond.o

no: nanopond.c Makefile obfuscate.sh unobfuscate.sh
	# no -- nanopond obfuscated
	# Stock deterministic obfuscated nanopond, no graphics or multithreading.
	#
	# Run the code through the preprocessor minus the header files.
	${CC} ${CFLAGS} -DDETERMINISTIC -DDISABLE_INCLUDE -E nanopond.c > no.c
	# Replaces C operators, keywords, library symbols and user symbols, and user strings with tokens.
	./obfuscate.sh no.c
	# Restores C operators, keywords, library symbols and user strings.
	./unobfuscate.sh no.c
	# Restores header files.
	sed --in-place --expression "1s/^/#include <stdint.h>\n#include <inttypes.h>\n#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#include <time.h>\n/" no.c
	# Add a bit of formatting.
	clang-format -i no.c
	# Let's build the obfuscated version
	${CC} -std=c2x -Wall -Wextra -O3 -c no.c
	${CC} -std=c2x -Wall -Wextra -O3 -s -o no no.o

test: np no
	md5sum np no
	./np 2>&1 | head -n 100 > np.out
	./no 2>&1 | head -n 100 > no.out
	diff -u np.out no.out

clean:
	rm -rf *.o np no targets no.c
