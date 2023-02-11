# Building the SDL library with -j requires cmake@3.12+

SDL_CFLAGS=`./SDL/install/bin/sdl2-config --cflags`
SDL_LIB=`./SDL/install/bin/sdl2-config --libs`

# Only useful in np-t and np-xt targets
NUM_THREADS=32

# This should build everything.
all: sdl-init sdl-install np-all

# nanopond targets
np-all: np np-x np-t np-xt

np:
	gcc -Ofast -o np nanopond.c

np-x:
	gcc -DUSE_SDL $(SDL_CFLAGS) -Ofast -o np-x nanopond.c $(SDL_LIB)

np-t:
	gcc -DUSE_PTHREAD_COUNT=$(NUM_THREADS) -Ofast -o np-t nanopond.c -lpthread

np-xt:
	gcc -DUSE_SDL -DUSE_PTHREAD_COUNT=$(NUM_THREADS) $(SDL_CFLAGS) -Ofast -o np-xt nanopond.c $(SDL_LIB) -lpthread


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


