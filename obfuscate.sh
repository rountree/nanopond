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


# Smush
cat x$1 			\
| tr "[:blank:]" " "		\
| tr -s " " 			\
| sed --expression "s/ $//"	\
| sed --expression "s/^ //"	\
| tr " " "\n"			\
| grep -v QQQ			\
| grep -v RRR			\
| sort				\
| uniq				\
| awk '{print length, $0 }'	\
| sort -rn			\
| cut -d " " -f 2		\
> targets

echo "Targets completed"

declare -a myarray=(`seq -f "%03g" 0 1000`)
counter=1
while read -r line
do
	#echo "Hi! " ${counter} " " ${myarray[${counter}]}
	echo ${line}
	sed --in-place --expression "s/${line}/VVV/g" x$1
	#sed --in-place --expression 's/'"${line}"'/VVV_'"${myarray[${counter}]}"'/g' x$1
	let counter=counter+1
done < ./targets
