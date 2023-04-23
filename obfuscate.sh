#!/bin/bash

# Special cases
sed --in-place --expression "s/ID/JJ/g"					$1

# Remove preprocesor artifcats
sed --in-place --expression "/^#/d"					$1

# Remove empty lines
sed --in-place --expression "/^$/d"					$1

# Strings are hard
sed --in-place --expression 's/"%"/ ZZZ_STR1 /g'			$1	# "%"
sed --in-place --expression 's/",%"/ ZZZ_STR2 /g'			$1	# ",%"
sed --in-place --expression 's/",%.4f"/ ZZZ_STR3 /g'			$1	# ",%.4f"
sed --in-place --expression 's/",%.4f\\n"/ ZZZ_STR4 /g'			$1	# ",%.4f\n"
sed --in-place --expression 's/"\[EVENT\] Viable replicators have g.*"/ ZZZ_STR5 /g' $1
sed --in-place --expression 's/"\[EVENT\] Viable replicators have a.*"/ ZZZ_STR6 /g' $1

# Ensure leading and trailing spaces
sed --in-place --expression "s/^/ /"					$1	# Leading space
sed --in-place --expression "s/$/ /"					$1	# trailing space

# Three-character punctuation
sed --in-place --expression "s/\.\.\./ QQQ_THREEDOTS /g"		$1	# ...
sed --in-place --expression "s/<<=/ QQQ_SHIFTL_EQUALS /g"		$1	# <<=
sed --in-place --expression "s/>>=/ QQQ_SHIFTR_EQUALS /g"		$1	# >>=

# Two-character punctuation
sed --in-place --expression "s/+=/ QQQ_PLUS_EQUALS /g" 			$1	# +=
sed --in-place --expression "s/-=/ QQQ_MINUS_EQUALS /g" 		$1	# -=
sed --in-place --expression "s/*=/ QQQ_MUL_EQUALS /g" 			$1	# *=
sed --in-place --expression "s/\/=/ QQQ_DIV_EQUALS /g" 			$1	# /=
sed --in-place --expression "s/%=/ QQQ_MOD_EQUALS /g" 			$1	# %=
sed --in-place --expression "s/&=/ QQQ_AND_EQUALS /g" 			$1	# &=
sed --in-place --expression "s/|=/ QQQ_OR_EQUALS /g" 			$1	# |=
sed --in-place --expression "s/\^=/ QQQ_XOR_EQUALS /g" 			$1	# ^=
sed --in-place --expression "s/!=/ QQQ_NOT_EQUAL /g" 			$1	# !=
sed --in-place --expression "s/++/ QQQ_PLUSPLUS /g"			$1	# ++
sed --in-place --expression "s/--/ QQQ_MINUSMINUS /g"			$1	# --
sed --in-place --expression "s/>>/ QQQ_SHIFT_RIGHT /g"			$1	# >>
sed --in-place --expression "s/<</ QQQ_SHIFT_LEFT /g"			$1	# <<
sed --in-place --expression "s/&&/ QQQ_LOGICAL_AND /g"			$1	# &&
sed --in-place --expression "s/||/ QQQ_LOGICAL_OR /g"			$1	# ||
sed --in-place --expression "s/==/ QQQ_COMPARE /g"			$1	# ==
sed --in-place --expression "s/<=/ QQQ_LEQ /g"				$1	# <=
sed --in-place --expression "s/>=/ QQQ_GEQ /g"				$1	# >=
sed --in-place --expression "s/->/ QQQ_ARROW /g"			$1	# ->
sed --in-place --expression "s/\\\\t/ QQQ_TAB /g"			$1	# \t
sed --in-place --expression "s/\\\\n/ QQQ_CR /g"			$1	# \n

# Single-character punctuation
sed --in-place --expression "s/\./ QQQ_SINGLE_DOT /g"			$1	# .
sed --in-place --expression "s/=/ QQQ_SINGLE_EQUALS /g"			$1	# =
sed --in-place --expression "s/+/ QQQ_SINGLE_PLUS /g"			$1	# +
sed --in-place --expression "s/-/ QQQ_SINGLE_MINUS /g"			$1	# -
sed --in-place --expression "s/*/ QQQ_SINGLE_MUL /g"			$1	# *
sed --in-place --expression "s,/, QQQ_SINGLE_DIV ,g"			$1	# /
sed --in-place --expression "s/%/ QQQ_SINGLE_MOD /g"			$1	# %
sed --in-place --expression "s/~/ QQQ_BITWISE_NOT /g"			$1	# !
sed --in-place --expression "s/&/ QQQ_BITWISE_AND /g"			$1	# &
sed --in-place --expression "s/|/ QQQ_BITWISE_OR /g"			$1	# |
sed --in-place --expression "s/\^/ QQQ_BITWISE_XOR /g"			$1	# ^
sed --in-place --expression "s/!/ QQQ_LOGICAL_NOT /g"			$1	# !
sed --in-place --expression "s/</ QQQ_LESS_THAN /g"			$1	# <
sed --in-place --expression "s/>/ QQQ_GREATER_THAN /g"			$1	# >
sed --in-place --expression "s/\[/ QQQ_LBRACKET /g"			$1	# [
sed --in-place --expression "s/\]/ QQQ_RBRACKET /g"			$1	# ]
sed --in-place --expression "s/{/ QQQ_LBRACE /g"			$1	# [
sed --in-place --expression "s/}/ QQQ_RBRACE /g"			$1	# }
sed --in-place --expression "s/\?/ QQQ_QUIRK /g"			$1	# ?
sed --in-place --expression "s/(/ QQQ_LPAREN /g"			$1	# (
sed --in-place --expression "s/)/ QQQ_RPAREN /g"			$1	# )
sed --in-place --expression "s/:/ QQQ_COLON /g"				$1	# :
sed --in-place --expression "s/;/ QQQ_SEMICOLON /g"			$1	# :
sed --in-place --expression "s/\"/ QQQ_DOUBLE_QUOTE /g"			$1	# "
sed --in-place --expression "s/'/ QQQ_SINGLE_QUOTE /g"			$1	# '
sed --in-place --expression "s/,/ QQQ_COMMA /g"				$1	# ,

# Remove tabs
sed --in-place --expression "s/\\t/ /g"					$1	#

# C keywords
sed --in-place --expression "s/ alignas / RRR_ALIGNAS /g"		$1	# alignas
sed --in-place --expression "s/ alignof / RRR_ALIGNOF /g"		$1	# alignof
sed --in-place --expression "s/ auto / RRR_AUTO /g"			$1	# auto
sed --in-place --expression "s/ bool / RRR_BOOL /g"			$1	# bool
sed --in-place --expression "s/ break / RRR_BREAK /g"			$1	# break
sed --in-place --expression "s/ case / RRR_CASE /g"			$1	# case
sed --in-place --expression "s/ char / RRR_CHAR /g"			$1	# char
sed --in-place --expression "s/ constexpr / RRR_EXPRCONST /g"		$1	# constexpr
sed --in-place --expression "s/ const / RRR_CONST /g"			$1	# const
sed --in-place --expression "s/ continue / RRR_CONTINUE /g"		$1	# continue
sed --in-place --expression "s/ default / RRR_DEFAULT /g"		$1	# default
sed --in-place --expression "s/ double / RRR_DOUBLE /g"			$1	# double
sed --in-place --expression "s/ do / RRR_DOWHILE /g"			$1	# do
sed --in-place --expression "s/ else / RRR_ELSE /g"			$1	# else
sed --in-place --expression "s/ enum / RRR_ENUM /g"			$1	# enum
sed --in-place --expression "s/ extern / RRR_EXTERN /g"			$1	# extern
sed --in-place --expression "s/ false / RRR_FALSE /g"			$1	# false
sed --in-place --expression "s/ float / RRR_FLOAT /g"			$1	# float
sed --in-place --expression "s/ for / RRR_FOR /g"			$1	# for
sed --in-place --expression "s/ goto / RRR_GOTO /g"			$1	# goto
sed --in-place --expression "s/ if / RRR_IF /g"				$1	# if
sed --in-place --expression "s/ inline / RRR_INLINE /g"			$1	# inline
sed --in-place --expression "s/ int / RRR_INT /g"			$1	# int
sed --in-place --expression "s/ long / RRR_LONG /g"			$1	# long
sed --in-place --expression "s/ nullptr / RRR_NULLPTR /g"		$1	# nullptr
sed --in-place --expression "s/ register / RRR_REGISTER /g"		$1	# register
sed --in-place --expression "s/ restrict / RRR_RESTRICT /g"		$1	# restrict
sed --in-place --expression "s/ return / RRR_RETURN /g"			$1	# return
sed --in-place --expression "s/ short / RRR_SHORT /g"			$1	# short
sed --in-place --expression "s/ signed / RRR_SIGNED /g"			$1	# signed
sed --in-place --expression "s/ sizeof / RRR_SIZEOF /g"			$1	# sizeof
sed --in-place --expression "s/ static / RRR_STATIC /g"			$1	# static
sed --in-place --expression "s/ static_assert / RRR_SASSERT /g"		$1	# static_assert
sed --in-place --expression "s/ static / RRR_STATIC /g"			$1	# static
sed --in-place --expression "s/ struct / RRR_STRUCT /g"			$1	# struct
sed --in-place --expression "s/ switch / RRR_SWITCH /g"			$1	# switch
sed --in-place --expression "s/ thread_local / RRR_THRDLCL /g"		$1	# thread_local
sed --in-place --expression "s/ true / RRR_TRUE /g"			$1	# true
sed --in-place --expression "s/ typedef / RRR_TYPEDEF /g"		$1	# typedef
sed --in-place --expression "s/ typeof / RRR_TYPEOF /g"			$1	# typeof
sed --in-place --expression "s/ typeof_unequal / RRR_NEQTYPEOF /g"	$1	# typeof_unequal
sed --in-place --expression "s/ typeof / RRR_TYPEOF /g"			$1	# typeof
sed --in-place --expression "s/ union / RRR_UNION /g"			$1	# union
sed --in-place --expression "s/ void / RRR_VOID /g"			$1	# void
sed --in-place --expression "s/ volatile / RRR_VOLATILE /g"		$1	# volatile
sed --in-place --expression "s/ while / RRR_WHILE /g"			$1	# while
sed --in-place --expression "s/ while / RRR_WHILE /g"			$1	# while
sed --in-place --expression "s/ _Alignas / RRR__ALIGNAS /g"		$1	# _Alignas
sed --in-place --expression "s/ _Alignof / RRR__ALIGNOF /g"		$1	# _Alignof
sed --in-place --expression "s/ _Atomic / RRR__ATOMIC /g"		$1	# _Atomic
sed --in-place --expression "s/ _BitInt / RRR__BITINT /g"		$1	# _BitInt
sed --in-place --expression "s/ _Bool / RRR__BOOL /g"			$1	# _Bool
sed --in-place --expression "s/ _Complex / RRR__COMPLEX /g"		$1	# _Complex
sed --in-place --expression "s/ _Decimal128 / RRR__DECIMAL128 /g"	$1	# _Decimal128
sed --in-place --expression "s/ _Decimal32 / RRR__DECIMAL32 /g"		$1	# _Decimal32
sed --in-place --expression "s/ _Decimal64 / RRR__DECIMAL64 /g"		$1	# _Decimal32
sed --in-place --expression "s/ _Generic / RRR__GENERIC /g"		$1	# _Generic
sed --in-place --expression "s/ _Imaginary / RRR__IMAGINARY /g"		$1	# _Imaginary
sed --in-place --expression "s/ _Noreturn / RRR__NORETURN /g"		$1	# _Noreturn
sed --in-place --expression "s/ _Static_assert / RRR__SASSERT /g"	$1	# _Static_assert
sed --in-place --expression "s/ _Thread_local / RRR__THRDLCL /g"	$1	# _Thread_local

# Library-defined symbols
sed --in-place --expression "s/ uintptr_t / SSS_UINTPTR_T /g"       	$1 	# uintptr_t
sed --in-place --expression "s/ uint64_t / SSS_UINTSIXFOUR_T /g"    	$1 	# uint64_t
sed --in-place --expression "s/ uint8_t / SSS_UINTEIGHT_T /g"       	$1 	# uint64_t
sed --in-place --expression "s/ fprintf / SSS_FPRINTF /g"           	$1 	# fprintf
sed --in-place --expression "s/ printf / SSS_PRINTF /g"             	$1 	# printf
sed --in-place --expression "s/ fflush / SSS_FFLUSH /g"             	$1 	# fflush
sed --in-place --expression "s/ stdout / SSS_STDOUT /g"             	$1 	# stdout
sed --in-place --expression "s/ stderr / SSS_STDERR /g"             	$1 	# stderr
sed --in-place --expression "s/ PRIu64 / SSS_PRIUSIXFOUR /g"        	$1 	# PRIu64
sed --in-place --expression "s/ srand / SSS_SRAND /g"               	$1 	# srand
sed --in-place --expression "s/ time / SSS_TIME /g"                 	$1 	# time
sed --in-place --expression "s/ rand / SSS_RAND /g"                 	$1 	# rand
sed --in-place --expression "s/ NULL / SSS_NULL /g"                 	$1 	# NULL
sed --in-place --expression "s/ main / SSS_MAIN /g"                 	$1 	# main

# Constants
sed --in-place --expression "s/ 0xffffffff / CCC_EIGHT_FS /g"       	$1 	# 0xffffffff
sed --in-place --expression "s/ 200000 / CCC_TWOHUNDREDK /g"        	$1 	# 200000
sed --in-place --expression "s/ 5000 / CCC_FIVEK /g"                	$1 	# 5000
sed --in-place --expression "s/ 1024 / CCC_TENTWENTYFOUR /g"        	$1 	# 1024
sed --in-place --expression "s/ 1000 / CCC_ONEK /g"                 	$1 	# 1000
sed --in-place --expression "s/ 0xff / CCC_FF /g"                   	$1 	# 0xff
sed --in-place --expression "s/ 0x80 / CCC_HEXEIGHTY /g"            	$1 	# 0x80
sed --in-place --expression "s/ 800 / CCC_EIGHTHUNDRED /g"          	$1 	# 800
sed --in-place --expression "s/ 600 / CCC_SIXHUNDRED /g"            	$1 	# 600
sed --in-place --expression "s/ 100 / CCC_ONEHUNDRED /g"            	$1 	# 100
sed --in-place --expression "s/ c2 / CCC_HCTWO /g"                   	$1 	# c2
sed --in-place --expression "s/ 4f / CCC_HFOURF /g"                  	$1 	# 4f
sed --in-place --expression "s/ 26 / CCC_DTWOSIX /g"                 	$1 	# 26
sed --in-place --expression "s/ 23 / CCC_DTWOTHREE /g"               	$1 	# 23
sed --in-place --expression "s/ 17 / CCC_DSEVENTEEN /g"               	$1 	# 17
sed --in-place --expression "s/ 16 / CCC_DSIXTEEN /g"               	$1 	# 16
sed --in-place --expression "s/ 13 / CCC_DTHIRTEEN /g"               	$1 	# 13
sed --in-place --expression "s/ 0xf / CCC_HFIFTEEN /g"              	$1 	# 0xf
sed --in-place --expression "s/ 0xe / CCC_HFOURTEEN /g"             	$1 	# 0xe
sed --in-place --expression "s/ 0xd / CCC_HTHIRTEEN /g"             	$1 	# 0xd
sed --in-place --expression "s/ 0xc / CCC_HTWELVE /g"               	$1 	# 0xc
sed --in-place --expression "s/ 0xb / CCC_HELEVEN /g"               	$1 	# 0xb
sed --in-place --expression "s/ 0xa / CCC_HTEN /g"                  	$1 	# 0xa
sed --in-place --expression "s/ 0x9 / CCC_HNINE /g"                 	$1 	# 0x9
sed --in-place --expression "s/ 0x8 / CCC_HEIGHT /g"                	$1 	# 0x8
sed --in-place --expression "s/ 0x7 / CCC_HSEVEN /g"                	$1 	# 0x7
sed --in-place --expression "s/ 0x6 / CCC_HSIX /g"                  	$1 	# 0x6
sed --in-place --expression "s/ 0x5 / CCC_HFIVE /g"                 	$1 	# 0x5
sed --in-place --expression "s/ 0x4 / CCC_HFOUR /g"                 	$1 	# 0x4
sed --in-place --expression "s/ 0x3 / CCC_HTHREE /g"                	$1 	# 0x3
sed --in-place --expression "s/ 0x2 / CCC_HTWO /g"                  	$1 	# 0x2
sed --in-place --expression "s/ 0x1 / CCC_HONE /g"                  	$1 	# 0x1
sed --in-place --expression "s/ 0x0 / CCC_HZERO /g"                 	$1 	# 0x0
sed --in-place --expression "s/ 9 / CCC_DNINE /g"                   	$1 	# 9
sed --in-place --expression "s/ 8 / CCC_DEIGHT /g"                  	$1 	# 8
sed --in-place --expression "s/ 7 / CCC_DSEVEN /g"                  	$1 	# 7
sed --in-place --expression "s/ 6 / CCC_DSIX /g"                    	$1 	# 6
sed --in-place --expression "s/ 5 / CCC_DFIVE /g"                   	$1 	# 5
sed --in-place --expression "s/ 4 / CCC_DFOUR /g"                   	$1 	# 4
sed --in-place --expression "s/ 3 / CCC_DTHREE /g"                  	$1 	# 3
sed --in-place --expression "s/ 2 / CCC_DTWO /g"                    	$1 	# 2
sed --in-place --expression "s/ 1 / CCC_DONE /g"                    	$1 	# 1
sed --in-place --expression "s/ 0 / CCC_DZERO /g"                   	$1 	# 0



# Smush
cat $1 				\
| tr "[:blank:]" " "		\
| tr -s " " 			\
| sed --expression "s/ $//"	\
| sed --expression "s/^ //"	\
| tr " " "\n"			\
| grep -v QQQ			\
| grep -v RRR			\
| grep -v SSS			\
| grep -v CCC			\
| grep -v ZZZ			\
| sort				\
| uniq				\
| awk '{print length, $0 }'	\
| sort -rn			\
| cut -d " " -f 2		\
> targets

echo "Targets completed"

declare -a myarray=(`seq -f "%02g" 0 100`)
counter=1
while read -r line
do
	sed --in-place --expression "s/${line}/ V${myarray[${counter}]} /g" $1
	let counter=counter+1
done < ./targets

