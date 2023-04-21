#!/bin/bash
cp $1 x$1
# Parse operators, longest first.  A tag should not be a substring of
# another tag.  For example:  QQQ_SHIFTL_EQUALS and QQQ_SHIFTL make
# further substitition more difficult than it should be.

# Ensure leading and trailing spaces
sed --in-place --expression "s/^/ /"					x$1	# Leading space
sed --in-place --expression "s/$/ /"					x$1	# trailing space

# Three-character punctuation
sed --in-place --expression "s/\.\.\./ QQQ_THREEDOTS /g"		x$1	# ...
sed --in-place --expression "s/<<=/ QQQ_SHIFTL_EQUALS /g"		x$1	# <<=
sed --in-place --expression "s/>>=/ QQQ_SHIFTR_EQUALS /g"		x$1	# >>=

# Two-character punctuation
sed --in-place --expression "s/+=/ QQQ_PLUS_EQUALS /g" 			x$1	# +=
sed --in-place --expression "s/-=/ QQQ_MINUS_EQUALS /g" 		x$1	# -=
sed --in-place --expression "s/*=/ QQQ_MUL_EQUALS /g" 			x$1	# *=
sed --in-place --expression "s/\/=/ QQQ_DIV_EQUALS /g" 			x$1	# /=
sed --in-place --expression "s/%=/ QQQ_MOD_EQUALS /g" 			x$1	# %=
sed --in-place --expression "s/&=/ QQQ_AND_EQUALS /g" 			x$1	# &=
sed --in-place --expression "s/|=/ QQQ_OR_EQUALS /g" 			x$1	# |=
sed --in-place --expression "s/\^=/ QQQ_XOR_EQUALS /g" 			x$1	# ^=
sed --in-place --expression "s/!=/ QQQ_NOT_EQUAL /g" 			x$1	# !=
sed --in-place --expression "s/++/ QQQ_PLUSPLUS /g"			x$1	# ++
sed --in-place --expression "s/--/ QQQ_MINUSMINUS /g"			x$1	# --
sed --in-place --expression "s/>>/ QQQ_SHIFT_RIGHT /g"			x$1	# >>
sed --in-place --expression "s/<</ QQQ_SHIFT_LEFT /g"			x$1	# <<
sed --in-place --expression "s/&&/ QQQ_LOGICAL_AND /g"			x$1	# &&
sed --in-place --expression "s/||/ QQQ_LOGICAL_OR /g"			x$1	# ||
sed --in-place --expression "s/==/ QQQ_COMPARE /g"			x$1	# ==
sed --in-place --expression "s/<=/ QQQ_LEQ /g"				x$1	# <=
sed --in-place --expression "s/>=/ QQQ_GEQ /g"				x$1	# >=
sed --in-place --expression "s/->/ QQQ_ARROW /g"			x$1	# ->
sed --in-place --expression "s/\\\\t/ QQQ_TAB /g"				x$1	# \t
sed --in-place --expression "s/\\\\n/ QQQ_CR /g"				x$1	# \n

# Single-character punctuation
sed --in-place --expression "s/\./ QQQ_SINGLE_DOT /g"			x$1	# .
sed --in-place --expression "s/=/ QQQ_SINGLE_EQUALS /g"			x$1	# =
sed --in-place --expression "s/+/ QQQ_SINGLE_PLUS /g"			x$1	# +
sed --in-place --expression "s/-/ QQQ_SINGLE_MINUS /g"			x$1	# -
sed --in-place --expression "s/*/ QQQ_SINGLE_MUL /g"			x$1	# *
sed --in-place --expression "s/\// QQQ_SINGLE_DIV /g"			x$1	# \
sed --in-place --expression "s/%/ QQQ_SINGLE_MOD /g"			x$1	# %
sed --in-place --expression "s/~/ QQQ_BITWISE_NOT /g"			x$1	# !
sed --in-place --expression "s/&/ QQQ_BITWISE_AND /g"			x$1	# &
sed --in-place --expression "s/|/ QQQ_BITWISE_OR /g"			x$1	# |
sed --in-place --expression "s/\^/ QQQ_BITWISE_XOR /g"			x$1	# ^
sed --in-place --expression "s/!/ QQQ_LOGICAL_NOT /g"			x$1	# !
sed --in-place --expression "s/</ QQQ_LESS_THAN /g"			x$1	# <
sed --in-place --expression "s/>/ QQQ_GREATER_THAN /g"			x$1	# >
sed --in-place --expression "s/\[/ QQQ_LBRACKET /g"			x$1	# [
sed --in-place --expression "s/\]/ QQQ_RBRACKET /g"			x$1	# ]
sed --in-place --expression "s/{/ QQQ_LBRACE /g"			x$1	# [
sed --in-place --expression "s/}/ QQQ_RBRACE /g"			x$1	# }
sed --in-place --expression "s/\?/ QQQ_QUIRK /g"			x$1	# ?
sed --in-place --expression "s/(/ QQQ_LPAREN /g"			x$1	# (
sed --in-place --expression "s/)/ QQQ_RPAREN /g"			x$1	# )
sed --in-place --expression "s/:/ QQQ_COLON /g"				x$1	# :
sed --in-place --expression "s/;/ QQQ_SEMICOLON /g"			x$1	# :
sed --in-place --expression "s/\"/ QQQ_DOUBLE_QUOTE /g"			x$1	# "
sed --in-place --expression "s/'/ QQQ_SINGLE_QUOTE /g"			x$1	# '
sed --in-place --expression "s/,/ QQQ_COMMA /g"				x$1	# ,

# Remove tabs
sed --in-place --expression "s/\\t/ /g"					x$1	#

# C keywords
sed --in-place --expression "s/ alignas / RRR_ALIGNAS /g"		x$1	# alignas
sed --in-place --expression "s/ alignof / RRR_ALIGNOF /g"		x$1	# alignof
sed --in-place --expression "s/ auto / RRR_AUTO /g"			x$1	# auto
sed --in-place --expression "s/ bool / RRR_BOOL /g"			x$1	# bool
sed --in-place --expression "s/ break / RRR_BREAK /g"			x$1	# break
sed --in-place --expression "s/ case / RRR_CASE /g"			x$1	# case
sed --in-place --expression "s/ char / RRR_CHAR /g"			x$1	# char
sed --in-place --expression "s/ constexpr / RRR_EXPRCONST /g"		x$1	# constexpr
sed --in-place --expression "s/ const / RRR_CONST /g"			x$1	# const
sed --in-place --expression "s/ continue / RRR_CONTINUE /g"		x$1	# continue
sed --in-place --expression "s/ default / RRR_DEFAULT /g"		x$1	# default
sed --in-place --expression "s/ double / RRR_DOUBLE /g"			x$1	# double
sed --in-place --expression "s/ do / RRR_DOWHILE /g"			x$1	# do
sed --in-place --expression "s/ else / RRR_ELSE /g"			x$1	# else
sed --in-place --expression "s/ enum / RRR_ENUM /g"			x$1	# enum
sed --in-place --expression "s/ extern / RRR_EXTERN /g"			x$1	# extern
sed --in-place --expression "s/ false / RRR_FALSE /g"			x$1	# false
sed --in-place --expression "s/ float / RRR_FLOAT /g"			x$1	# float
sed --in-place --expression "s/ for / RRR_FOR /g"			x$1	# for
sed --in-place --expression "s/ goto / RRR_GOTO /g"			x$1	# goto
sed --in-place --expression "s/ if / RRR_IF /g"				x$1	# if
sed --in-place --expression "s/ inline / RRR_INLINE /g"			x$1	# inline
sed --in-place --expression "s/ int / RRR_INT /g"			x$1	# int
sed --in-place --expression "s/ long / RRR_LONG /g"			x$1	# long
sed --in-place --expression "s/ nullptr / RRR_NULLPTR /g"		x$1	# nullptr
sed --in-place --expression "s/ register / RRR_REGISTER /g"		x$1	# register
sed --in-place --expression "s/ restrict / RRR_RESTRICT /g"		x$1	# restrict
sed --in-place --expression "s/ return / RRR_RETURN /g"			x$1	# return
sed --in-place --expression "s/ short / RRR_SHORT /g"			x$1	# short
sed --in-place --expression "s/ signed / RRR_SIGNED /g"			x$1	# signed
sed --in-place --expression "s/ sizeof / RRR_SIZEOF /g"			x$1	# sizeof
sed --in-place --expression "s/ static / RRR_STATIC /g"			x$1	# static
sed --in-place --expression "s/ static_assert / RRR_SASSERT /g"		x$1	# static_assert
sed --in-place --expression "s/ static / RRR_STATIC /g"			x$1	# static
sed --in-place --expression "s/ struct / RRR_STRUCT /g"			x$1	# struct
sed --in-place --expression "s/ switch / RRR_SWITCH /g"			x$1	# switch
sed --in-place --expression "s/ thread_local / RRR_THRDLCL /g"		x$1	# thread_local
sed --in-place --expression "s/ true / RRR_TRUE /g"			x$1	# true
sed --in-place --expression "s/ typedef / RRR_TYPEDEF /g"		x$1	# typedef
sed --in-place --expression "s/ typeof / RRR_TYPEOF /g"			x$1	# typeof
sed --in-place --expression "s/ typeof_unequal / RRR_NEQTYPEOF /g"	x$1	# typeof_unequal
sed --in-place --expression "s/ typeof / RRR_TYPEOF /g"			x$1	# typeof
sed --in-place --expression "s/ union / RRR_UNION /g"			x$1	# union
sed --in-place --expression "s/ void / RRR_VOID /g"			x$1	# void
sed --in-place --expression "s/ volatile / RRR_VOLATILE /g"		x$1	# volatile
sed --in-place --expression "s/ while / RRR_WHILE /g"			x$1	# while
sed --in-place --expression "s/ while / RRR_WHILE /g"			x$1	# while
sed --in-place --expression "s/ _Alignas / RRR__ALIGNAS /g"		x$1	# _Alignas
sed --in-place --expression "s/ _Alignof / RRR__ALIGNOF /g"		x$1	# _Alignof
sed --in-place --expression "s/ _Atomic / RRR__ATOMIC /g"		x$1	# _Atomic
sed --in-place --expression "s/ _BitInt / RRR__BITINT /g"		x$1	# _BitInt
sed --in-place --expression "s/ _Bool / RRR__BOOL /g"			x$1	# _Bool
sed --in-place --expression "s/ _Complex / RRR__COMPLEX /g"		x$1	# _Complex
sed --in-place --expression "s/ _Decimal128 / RRR__DECIMAL128 /g"	x$1	# _Decimal128
sed --in-place --expression "s/ _Decimal32 / RRR__DECIMAL32 /g"		x$1	# _Decimal32
sed --in-place --expression "s/ _Decimal64 / RRR__DECIMAL64 /g"		x$1	# _Decimal32
sed --in-place --expression "s/ _Generic / RRR__GENERIC /g"		x$1	# _Generic
sed --in-place --expression "s/ _Imaginary / RRR__IMAGINARY /g"		x$1	# _Imaginary
sed --in-place --expression "s/ _Noreturn / RRR__NORETURN /g"		x$1	# _Noreturn
sed --in-place --expression "s/ _Static_assert / RRR__SASSERT /g"	x$1	# _Static_assert
sed --in-place --expression "s/ _Thread_local / RRR__THRDLCL /g"	x$1	# _Thread_local

# Library-defined symbols
sed --in-place --expression "s/ uintptr_t / SSS_UINTPTR_T /g"       x$1 # uintptr_t
sed --in-place --expression "s/ uint64_t / SSS_UINTSIXFOUR_T /g"    x$1 # uint64_t
sed --in-place --expression "s/ uint8_t / SSS_UINTEIGHT_T /g"       x$1 # uint64_t
sed --in-place --expression "s/ fprintf / SSS_FPRINTF /g"           x$1 # fprintf
sed --in-place --expression "s/ printf / SSS_PRINTF /g"             x$1 # printf
sed --in-place --expression "s/ fflush / SSS_FFLUSH /g"             x$1 # fflush
sed --in-place --expression "s/ stdout / SSS_STDOUT /g"             x$1 # stdout
sed --in-place --expression "s/ stderr / SSS_STDERR /g"             x$1 # stderr
sed --in-place --expression "s/ PRIu64 / SSS_PRIUSIXFOUR /g"        x$1 # PRIu64
sed --in-place --expression "s/ srand / SSS_SRAND /g"               x$1 # srand
sed --in-place --expression "s/ time / SSS_TIME /g"                 x$1 # time
sed --in-place --expression "s/ rand / SSS_RAND /g"                 x$1 # rand
sed --in-place --expression "s/ NULL / SSS_NULL /g"                 x$1 # NULL
sed --in-place --expression "s/ main / SSS_MAIN /g"                 x$1 # main

# Constants
sed --in-place --expression "s/ 0xffffffff / CCC_EIGHT_FS /g"       x$1 # 0xffffffff
sed --in-place --expression "s/ 200000 / CCC_TWOHUNDREDK /g"        x$1 # 200000
sed --in-place --expression "s/ 5000 / CCC_FIVEK /g"                x$1 # 5000
sed --in-place --expression "s/ 1024 / CCC_TENTWENTYFOUR /g"        x$1 # 1024
sed --in-place --expression "s/ 1000 / CCC_ONEK /g"                 x$1 # 1000
sed --in-place --expression "s/ 0xff / CCC_FF /g"                   x$1 # 0xff
sed --in-place --expression "s/ 0x80 / CCC_HEXEIGHTY /g"            x$1 # 0x80
sed --in-place --expression "s/ 800 / CCC_EIGHTHUNDRED /g"          x$1 # 800
sed --in-place --expression "s/ 600 / CCC_SIXHUNDRED /g"            x$1 # 600
sed --in-place --expression "s/ 100 / CCC_ONEHUNDRED /g"            x$1 # 100
sed --in-place --expression "s/ c2 / CCC_CTWO /g"                   x$1 # c2
sed --in-place --expression "s/ 4f / CCC_FOURF /g"                  x$1 # 4f
sed --in-place --expression "s/ 26 / CCC_TWOSIX /g"                 x$1 # 26
sed --in-place --expression "s/ 23 / CCC_TWOTHREE /g"               x$1 # 23
sed --in-place --expression "s/ 17 / CCC_TWOTHREE /g"               x$1 # 17
sed --in-place --expression "s/ 16 / CCC_TWOTHREE /g"               x$1 # 16
sed --in-place --expression "s/ 0xf / CCC_FIFTEENH /g"              x$1 # 0xf
sed --in-place --expression "s/ 0xe / CCC_FOURTEENH /g"             x$1 # 0xe
sed --in-place --expression "s/ 0xd / CCC_THIRTEENH /g"             x$1 # 0xd
sed --in-place --expression "s/ 0xc / CCC_TWELVEH /g"               x$1 # 0xc
sed --in-place --expression "s/ 0xb / CCC_ELEVENH /g"               x$1 # 0xb
sed --in-place --expression "s/ 0xa / CCC_TENH /g"                  x$1 # 0xa
sed --in-place --expression "s/ 0x9 / CCC_NINEH /g"                 x$1 # 0x9
sed --in-place --expression "s/ 0x8 / CCC_EIGHTH /g"                x$1 # 0x8
sed --in-place --expression "s/ 0x7 / CCC_SEVENH /g"                x$1 # 0x7
sed --in-place --expression "s/ 0x6 / CCC_SIXH /g"                  x$1 # 0x6
sed --in-place --expression "s/ 0x5 / CCC_FIVEH /g"                 x$1 # 0x5
sed --in-place --expression "s/ 0x4 / CCC_FOURH /g"                 x$1 # 0x4
sed --in-place --expression "s/ 0x3 / CCC_THREEH /g"                x$1 # 0x3
sed --in-place --expression "s/ 0x2 / CCC_TWOH /g"                  x$1 # 0x2
sed --in-place --expression "s/ 0x1 / CCC_ONEH /g"                  x$1 # 0x1
sed --in-place --expression "s/ 0x0 / CCC_ZEROH /g"                 x$1 # 0x0
sed --in-place --expression "s/ 9 / CCC_DNINE /g"                   x$1 # 9
sed --in-place --expression "s/ 8 / CCC_DEIGHT /g"                  x$1 # 8
sed --in-place --expression "s/ 7 / CCC_DSEVEN /g"                  x$1 # 7
sed --in-place --expression "s/ 6 / CCC_DSIX /g"                    x$1 # 6
sed --in-place --expression "s/ 5 / CCC_DFIVE /g"                   x$1 # 5
sed --in-place --expression "s/ 4 / CCC_DFOUR /g"                   x$1 # 4
sed --in-place --expression "s/ 3 / CCC_DTHREE /g"                  x$1 # 3
sed --in-place --expression "s/ 2 / CCC_DTWO /g"                    x$1 # 2
sed --in-place --expression "s/ 1 / CCC_DONE /g"                    x$1 # 1
sed --in-place --expression "s/ 0 / CCC_DZERO /g"                   x$1 # 0



# Smush
cat x$1 			\
| tr "[:blank:]" " "		\
| tr -s " " 			\
| sed --expression "s/ $//"	\
| sed --expression "s/^ //"	\
| tr " " "\n"			\
| grep -v QQQ			\
| grep -v RRR			\
| grep -v SSS			\
| grep -v CCC			\
| sort				\
| uniq				\
| awk '{print length, $0 }'	\
| sort -rn			\
| cut -d " " -f 2		\
> targets

sed --in-place --expression "/^$/d" targets

echo "Targets completed"

declare -a myarray=(`seq -f "%03g" 0 1000`)
counter=1
while read -r line
do
    echo "Hi, Dan!" ${line} ${counter} ${myarray[${counter}]}
	sed --in-place --expression "s/${line}/ VVV_${myarray[${counter}]} /g" x$1
	let counter=counter+1
done < ./targets

