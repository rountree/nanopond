#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>     // exit(3), strtol(3), calloc(3)
#include <string.h>
#include <time.h>
#include <unistd.h>     // optarg
#include <getopt.h>     // getopt_long(3)
#include <stdbool.h>    // true, false, bool



struct np_options{
    uint16_t inflow_frequency;      // -a   --inflow-frequency
    uint16_t inflow_minimum;        // -b   --inflow-minimum
    uint16_t inflow_maximum;        // -c   --inflow-maximum
    uint16_t genome_length;         // -g   --genome-length
    uint16_t kill_fail_penalty;     // -k   --kill-fail-penalty
    uint32_t mutation_rate;         // -m   --mutation-rate
    uint32_t report_frequency;      // -r   --report-frequency
    uint64_t seed;                  // -s   --seed
    uint32_t update_frequency;      // -u   --update-frequency
    uint16_t pond_xdim;             // -x   --pond-length
    uint16_t pond_ydim;             // -y   --pond-breadth
};

void
parse_options( int *argc, char ***argv, struct np_options *o );

void
init_options( struct np_options *o );
