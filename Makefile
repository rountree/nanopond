# Building the SDL library with -j requires cmake@3.12+

SDL_CFLAGS=`./SDL/install/bin/sdl2-config --cflags`
SDL_LIB=`./SDL/install/bin/sdl2-config --libs`

# Only useful in np-t and np-xt targets
NUM_THREADS=32

CFLAGS=-Ofast -Wall -Wextra -Werror -g

# Use this to build everything.
all: sdl-init sdl-install np-all

# nanopond targets:  x=Use SDL for GUI, t=multithreaded using pthreads
np-all: np np-x np-t np-xt

np: nanopond.c
	gcc $(CFLAGS) -o np nanopond.c

np-x: nanopond.c
	gcc -DUSE_SDL $(SDL_CFLAGS) \
		$(CFLAGS) -o np-x nanopond.c $(SDL_LIB)

np-t: nanopond.c
	gcc -DUSE_PTHREAD_COUNT=$(NUM_THREADS) \
		$(CFLAGS) -o np-t nanopond.c -lpthread

np-xt: nanopond.c
	gcc -DUSE_SDL -DUSE_PTHREAD_COUNT=$(NUM_THREADS) $(SDL_CFLAGS) \
		$(CFLAGS) -o np-xt nanopond.c $(SDL_LIB) -lpthread


# sdl targets
sdl-init:
	git submodule init
	git submodule update

sdl-install:
	cmake -S ./SDL -B ./SDL/build
	cmake --build ./SDL/build -j
	cmake --install ./SDL/build --prefix=${PWD}/SDL/install


# clean targets
clean: np-clean sdl-clean

np-clean:
	rm -rf *.o np np-t np-x np-xt *.dSYM

sdl-clean:
	cd ./SDL; git clean -dfx; cd -


