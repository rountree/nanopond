#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>     // exit(3), strtol(3), calloc(3)
#include <string.h>
#include <time.h>
#include <unistd.h>     // optarg
#include <getopt.h>     // getopt_long(3)
#include <stdbool.h>    // true, false, bool
#include "cli.h"
static struct np_options np_option;

#ifdef USE_PTHREADS_COUNT
#include <pthread.h>
#endif

#ifdef USE_SDL
#include <SDL.h>
#endif /* USE_SDL */

/* Pond depth in machine-size words.  This is calculated from
 * np_option.genome_length and the size of the machine word. (The multiplication
 * by two is due to the fact that there are two four-bit values in
 * each eight-bit byte.) */
#define PONDDEPTH_SYSWORDS (np_option.genome_length / (sizeof(uintptr_t) * 2))

/**
 * Structure for a cell in the pond
 */
struct Cell
{
	/* Globally unique cell ID */
	uint64_t ID;

	/* ID of the cell's parent */
	uint64_t parentID;

	/* Counter for original lineages -- equal to the cell ID of
	 * the first cell in the line. */
	uint64_t lineage;

	/* Generations start at 0 and are incremented from there. */
	uintptr_t generation;

	/* Energy level of this cell */
	uintptr_t energy;

	/* Memory space for cell genome (genome is stored as four
	 * bit instructions packed into machine size words) */
	uintptr_t *genome;

#ifdef USE_PTHREADS_COUNT
	pthread_mutex_t lock;
#endif
};

/* The pond is a 2D array of cells */
static struct Cell **pond;


static void
allocate_pond(){
    pond = calloc( np_option.pond_xdim, sizeof(struct Cell*) );
    if( NULL == pond ){
        fprintf( stderr, "%s:%d %s call to calloc(3) failed.\n",
                __FILE__, __LINE__, __func__);
        exit(-1);
    }
    for( size_t x=0; x<np_option.pond_xdim; x++ ){
        pond[x] = calloc( np_option.pond_ydim, sizeof(struct Cell) );
        if( NULL == pond[x] ){
            fprintf( stderr, "%s:%d %s call to calloc(3) failed.\n",
                    __FILE__, __LINE__, __func__);
            exit(-1);
        }
        for( size_t y=0; y<np_option.pond_ydim; y++){
            pond[x][y].genome = calloc( PONDDEPTH_SYSWORDS, sizeof(uintptr_t) );
        }
    }
}

static void
deallocate_pond(){
    for( size_t x=0; x<np_option.pond_xdim; x++ ){
        for( size_t y=0; y<np_option.pond_ydim; y++ ){
            free( pond[x][y].genome );
        }
        free( pond[x] );
    }
    free( pond );
}

volatile uint64_t prngState[2];
static inline uintptr_t getRandom()
{
	// https://en.wikipedia.org/wiki/Xorshift#xorshift.2B
	uint64_t x = prngState[0];
	const uint64_t y = prngState[1];
	prngState[0] = y;
	x ^= x << 23;
	const uint64_t z = x ^ y ^ (x >> 17) ^ (y >> 26);
	prngState[1] = z;
	return (uintptr_t)(z + y);
}


/* Number of bits in a machine-size word */
#define SYSWORD_BITS (sizeof(uintptr_t) * 8)

/* Constants representing neighbors in the 2D grid. */
#define N_LEFT 0
#define N_RIGHT 1
#define N_UP 2
#define N_DOWN 3

/* Word and bit at which to start execution */
/* This is after the "logo" */
#define EXEC_START_WORD 0
#define EXEC_START_BIT 4

/* Number of bits set in binary numbers 0000 through 1111 */
static const uintptr_t BITS_IN_FOURBIT_WORD[16] = { 0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4 };


/* This is used to generate unique cell IDs */
static volatile uint64_t cellIdCounter = 0;

/* Currently selected color scheme */
#ifdef USE_SDL
enum { KINSHIP,LINEAGE,MAX_COLOR_SCHEME } colorScheme = KINSHIP;
static const char *colorSchemeName[2] = { "KINSHIP", "LINEAGE" };
#endif

#ifdef USE_SDL
static SDL_Window *window;
static SDL_Surface *winsurf;
static SDL_Surface *screen;
#endif

volatile struct {
	/* Counts for the number of times each instruction was
	 * executed since the last report. */
	double instructionExecutions[16];

	/* Number of cells executed since last report */
	double cellExecutions;

	/* Number of viable cells replaced by other cells' offspring */
	uintptr_t viableCellsReplaced;

	/* Number of viable cells KILLed */
	uintptr_t viableCellsKilled;

	/* Number of successful SHARE operations */
	uintptr_t viableCellShares;
} statCounters;

static void doReport(const uint64_t clock)
{
	static uint64_t lastTotalViableReplicators = 0;

	uintptr_t x,y;

	uint64_t totalActiveCells = 0;
	uint64_t totalEnergy = 0;
	uint64_t totalViableReplicators = 0;
	uintptr_t maxGeneration = 0;

	for(x=0;x<np_option.pond_xdim;++x) {
		for(y=0;y<np_option.pond_ydim;++y) {
			struct Cell *const c = &pond[x][y];
			if (c->energy) {
				++totalActiveCells;
				totalEnergy += (uint64_t)c->energy;
				if (c->generation > 2)
					++totalViableReplicators;
				if (c->generation > maxGeneration)
					maxGeneration = c->generation;
			}
		}
	}

	/* Look here to get the columns in the CSV output */

	/* The first five are here and are self-explanatory */
	printf("%lu,%lu,%lu,%lu,%lu,%lu,%lu,%lu",
		(uint64_t)clock,
		(uint64_t)totalEnergy,
		(uint64_t)totalActiveCells,
		(uint64_t)totalViableReplicators,
		(uint64_t)maxGeneration,
		(uint64_t)statCounters.viableCellsReplaced,
		(uint64_t)statCounters.viableCellsKilled,
		(uint64_t)statCounters.viableCellShares
		);

	/* The next 16 are the average frequencies of execution for each
	 * instruction per cell execution. */
	double totalMetabolism = 0.0;
	for(x=0;x<16;++x) {
		totalMetabolism += statCounters.instructionExecutions[x];
		printf(",%.4f",(statCounters.cellExecutions > 0.0) ? (statCounters.instructionExecutions[x] / statCounters.cellExecutions) : 0.0);
	}

	/* The last column is the average metabolism per cell execution */
	printf(",%.4f\n",(statCounters.cellExecutions > 0.0) ? (totalMetabolism / statCounters.cellExecutions) : 0.0);
	fflush(stdout);

	if ((lastTotalViableReplicators > 0)&&(totalViableReplicators == 0))
		fprintf(stderr,"[EVENT] Viable replicators have gone extinct. Please reserve a moment of silence.\n");
	else if ((lastTotalViableReplicators == 0)&&(totalViableReplicators > 0))
		fprintf(stderr,"[EVENT] Viable replicators have appeared!\n");

	lastTotalViableReplicators = totalViableReplicators;

	/* Reset per-report stat counters */
	for(x=0;x<sizeof(statCounters);++x)
		((uint8_t *)&statCounters)[x] = (uint8_t)0;
}
#ifdef USE_SDL
/**
 * Dumps the genome of a cell to a file.
 *
 * @param file Destination
 * @param cell Source
 */
static void dumpCell(FILE *file, struct Cell *cell)
{
	uintptr_t wordPtr,shiftPtr,inst,stopCount,i;

	if (cell->energy&&(cell->generation > 2)) {
		wordPtr = 0;
		shiftPtr = 0;
		stopCount = 0;
		for(i=0;i<np_option.genome_length;++i) {
			inst = (cell->genome[wordPtr] >> shiftPtr) & 0xf;
			/* Four STOP instructions in a row is considered the end.
			 * The probability of this being wrong is *very* small, and
			 * could only occur if you had four STOPs in a row inside
			 * a LOOP/REP pair that's always false. In any case, this
			 * would always result in our *underestimating* the size of
			 * the genome and would never result in an overestimation. */
			fprintf(file,"%x",(unsigned int)inst);
			if (inst == 0xf) { /* STOP */
				if (++stopCount >= 4)
					break;
			} else stopCount = 0;
			if ((shiftPtr += 4) >= SYSWORD_BITS) {
				if (++wordPtr >= PONDDEPTH_SYSWORDS) {
					wordPtr = EXEC_START_WORD;
					shiftPtr = EXEC_START_BIT;
				} else shiftPtr = 0;
			}
		}
	}
	fprintf(file,"\n");
}
#endif //USE_SDL
static inline struct Cell *getNeighbor(const uintptr_t x,const uintptr_t y,const uintptr_t dir)
{
	/* Space is toroidal; it wraps at edges */
	switch(dir){
		case N_LEFT:
			return (x) ? &pond[x-1][y] : &pond[np_option.pond_xdim-1][y];
		case N_RIGHT:
			return (x < (np_option.pond_xdim-1U)) ? &pond[x+1][y] : &pond[0][y];
		case N_UP:
			return (y) ? &pond[x][y-1] : &pond[x][np_option.pond_ydim-1];
		case N_DOWN:
			return (y < (np_option.pond_ydim-1U)) ? &pond[x][y+1] : &pond[x][0];
	}
	return &pond[x][y]; /* This should never be reached */
}

static inline int accessAllowed(struct Cell *const c2,const uintptr_t c1guess,int sense)
{
	/* Access permission is more probable if they are more similar in sense 0,
	 * and more probable if they are different in sense 1. Sense 0 is used for
	 * "negative" interactions and sense 1 for "positive" ones. */
	return sense ? (((getRandom() & 0xf) >= BITS_IN_FOURBIT_WORD[(c2->genome[0] & 0xf) ^ (c1guess & 0xf)])||(!c2->parentID)) : (((getRandom() & 0xf) <= BITS_IN_FOURBIT_WORD[(c2->genome[0] & 0xf) ^ (c1guess & 0xf)])||(!c2->parentID));
}

#ifdef USE_SDL
static inline uint8_t getColor(struct Cell *c)
{
	uintptr_t i,j,word,sum,opcode,skipnext;

	if (c->energy) {
		switch(colorScheme) {
			case KINSHIP:
				/*
				 * Kinship color scheme by Christoph Groth
				 *
				 * For cells of generation > 1, saturation and value are set to maximum.
				 * Hue is a hash-value with the property that related genomes will have
				 * similar hue (but of course, as this is a hash function, totally
				 * different genomes can also have a similar or even the same hue).
				 * Therefore the difference in hue should to some extent reflect the grade
				 * of "kinship" of two cells.
				 */
				if (c->generation > 1) {
					sum = 0;
					skipnext = 0;
					for(i=0;i<PONDDEPTH_SYSWORDS&&(c->genome[i] != ~((uintptr_t)0));++i) {
						word = c->genome[i];
						for(j=0;j<SYSWORD_BITS/4;++j,word >>= 4) {
							/* We ignore 0xf's here, because otherwise very similar genomes
							 * might get quite different hash values in the case when one of
							 * the genomes is slightly longer and uses one more maschine
							 * word. */
							opcode = word & 0xf;
							if (skipnext)
								skipnext = 0;
							else {
								if (opcode != 0xf)
									sum += opcode;
								if (opcode == 0xc) /* 0xc == XCHG */
									skipnext = 1; /* Skip "operand" after XCHG */
							}
						}
					}
					/* For the hash-value use a wrapped around sum of the sum of all
					 * commands and the length of the genome. */
					return (uint8_t)((sum % 192) + 64);
				}
				return 0;
			case LINEAGE:
				/*
				 * Cells with generation > 1 are color-coded by lineage.
				 */
				return (c->generation > 1) ? (((uint8_t)c->lineage) | (uint8_t)1) : 0;
			case MAX_COLOR_SCHEME:
				/* ... never used... to make compiler shut up. */
				break;
		}
	}
	return 0; /* Cells with no energy are black */
}
#endif //USE_SDL
volatile int exitNow = 0;

static void *run(void *targ)
{
	const uintptr_t threadNo = (uintptr_t)targ;
	uintptr_t x,y,i;
	uintptr_t clock = 0;

	/* Buffer used for execution output of candidate offspring */
	uintptr_t outputBuf[PONDDEPTH_SYSWORDS];

	/* Miscellaneous variables used in the loop */
	uintptr_t currentWord,wordPtr,shiftPtr,inst,tmp;
	struct Cell *pptr,*tmpptr;

	/* Virtual machine memory pointer register (which
	 * exists in two parts... read the code below...) */
	uintptr_t ptr_wordPtr;
	uintptr_t ptr_shiftPtr;

	/* The main "register" */
	uintptr_t reg;

	/* Which way is the cell facing? */
	uintptr_t facing;

	/* Virtual machine loop/rep stack */
	uintptr_t loopStack_wordPtr[np_option.genome_length];
	uintptr_t loopStack_shiftPtr[np_option.genome_length];
	uintptr_t loopStackPtr;

	/* If this is nonzero, we're skipping to matching REP */
	/* It is incremented to track the depth of a nested set
	 * of LOOP/REP pairs in false state. */
	uintptr_t falseLoopDepth;

#ifdef USE_SDL
	SDL_Event sdlEvent;
	const uintptr_t sdlPitch = screen->pitch;
#endif

	/* If this is nonzero, cell execution stops. This allows us
	 * to avoid the ugly use of a goto to exit the loop. :) */
	int stop;

	/* Main loop */
	while (!exitNow) {
		/* Increment clock and run reports periodically */
		/* Clock is incremented at the start, so it starts at 1 */
		++clock;
		if ((threadNo == 0)&&(!(clock % np_option.report_frequency))) {
			doReport(clock);
        }
#ifdef USE_SDL
		if ((threadNo == 0)&&(!(clock % np_option.update_frequency))) {
			while (SDL_PollEvent(&sdlEvent)) {
				if (sdlEvent.type == SDL_QUIT) {
					fprintf(stderr,"[QUIT] Quit signal received!\n");
					exitNow = 1;
				} else if (sdlEvent.type == SDL_MOUSEBUTTONDOWN) {
					switch (sdlEvent.button.button) {
						case SDL_BUTTON_LEFT:
							fprintf(stderr,"[INTERFACE] Genome of cell at (%d, %d):\n",sdlEvent.button.x, sdlEvent.button.y);
							dumpCell(stderr, &pond[sdlEvent.button.x][sdlEvent.button.y]);
							break;
						case SDL_BUTTON_RIGHT:
							colorScheme = (colorScheme + 1) % MAX_COLOR_SCHEME;
							fprintf(stderr,"[INTERFACE] Switching to color scheme \"%s\".\n",colorSchemeName[colorScheme]);
							for (y=0;y<np_option.pond_ydim;++y) {
								for (x=0;x<np_option.pond_xdim;++x)
									((uint8_t *)screen->pixels)[x + (y * sdlPitch)] = getColor(&pond[x][y]);
							}
							break;
					}
				}
			}
			SDL_BlitSurface(screen, NULL, winsurf, NULL);
			SDL_UpdateWindowSurface(window);
		}
#endif /* USE_SDL */

		/* Introduce a random cell somewhere with a given energy level */
		/* This is called seeding, and introduces both energy and
		 * entropy into the substrate. This happens every inflow_frequency
		 * clock ticks. */
		if (!(clock % np_option.inflow_frequency)) {
			x = getRandom() % np_option.pond_xdim;
			y = getRandom() % np_option.pond_ydim;
			pptr = &pond[x][y];

#ifdef USE_PTHREADS_COUNT
			pthread_mutex_lock(&(pptr->lock));
#endif

			pptr->ID = cellIdCounter;
			pptr->parentID = 0;
			pptr->lineage = cellIdCounter;
			pptr->generation = 0;
			pptr->energy += np_option.inflow_minimum + (getRandom() % (np_option.inflow_maximum - np_option.inflow_minimum));
			for(i=0;i<PONDDEPTH_SYSWORDS;++i)
				pptr->genome[i] = getRandom();
			++cellIdCounter;

			/* Update the random cell on SDL screen if viz is enabled */
#ifdef USE_SDL
			((uint8_t *)screen->pixels)[x + (y * sdlPitch)] = getColor(pptr);
#endif /* USE_SDL */

#ifdef USE_PTHREADS_COUNT
			pthread_mutex_unlock(&(pptr->lock));
#endif
		}

		/* Pick a random cell to execute */
		i = getRandom();
		x = i % np_option.pond_xdim;
		y = ((i / np_option.pond_xdim) >> 1) % np_option.pond_ydim;
		pptr = &pond[x][y];

		/* Reset the state of the VM prior to execution */
		for(i=0;i<PONDDEPTH_SYSWORDS;++i)
			outputBuf[i] = ~((uintptr_t)0); /* ~0 == 0xfffff... */
		ptr_wordPtr = 0;
		ptr_shiftPtr = 0;
		reg = 0;
		loopStackPtr = 0;
		wordPtr = EXEC_START_WORD;
		shiftPtr = EXEC_START_BIT;
		facing = 0;
		falseLoopDepth = 0;
		stop = 0;

		/* We use a currentWord buffer to hold the word we're
		 * currently working on.  This speeds things up a bit
		 * since it eliminates a pointer dereference in the
		 * inner loop. We have to be careful to refresh this
		 * whenever it might have changed... take a look at
		 * the code. :) */
		currentWord = pptr->genome[0];

		/* Keep track of how many cells have been executed */
		statCounters.cellExecutions += 1.0;

		/* Core execution loop */
		while ((pptr->energy)&&(!stop)) {
			/* Get the next instruction */
			inst = (currentWord >> shiftPtr) & 0xf;

			/* Randomly frob either the instruction or the register with a
			 * probability defined by np_option.mutation_rate. This introduces variation,
			 * and since the variation is introduced into the state of the VM
			 * it can have all manner of different effects on the end result of
			 * replication: insertions, deletions, duplications of entire
			 * ranges of the genome, etc. */
			if ((getRandom() & 0xffffffff) < np_option.mutation_rate) {
				tmp = getRandom(); /* Call getRandom() only once for speed */
				if (tmp & 0x80) /* Check for the 8th bit to get random boolean */
					inst = tmp & 0xf; /* Only the first four bits are used here */
				else reg = tmp & 0xf;
			}

			/* Each instruction processed costs one unit of energy */
			--pptr->energy;

			/* Execute the instruction */
			if (falseLoopDepth) {
				/* Skip forward to matching REP if we're in a false loop. */
				if (inst == 0x9) /* Increment false LOOP depth */
					++falseLoopDepth;
				else if (inst == 0xa) /* Decrement on REP */
					--falseLoopDepth;
			} else {
				/* If we're not in a false LOOP/REP, execute normally */

				/* Keep track of execution frequencies for each instruction */
				statCounters.instructionExecutions[inst] += 1.0;

				switch(inst) {
					case 0x0: /* ZERO: Zero VM state registers */
						reg = 0;
						ptr_wordPtr = 0;
						ptr_shiftPtr = 0;
						facing = 0;
						break;
					case 0x1: /* FWD: Increment the pointer (wrap at end) */
						if ((ptr_shiftPtr += 4) >= SYSWORD_BITS) {
							if (++ptr_wordPtr >= PONDDEPTH_SYSWORDS)
								ptr_wordPtr = 0;
							ptr_shiftPtr = 0;
						}
						break;
					case 0x2: /* BACK: Decrement the pointer (wrap at beginning) */
						if (ptr_shiftPtr)
							ptr_shiftPtr -= 4;
						else {
							if (ptr_wordPtr)
								--ptr_wordPtr;
							else ptr_wordPtr = PONDDEPTH_SYSWORDS - 1;
							ptr_shiftPtr = SYSWORD_BITS - 4;
						}
						break;
					case 0x3: /* INC: Increment the register */
						reg = (reg + 1) & 0xf;
						break;
					case 0x4: /* DEC: Decrement the register */
						reg = (reg - 1) & 0xf;
						break;
					case 0x5: /* READG: Read into the register from genome */
						reg = (pptr->genome[ptr_wordPtr] >> ptr_shiftPtr) & 0xf;
						break;
					case 0x6: /* WRITEG: Write out from the register to genome */
						pptr->genome[ptr_wordPtr] &= ~(((uintptr_t)0xf) << ptr_shiftPtr);
						pptr->genome[ptr_wordPtr] |= reg << ptr_shiftPtr;
						currentWord = pptr->genome[wordPtr]; /* Must refresh in case this changed! */
						break;
					case 0x7: /* READB: Read into the register from buffer */
						reg = (outputBuf[ptr_wordPtr] >> ptr_shiftPtr) & 0xf;
						break;
					case 0x8: /* WRITEB: Write out from the register to buffer */
						outputBuf[ptr_wordPtr] &= ~(((uintptr_t)0xf) << ptr_shiftPtr);
						outputBuf[ptr_wordPtr] |= reg << ptr_shiftPtr;
						break;
					case 0x9: /* LOOP: Jump forward to matching REP if register is zero */
						if (reg) {
							if (loopStackPtr >= np_option.genome_length)
								stop = 1; /* Stack overflow ends execution */
							else {
								loopStack_wordPtr[loopStackPtr] = wordPtr;
								loopStack_shiftPtr[loopStackPtr] = shiftPtr;
								++loopStackPtr;
							}
						} else falseLoopDepth = 1;
						break;
					case 0xa: /* REP: Jump back to matching LOOP if register is nonzero */
						if (loopStackPtr) {
							--loopStackPtr;
							if (reg) {
								wordPtr = loopStack_wordPtr[loopStackPtr];
								shiftPtr = loopStack_shiftPtr[loopStackPtr];
								currentWord = pptr->genome[wordPtr];
								/* This ensures that the LOOP is rerun */
								continue;
							}
						}
						break;
					case 0xb: /* TURN: Turn in the direction specified by register */
						facing = reg & 3;
						break;
					case 0xc: /* XCHG: Skip next instruction and exchange value of register with it */
						if ((shiftPtr += 4) >= SYSWORD_BITS) {
							if (++wordPtr >= PONDDEPTH_SYSWORDS) {
								wordPtr = EXEC_START_WORD;
								shiftPtr = EXEC_START_BIT;
							} else shiftPtr = 0;
						}
						tmp = reg;
						reg = (pptr->genome[wordPtr] >> shiftPtr) & 0xf;
						pptr->genome[wordPtr] &= ~(((uintptr_t)0xf) << shiftPtr);
						pptr->genome[wordPtr] |= tmp << shiftPtr;
						currentWord = pptr->genome[wordPtr];
						break;
					case 0xd: /* KILL: Blow away neighboring cell if allowed with penalty on failure */
						tmpptr = getNeighbor(x,y,facing);
						if (accessAllowed(tmpptr,reg,0)) {
							if (tmpptr->generation > 2)
								++statCounters.viableCellsKilled;

							/* Filling first two words with 0xfffff... is enough */
							tmpptr->genome[0] = ~((uintptr_t)0);
							tmpptr->genome[1] = ~((uintptr_t)0);
							tmpptr->ID = cellIdCounter;
							tmpptr->parentID = 0;
							tmpptr->lineage = cellIdCounter;
							tmpptr->generation = 0;
							++cellIdCounter;
						} else if (tmpptr->generation > 2) {
							tmp = pptr->energy / np_option.kill_fail_penalty;
							if (pptr->energy > tmp)
								pptr->energy -= tmp;
							else pptr->energy = 0;
						}
						break;
					case 0xe: /* SHARE: Equalize energy between self and neighbor if allowed */
						tmpptr = getNeighbor(x,y,facing);
						if (accessAllowed(tmpptr,reg,1)) {
#ifdef USE_PTHREADS_COUNT
							pthread_mutex_lock(&(tmpptr->lock));
#endif
							if (tmpptr->generation > 2)
								++statCounters.viableCellShares;
							tmp = pptr->energy + tmpptr->energy;
							tmpptr->energy = tmp / 2;
							pptr->energy = tmp - tmpptr->energy;
#ifdef USE_PTHREADS_COUNT
							pthread_mutex_unlock(&(tmpptr->lock));
#endif
						}
						break;
					case 0xf: /* STOP: End execution */
						stop = 1;
						break;
				}
			}

			/* Advance the shift and word pointers, and loop around
			 * to the beginning at the end of the genome. */
			if ((shiftPtr += 4) >= SYSWORD_BITS) {
				if (++wordPtr >= PONDDEPTH_SYSWORDS) {
					wordPtr = EXEC_START_WORD;
					shiftPtr = EXEC_START_BIT;
				} else shiftPtr = 0;
				currentWord = pptr->genome[wordPtr];
			}
		}

		/* Copy outputBuf into neighbor if access is permitted and there
		 * is energy there to make something happen. There is no need
		 * to copy to a cell with no energy, since anything copied there
		 * would never be executed and then would be replaced with random
		 * junk eventually. See the seeding code in the main loop above. */
		if ((outputBuf[0] & 0xff) != 0xff) {
			tmpptr = getNeighbor(x,y,facing);
#ifdef USE_PTHREADS_COUNT
			pthread_mutex_lock(&(tmpptr->lock));
#endif
			if ((tmpptr->energy)&&accessAllowed(tmpptr,reg,0)) {
				/* Log it if we're replacing a viable cell */
				if (tmpptr->generation > 2)
					++statCounters.viableCellsReplaced;

				tmpptr->ID = ++cellIdCounter;
				tmpptr->parentID = pptr->ID;
				tmpptr->lineage = pptr->lineage; /* Lineage is copied in offspring */
				tmpptr->generation = pptr->generation + 1;

				for(i=0;i<PONDDEPTH_SYSWORDS;++i)
					tmpptr->genome[i] = outputBuf[i];
			}
#ifdef USE_PTHREADS_COUNT
			pthread_mutex_unlock(&(tmpptr->lock));
#endif
		}

		/* Update the neighborhood on SDL screen to show any changes. */
#ifdef USE_SDL
		((uint8_t *)screen->pixels)[x + (y * sdlPitch)] = getColor(pptr);
		if (x) {
			((uint8_t *)screen->pixels)[(x-1) + (y * sdlPitch)] = getColor(&pond[x-1][y]);
			if (x < (np_option.pond_xdim-1))
				((uint8_t *)screen->pixels)[(x+1) + (y * sdlPitch)] = getColor(&pond[x+1][y]);
			else ((uint8_t *)screen->pixels)[y * sdlPitch] = getColor(&pond[0][y]);
		} else {
			((uint8_t *)screen->pixels)[(np_option.pond_xdim-1) + (y * sdlPitch)] = getColor(&pond[np_option.pond_xdim-1][y]);
			((uint8_t *)screen->pixels)[1 + (y * sdlPitch)] = getColor(&pond[1][y]);
		}
		if (y) {
			((uint8_t *)screen->pixels)[x + ((y-1) * sdlPitch)] = getColor(&pond[x][y-1]);
			if (y < (np_option.pond_ydim-1))
				((uint8_t *)screen->pixels)[x + ((y+1) * sdlPitch)] = getColor(&pond[x][y+1]);
			else ((uint8_t *)screen->pixels)[x] = getColor(&pond[x][0]);
		} else {
			((uint8_t *)screen->pixels)[x + ((np_option.pond_ydim-1) * sdlPitch)] = getColor(&pond[x][np_option.pond_ydim-1]);
			((uint8_t *)screen->pixels)[x + sdlPitch] = getColor(&pond[x][1]);
		}
#endif /* USE_SDL */
	}

	return (void *)0;
}

/**
 * Main method
 *
 * @param argc Number of args
 * @param argv Argument array
 */

int main(int argc,char **argv)
{
	uintptr_t i,x,y;
    init_options(&np_option);
    parse_options( &argc, &argv, &np_option );
    allocate_pond();

	/* Seed and init the random number generator */
    if( np_option.seed ){
        srand( (unsigned int)(np_option.seed) );
        prngState[0] = (uint64_t)rand();
        prngState[1] = (uint64_t)rand();
    }else{
        prngState[0] = (uint64_t)time(NULL);
        srand(time(NULL));
        prngState[1] = (uint64_t)rand();
    }

	/* Reset per-report stat counters */
	for(x=0;x<sizeof(statCounters);++x)
		((uint8_t *)&statCounters)[x] = (uint8_t)0;

	/* Set up SDL if we're using it */
#ifdef USE_SDL
	if (SDL_Init(SDL_INIT_VIDEO) < 0 ) {
		fprintf(stderr,"*** Unable to init SDL: %s ***\n",SDL_GetError());
		exit(1);
	}
	atexit(SDL_Quit);
	window = SDL_CreateWindow("nanopond", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, np_option.pond_xdim, np_option.pond_ydim, 0);
	if (!window) {
		fprintf(stderr, "*** Unable to create SDL window: %s ***\n", SDL_GetError());
		exit(1);
	}
	winsurf = SDL_GetWindowSurface(window);
	if (!winsurf) {
		fprintf(stderr, "*** Unable to get SDL window surface: %s ***\n", SDL_GetError());
		exit(1);
	}
	screen = SDL_CreateRGBSurface(0, np_option.pond_xdim, np_option.pond_ydim, 8, 0, 0, 0, 0);
	if (!screen) {
		fprintf(stderr, "*** Unable to create SDL window surface: %s ***\n", SDL_GetError());
		exit(1);
	}
	/* Set palette entries to match the default SDL 1.2.15 palette */
	{
		Uint8 r[8] = {0, 36, 73, 109, 146, 182, 219, 255};
		Uint8 g[8] = {0, 36, 73, 109, 146, 182, 219, 255};
		Uint8 b[4] = {0, 85, 170, 255};
		int curColor = 0;
		for(unsigned int i = 0; i < 8; ++i) {
			for(unsigned int j = 0; j < 8; ++j) {
				for(unsigned int k = 0; k < 4; ++k) {
					SDL_Color color = {r[i], g[j], b[k], 255};
					SDL_SetPaletteColors(screen->format->palette, &color, curColor, 1);
					curColor++;
				}
			}
		}
	}
#endif /* USE_SDL */

	/* Clear the pond and initialize all genomes
	 * to 0xffff... */
	for(x=0;x<np_option.pond_xdim;++x) {
		for(y=0;y<np_option.pond_ydim;++y) {
			pond[x][y].ID = 0;
			pond[x][y].parentID = 0;
			pond[x][y].lineage = 0;
			pond[x][y].generation = 0;
			pond[x][y].energy = 0;
			for(i=0;i<PONDDEPTH_SYSWORDS;++i)
				pond[x][y].genome[i] = ~((uintptr_t)0);
#ifdef USE_PTHREADS_COUNT
			pthread_mutex_init(&(pond[x][y].lock),0);
#endif
		}
	}

#ifdef USE_PTHREADS_COUNT
	pthread_t threads[USE_PTHREADS_COUNT];
	for(i=1;i<USE_PTHREADS_COUNT;++i)
		pthread_create(&threads[i],0,run,(void *)i);
	run((void *)0);
	for(i=1;i<USE_PTHREADS_COUNT;++i)
		pthread_join(threads[i],(void **)0);
#else
	run((void *)0);
#endif

#ifdef USE_SDL
	SDL_FreeSurface(screen);
	SDL_DestroyWindow(window);
#endif /* USE_SDL */
    deallocate_pond();
	return 0;
}
