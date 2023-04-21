#!/bin/bash

# Three-character punctuation
sed --in-place --expression "s/QQQ_THREEDOTS/ \.\.\. /g"		x$1	# ...
sed --in-place --expression "s/QQQ_SHIFTL_EQUALS/ <<= /g"		x$1	# <<=
sed --in-place --expression "s/QQQ_SHIFTR_EQUALS/ >>= /g"		x$1	# >>=

# Two-character punctuation
sed --in-place --expression "s/QQQ_PLUS_EQUALS/ += /g" 			x$1	# +=
sed --in-place --expression "s/QQQ_MINUS_EQUALS/ -= /g" 		x$1	# -=
sed --in-place --expression "s/QQQ_MUL_EQUALS/ *= /g" 			x$1	# *=
sed --in-place --expression "s/QQQ_DIV_EQUALS/ \/= /g" 			x$1	# /=
sed --in-place --expression "s/QQQ_MOD_EQUALS/ %= /g" 			x$1	# %=
sed --in-place --expression "s/QQQ_AND_EQUALS/ &= /g" 			x$1	# &=
sed --in-place --expression "s/QQQ_OR_EQUALS/ |= /g" 			x$1	# |=
sed --in-place --expression "s/QQQ_XOR_EQUALS/ \^= /g" 			x$1	# ^=
sed --in-place --expression "s/QQQ_NOT_EQUAL/ != /g" 			x$1	# !=
sed --in-place --expression "s/QQQ_PLUSPLUS/ ++ /g"			x$1	# ++
sed --in-place --expression "s/QQQ_MINUSMINUS/ -- /g"			x$1	# --
sed --in-place --expression "s/QQQ_SHIFT_RIGHT/ >> /g"			x$1	# >>
sed --in-place --expression "s/QQQ_SHIFT_LEFT/ << /g"			x$1	# <<
sed --in-place --expression "s/QQQ_LOGICAL_AND/ && /g"			x$1	# &&
sed --in-place --expression "s/QQQ_LOGICAL_OR/ || /g"			x$1	# ||
sed --in-place --expression "s/QQQ_COMPARE/ == /g"			x$1	# ==
sed --in-place --expression "s/QQQ_LEQ/ <= /g"				x$1	# <=
sed --in-place --expression "s/QQQ_GEQ/ >= /g"				x$1	# >=
sed --in-place --expression "s/QQQ_ARROW/ -> /g"			x$1	# ->
sed --in-place --expression "s/QQQ_TAB/ \\\\t /g"				x$1	# \t
sed --in-place --expression "s/QQQ_CR/ \\\\n /g"				x$1	# \n

# Single-character punctuation
sed --in-place --expression "s/QQQ_SINGLE_DOT/ \. /g"			x$1	# .
sed --in-place --expression "s/QQQ_SINGLE_EQUALS/ = /g"			x$1	# =
sed --in-place --expression "s/QQQ_SINGLE_PLUS/ + /g"			x$1	# +
sed --in-place --expression "s/QQQ_SINGLE_MINUS/ - /g"			x$1	# -
sed --in-place --expression "s/QQQ_SINGLE_MUL/ * /g"			x$1	# *
sed --in-place --expression "s/QQQ_SINGLE_DIV/ \/ /g"			x$1	# \
sed --in-place --expression "s/QQQ_SINGLE_MOD/ % /g"			x$1	# %
sed --in-place --expression "s/QQQ_BITWISE_NOT/ ~ /g"			x$1	# !
sed --in-place --expression "s/QQQ_BITWISE_AND/ & /g"			x$1	# &
sed --in-place --expression "s/QQQ_BITWISE_OR/ | /g"			x$1	# |
sed --in-place --expression "s/QQQ_BITWISE_XOR/ \^ /g"			x$1	# ^
sed --in-place --expression "s/QQQ_LOGICAL_NOT/ ! /g"			x$1	# !
sed --in-place --expression "s/QQQ_LESS_THAN/ < /g"			x$1	# <
sed --in-place --expression "s/QQQ_GREATER_THAN/ > /g"			x$1	# >
sed --in-place --expression "s/QQQ_LBRACKET/ \[ /g"			x$1	# [
sed --in-place --expression "s/QQQ_RBRACKET/ \] /g"			x$1	# ]
sed --in-place --expression "s/QQQ_LBRACE/ { /g"			x$1	# [
sed --in-place --expression "s/QQQ_RBRACE/ } /g"			x$1	# }
sed --in-place --expression "s/QQQ_QUIRK/ \? /g"			x$1	# ?
sed --in-place --expression "s/QQQ_LPAREN/ ( /g"			x$1	# (
sed --in-place --expression "s/QQQ_RPAREN/ ) /g"			x$1	# )
sed --in-place --expression "s/QQQ_COLON/ : /g"				x$1	# :
sed --in-place --expression "s/QQQ_SEMICOLON/ ; /g"			x$1	# :
sed --in-place --expression "s/QQQ_DOUBLE_QUOTE/ \" /g"			x$1	# "
sed --in-place --expression "s/QQQ_SINGLE_QUOTE/ ' /g"			x$1	# '
sed --in-place --expression "s/QQQ_COMMA/ , /g"				x$1	# ,

# Remove tabs
sed --in-place --expression "s/\\t/ /g"					x$1	#

# C keywords
sed --in-place --expression "s/RRR_ALIGNAS/  alignas  /g"		x$1	# alignas
sed --in-place --expression "s/RRR_ALIGNOF/  alignof  /g"		x$1	# alignof
sed --in-place --expression "s/RRR_AUTO/  auto  /g"			x$1	# auto
sed --in-place --expression "s/RRR_BOOL/  bool  /g"			x$1	# bool
sed --in-place --expression "s/RRR_BREAK/  break  /g"			x$1	# break
sed --in-place --expression "s/RRR_CASE/  case  /g"			x$1	# case
sed --in-place --expression "s/RRR_CHAR/  char  /g"			x$1	# char
sed --in-place --expression "s/RRR_EXPRCONST/  constexpr  /g"		x$1	# constexpr
sed --in-place --expression "s/RRR_CONST/  const  /g"			x$1	# const
sed --in-place --expression "s/RRR_CONTINUE/  continue  /g"		x$1	# continue
sed --in-place --expression "s/RRR_DEFAULT/  default  /g"		x$1	# default
sed --in-place --expression "s/RRR_DOUBLE/  double  /g"			x$1	# double
sed --in-place --expression "s/RRR_DOWHILE/  do  /g"			x$1	# do
sed --in-place --expression "s/RRR_ELSE/  else  /g"			x$1	# else
sed --in-place --expression "s/RRR_ENUM/  enum  /g"			x$1	# enum
sed --in-place --expression "s/RRR_EXTERN/  extern  /g"			x$1	# extern
sed --in-place --expression "s/RRR_FALSE/  false  /g"			x$1	# false
sed --in-place --expression "s/RRR_FLOAT/  float  /g"			x$1	# float
sed --in-place --expression "s/RRR_FOR/  for  /g"			x$1	# for
sed --in-place --expression "s/RRR_GOTO/  goto  /g"			x$1	# goto
sed --in-place --expression "s/RRR_IF/  if  /g"				x$1	# if
sed --in-place --expression "s/RRR_INLINE/  inline  /g"			x$1	# inline
sed --in-place --expression "s/RRR_INT/  int  /g"			x$1	# int
sed --in-place --expression "s/RRR_LONG/  long  /g"			x$1	# long
sed --in-place --expression "s/RRR_NULLPTR/  nullptr  /g"		x$1	# nullptr
sed --in-place --expression "s/RRR_REGISTER/  register  /g"		x$1	# register
sed --in-place --expression "s/RRR_RESTRICT/  restrict  /g"		x$1	# restrict
sed --in-place --expression "s/RRR_RETURN/  return  /g"			x$1	# return
sed --in-place --expression "s/RRR_SHORT/  short  /g"			x$1	# short
sed --in-place --expression "s/RRR_SIGNED/  signed  /g"			x$1	# signed
sed --in-place --expression "s/RRR_SIZEOF/  sizeof  /g"			x$1	# sizeof
sed --in-place --expression "s/RRR_STATIC/  static  /g"			x$1	# static
sed --in-place --expression "s/RRR_SASSERT/  static_assert  /g"		x$1	# static_assert
sed --in-place --expression "s/RRR_STATIC/  static  /g"			x$1	# static
sed --in-place --expression "s/RRR_STRUCT/  struct  /g"			x$1	# struct
sed --in-place --expression "s/RRR_SWITCH/  switch  /g"			x$1	# switch
sed --in-place --expression "s/RRR_THRDLCL/  thread_local  /g"		x$1	# thread_local
sed --in-place --expression "s/RRR_TRUE/  true  /g"			x$1	# true
sed --in-place --expression "s/RRR_TYPEDEF/  typedef  /g"		x$1	# typedef
sed --in-place --expression "s/RRR_TYPEOF/  typeof  /g"			x$1	# typeof
sed --in-place --expression "s/RRR_NEQTYPEOF/  typeof_unequal  /g"	x$1	# typeof_unequal
sed --in-place --expression "s/RRR_TYPEOF/  typeof  /g"			x$1	# typeof
sed --in-place --expression "s/RRR_UNION/  union  /g"			x$1	# union
sed --in-place --expression "s/RRR_VOID/  void  /g"			x$1	# void
sed --in-place --expression "s/RRR_VOLATILE/  volatile  /g"		x$1	# volatile
sed --in-place --expression "s/RRR_WHILE/  while  /g"			x$1	# while
sed --in-place --expression "s/RRR_WHILE/  while  /g"			x$1	# while
sed --in-place --expression "s/RRR__ALIGNAS/  _Alignas  /g"		x$1	# _Alignas
sed --in-place --expression "s/RRR__ALIGNOF/  _Alignof  /g"		x$1	# _Alignof
sed --in-place --expression "s/RRR__ATOMIC/  _Atomic  /g"		x$1	# _Atomic
sed --in-place --expression "s/RRR__BITINT/  _BitInt  /g"		x$1	# _BitInt
sed --in-place --expression "s/RRR__BOOL/  _Bool  /g"			x$1	# _Bool
sed --in-place --expression "s/RRR__COMPLEX/  _Complex  /g"		x$1	# _Complex
sed --in-place --expression "s/RRR__DECIMAL128/  _Decimal128  /g"	x$1	# _Decimal128
sed --in-place --expression "s/RRR__DECIMAL32/  _Decimal32  /g"		x$1	# _Decimal32
sed --in-place --expression "s/RRR__DECIMAL64/  _Decimal64  /g"		x$1	# _Decimal32
sed --in-place --expression "s/RRR__GENERIC/  _Generic  /g"		x$1	# _Generic
sed --in-place --expression "s/RRR__IMAGINARY/  _Imaginary  /g"		x$1	# _Imaginary
sed --in-place --expression "s/RRR__NORETURN/  _Noreturn  /g"		x$1	# _Noreturn
sed --in-place --expression "s/RRR__SASSERT/  _Static_assert  /g"	x$1	# _Static_assert
sed --in-place --expression "s/RRR__THRDLCL/  _Thread_local  /g"	x$1	# _Thread_local

# Library-defined symbols
sed --in-place --expression "s/SSS_UINTPTR_T/  uintptr_t  /g"       x$1 # uintptr_t
sed --in-place --expression "s/SSS_UINTSIXFOUR_T/  uint64_t  /g"    x$1 # uint64_t
sed --in-place --expression "s/SSS_UINTEIGHT_T/  uint8_t  /g"       x$1 # uint64_t
sed --in-place --expression "s/SSS_FPRINTF/  fprintf  /g"           x$1 # fprintf
sed --in-place --expression "s/SSS_PRINTF/  printf  /g"             x$1 # printf
sed --in-place --expression "s/SSS_FFLUSH/  fflush  /g"             x$1 # fflush
sed --in-place --expression "s/SSS_STDOUT/  stdout  /g"             x$1 # stdout
sed --in-place --expression "s/SSS_STDERR/  stderr  /g"             x$1 # stderr
sed --in-place --expression "s/SSS_PRIUSIXFOUR/  PRIu64  /g"        x$1 # PRIu64
sed --in-place --expression "s/SSS_SRAND/  srand  /g"               x$1 # srand
sed --in-place --expression "s/SSS_TIME/  time  /g"                 x$1 # time
sed --in-place --expression "s/SSS_RAND/  rand  /g"                 x$1 # rand
sed --in-place --expression "s/SSS_NULL/  NULL  /g"                 x$1 # NULL
sed --in-place --expression "s/SSS_MAIN/  main  /g"                 x$1 # main

# Constants
sed --in-place --expression "s/CCC_EIGHT_FS/  0xffffffff  /g"       x$1 # 0xffffffff
sed --in-place --expression "s/CCC_TWOHUNDREDK/  200000  /g"        x$1 # 200000
sed --in-place --expression "s/CCC_FIVEK/  5000  /g"                x$1 # 5000
sed --in-place --expression "s/CCC_TENTWENTYFOUR/  1024  /g"        x$1 # 1024
sed --in-place --expression "s/CCC_ONEK/  1000  /g"                 x$1 # 1000
sed --in-place --expression "s/CCC_FF/  0xff  /g"                   x$1 # 0xff
sed --in-place --expression "s/CCC_HEXEIGHTY/  0x80  /g"            x$1 # 0x80
sed --in-place --expression "s/CCC_EIGHTHUNDRED/  800  /g"          x$1 # 800
sed --in-place --expression "s/CCC_SIXHUNDRED/  600  /g"            x$1 # 600
sed --in-place --expression "s/CCC_ONEHUNDRED/  100  /g"            x$1 # 100
sed --in-place --expression "s/CCC_CTWO/  c2  /g"                   x$1 # c2
sed --in-place --expression "s/CCC_FOURF/  4f  /g"                  x$1 # 4f
sed --in-place --expression "s/CCC_TWOSIX/  26  /g"                 x$1 # 26
sed --in-place --expression "s/CCC_TWOTHREE/  23  /g"               x$1 # 23
sed --in-place --expression "s/CCC_TWOTHREE/  17  /g"               x$1 # 17
sed --in-place --expression "s/CCC_TWOTHREE/  16  /g"               x$1 # 16
sed --in-place --expression "s/CCC_FIFTEENH/  0xf  /g"              x$1 # 0xf
sed --in-place --expression "s/CCC_FOURTEENH/  0xe  /g"             x$1 # 0xe
sed --in-place --expression "s/CCC_THIRTEENH/  0xd  /g"             x$1 # 0xd
sed --in-place --expression "s/CCC_TWELVEH/  0xc  /g"               x$1 # 0xc
sed --in-place --expression "s/CCC_ELEVENH/  0xb  /g"               x$1 # 0xb
sed --in-place --expression "s/CCC_TENH/  0xa  /g"                  x$1 # 0xa
sed --in-place --expression "s/CCC_NINEH/  0x9  /g"                 x$1 # 0x9
sed --in-place --expression "s/CCC_EIGHTH/  0x8  /g"                x$1 # 0x8
sed --in-place --expression "s/CCC_SEVENH/  0x7  /g"                x$1 # 0x7
sed --in-place --expression "s/CCC_SIXH/  0x6  /g"                  x$1 # 0x6
sed --in-place --expression "s/CCC_FIVEH/  0x5  /g"                 x$1 # 0x5
sed --in-place --expression "s/CCC_FOURH/  0x4  /g"                 x$1 # 0x4
sed --in-place --expression "s/CCC_THREEH/  0x3  /g"                x$1 # 0x3
sed --in-place --expression "s/CCC_TWOH/  0x2  /g"                  x$1 # 0x2
sed --in-place --expression "s/CCC_ONEH/  0x1  /g"                  x$1 # 0x1
sed --in-place --expression "s/CCC_ZEROH/  0x0  /g"                 x$1 # 0x0
sed --in-place --expression "s/CCC_DNINE/  9  /g"                   x$1 # 9
sed --in-place --expression "s/CCC_DEIGHT/  8  /g"                  x$1 # 8
sed --in-place --expression "s/CCC_DSEVEN/  7  /g"                  x$1 # 7
sed --in-place --expression "s/CCC_DSIX/  6  /g"                    x$1 # 6
sed --in-place --expression "s/CCC_DFIVE/  5  /g"                   x$1 # 5
sed --in-place --expression "s/CCC_DFOUR/  4  /g"                   x$1 # 4
sed --in-place --expression "s/CCC_DTHREE/  3  /g"                  x$1 # 3
sed --in-place --expression "s/CCC_DTWO/  2  /g"                    x$1 # 2
sed --in-place --expression "s/CCC_DONE/  1  /g"                    x$1 # 1
sed --in-place --expression "s/CCC_DZERO/  0  /g"                   x$1 # 0



