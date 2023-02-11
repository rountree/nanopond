# Building the SDL library with -j requires cmake@3.12+
all:
	cc -I/usr/local/include -L/usr/local/lib -Ofast -o nanopond nanopond.c -lSDL2

clean:
	rm -rf *.o nanopond *.dSYM
	cd ./SDL; git clean -dfx; cd -

sdl-init:
	git submodule init
	git submodule update

sdl-install:
	cmake -S ./SDL -B ./SDL/build
	cmake --build ./SDL/build -j
	cmake --install ./SDL/build --prefix=${PWD}/SDL/install


