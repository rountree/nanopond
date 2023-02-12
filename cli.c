#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>     // exit(3), strtol(3), calloc(3)
#include <unistd.h>     // optarg
#include <getopt.h>     // getopt_long(3)
#include "cli.h"
void
init_options( struct np_options *o){
    o->inflow_frequency =     100;
    o->inflow_minimum   =     600;
    o->inflow_maximum   =   1'600;
    o->genome_length    =   1'024;
    o->kill_fail_penalty=       3;
    o->mutation_rate    =   5'000;
    o->report_frequency = 200'000;
    o->seed             =       0;
    o->update_frequency = 200'000;
    o->pond_xdim        =     800;
    o->pond_ydim        =     600;
}

static void
option_help(){
    printf("\n");
    printf("Welcome to nanopond!\n");
    printf("This version of nanopond is a reimagining of Adam\n");
    printf("Ierymenko's original program.\n");
    printf("Copyright 2007-2017 Adam Ierymenko <adam.ierymenko@gmail.com>\n");
    printf("git@github.com:adamierymenko/nanopond.git\n");
    printf("Copyright 2023 Lawrence Livermore National Laboratory\n");
    printf("git@github.com:rountree/nanopond.git\n");
    printf("\n");
    printf("Command-line options:\n");
    printf("\n");
    printf("    -a  --inflow-frequency  Number of ticks between the\n"
           "                              introduction of random cells/\n"
           "                              energy.  Default is 100.\n"
           "                              (uint16_t)\n");
    printf("    -b  --inflow-minimum    Minimum amount of energy introduced\n"
           "                              at each --inflow-frequency tick.\n"
           "                              Default is 600.  (uint16_t)\n");
    printf("    -c  --inflow-maximum    Maximum amount of energy introduced\n"
           "                              at each --inflow-frequency tick.\n"
           "                              Default is 1600.  (uint16_t)\n\n");
    printf("    -g  --genome-length     Maximum genome size in 4-bit codons.\n"
           "                              must be a multiple of 16.  Default is\n"
           "                              1024.  (uint16_t)\n\n");
    printf("    -h  --help              Displays this text and exits.\n\n");
    printf("    -k  --kill-fail-penalty Divisor that determines how much\n"
           "                              energy is taken from a cell after\n"
           "                              executing a failed KILL instruction\n"
           "                              Higher numbers result in lower\n"
           "                              penalties.  Default is 3.\n"
           "                              (uint8_t)\n\n");
    printf("    -m  --mutation-rate     Probability of mutation, expressed\n"
           "                              as a decimal integer between 0 and\n"
           "                              4'294'967'295 (aka 0x0'ffff'ffff).\n"
           "                              Default is 5'000, which works out\n"
           "                              to roughly 0.00012%% chance per\n"
           "                              opportunity.  (uint32_t)\n\n");
    printf("    -r  --report-frequency  Frequency of both printing\n"
           "                              comprehensive reports and the SDL\n"
           "                              screen update rate.  Default is\n"
           "                              200'000.  (uint32_t)\n\n");
    printf("    -s  --seed              Set random number seed.  Must be\n"
           "                              between 0 and 65535, inclusive.\n"
           "                              Default is 0, which uses time(2).\n"
           "                              (uint64_t)\n\n");
    printf("    -u  --update-frequency  Rate in clock ticks for how often\n"
           "                              the SDL window should be updated\n"
           "                              with the current state of the pond\n"
           "                              Default is 200'000.  (uint32_t)\n\n");
    printf("    -v  --version           Display the version and exit.\n\n");
    printf("    -x  --pond-xdim         Length of the pond in cells.  Default\n"
           "                              is 800.  (uint16_t)\n\n");
    printf("    -y  --pond-ydim         Breadth of the pond in cells.  \n"
           "                              Default is 600.  (uint16_t)\n\n");
    printf("\n");
    exit(0);

}

static void
option_version(){
    fprintf(stdout, "v3.0-pre0\n");
    exit(0);
}

static void
option_unknown(){

    fprintf(stderr,"Unknown option.  Use -h to list available options.\n");
    exit(-1);
}

static void
option_missing(){

    fprintf(stderr,"%s::%d Placeholder for handling a required argument to a "
            "parameter.\n  No parameters require arguments yet, so you really"
            "shouldn't be seeing this.\n", __FILE__, __LINE__);
    exit(-1);
}

static void
optarg2option( void *p, bool *b, uint8_t nbits ){
    char *endptr;
    // Sanity checking
    if( NULL == optarg ){
        fprintf( stderr, "%s::%d %s wanted to parse optarg, but it's NULL.\n",
                __FILE__, __LINE__, __func__);
        exit(-1);
    }
    if( NULL == p ){
        fprintf( stderr, "%s::%d %s asked to dereference NULL pointer p.\n",
                __FILE__, __LINE__, __func__);
        exit(-1);
    }

    // FIXME
    // I think the only thing using this is --seed.  Can do better.
    if( NULL != b ){
        *b = true;
    }
    switch(nbits){
        case  8: *((uint8_t* )p)=(uint8_t )strtol(optarg, &endptr, 10); break;
        case 16: *((uint16_t*)p)=(uint16_t)strtol(optarg, &endptr, 10); break;
        case 32: *((uint32_t*)p)=(uint32_t)strtol(optarg, &endptr, 10); break;
        case 64: *((uint64_t*)p)=(uint64_t)strtol(optarg, &endptr, 10); break;
        default:
                 fprintf( stderr, "%s::%d nbits must be 8, 16, 32 or 64.\n"
                                  "They are %u instead.\n",
                                  __FILE__, __LINE__, nbits);
                 exit(-1);
    }
    // FIXME Would be nice to add which option we're talking about.
    if( '\0' != *endptr ){
        fprintf( stderr, "Malformed option parameter '%s'.\n", optarg );
        exit(-1);
    }
    if( '\0' == *optarg ){
        fprintf( stderr, "Option parameter is an empty string.\n" );
        exit(-1);
    }
}

void
parse_options( int *argc, char ***argv, struct np_options *o ){

    int c;
    static const char *short_options = "a:b:c:g:hk:m:r:s:u:v:x:y:";
    static struct option long_options[] = {
        {"inflow-frequency",    required_argument,  0, 'a'},
        {"inflow-minimum",      required_argument,  0, 'b'},
        {"inflow-maximum",      required_argument,  0, 'c'},
        {"genome-length",       required_argument,  0, 'g'},
        {"help",                no_argument,        0, 'h'},
        {"kill-fail-penalty",   required_argument,  0, 'k'},
        {"mutation-rate",       required_argument,  0, 'm'},
        {"report-frequency",    required_argument,  0, 'r'},
        {"seed",                required_argument,  0, 's'},
        {"update-frequency",    required_argument,  0, 'u'},
        {"version",             no_argument,        0, 'v'},
        {"pond-xdim",           required_argument,  0, 'x'},
        {"pond-ydim",           required_argument,  0, 'y'},
        {0,                     0,                  0,  0 }
    };

    while(1){
        c = getopt_long( *argc, *argv, short_options, long_options, NULL);
        if( -1 == c ){
            break;
        }
        switch( c ){
            case 'a':   optarg2option( &(o->inflow_frequency), NULL, 16 ); break;
            case 'b':   optarg2option( &(o->inflow_minimum),   NULL, 16 ); break;
            case 'c':   optarg2option( &(o->inflow_maximum),   NULL, 16 ); break;
            case 'g':   optarg2option( &(o->genome_length),    NULL, 16 ); break;
            case 'h':   option_help();      break;
            case 'k':   optarg2option( &(o->kill_fail_penalty),NULL, 16 ); break;
            case 'm':   optarg2option( &(o->mutation_rate),    NULL, 32 ); break;
            case 'r':   optarg2option( &(o->report_frequency), NULL, 32 ); break;
            case 's':   optarg2option( &(o->seed),             NULL, 64 ); break;
            case 'u':   optarg2option( &(o->update_frequency), NULL, 32 ); break;
            case 'v':   option_version();   break;
            case 'x':   optarg2option( &(o->pond_xdim),        NULL, 16 ); break;
            case 'y':   optarg2option( &(o->pond_ydim),        NULL, 16 ); break;
            case '?':   option_unknown();   break;
            case ':':   option_missing();   break;
            default:{
                        fprintf(stderr, "%s::%d "
                                "getopt_long(3) returned character code %#x\n"
                                "That should not have happened.  Bye!\n",
                                __FILE__, __LINE__, c);
                        exit(-1);
                        break;
                    }
        }

    }
}

