# Building the SDL library with -j requires cmake@3.12+

SDL_CFLAGS=`./SDL/install/bin/sdl2-config --cflags`
SDL_LIB=`./SDL/install/bin/sdl2-config --libs`

# This should build everything.
all: sdl-init sdl-install np

# nanopond targets
np:
	gcc $(SDL_CFLAGS) -Ofast -o nanopond nanopond.c $(SDL_LIB) -lpthread


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
	rm -rf *.o nanopond *.dSYM

sdl-clean:
	cd ./SDL; git clean -dfx; cd -


