#!/bin/bash

echo "restoring strings"

# User strings
sed --in-place --expression 's/ZZZ_STR1/"%"/g' $1
sed --in-place --expression 's/ZZZ_STR2/",%"/g' $1
sed --in-place --expression 's/ZZZ_STR3/",%.4f"/g' $1
sed --in-place --expression 's/ZZZ_STR4/",%.4f\\n"/g' $1
sed --in-place --expression 's/ZZZ_STR5/"[EVENT] Viable replicators have gone extinct. Please reserve a moment of silence.\\n"/g' $1
sed --in-place --expression 's/ZZZ_STR6/"[EVENT] Viable replicators have appeared!\\n"/g' $1

echo "string restoration complete"

# Three-character punctuation
sed --in-place --expression "s/QQQ_THREEDOTS/ \.\.\. /g"		$1	# ...
sed --in-place --expression "s/QQQ_SHIFTL_EQUALS/ <<= /g"		$1	# <<=
sed --in-place --expression "s/QQQ_SHIFTR_EQUALS/ >>= /g"		$1	# >>=

# Two-character punctuation
sed --in-place --expression "s/QQQ_PLUS_EQUALS/ += /g" 			$1	# +=
sed --in-place --expression "s/QQQ_MINUS_EQUALS/ -= /g" 		$1	# -=
sed --in-place --expression "s/QQQ_MUL_EQUALS/ *= /g" 			$1	# *=
sed --in-place --expression "s/QQQ_DIV_EQUALS/ \/= /g" 			$1	# /=
sed --in-place --expression "s/QQQ_MOD_EQUALS/ %= /g" 			$1	# %=
sed --in-place --expression "s/QQQ_AND_EQUALS/ \&= /g" 			$1	# &=
sed --in-place --expression "s/QQQ_OR_EQUALS/ |= /g" 			$1	# |=
sed --in-place --expression "s/QQQ_XOR_EQUALS/ \^= /g" 			$1	# ^=
sed --in-place --expression "s/QQQ_NOT_EQUAL/ != /g" 			$1	# !=
sed --in-place --expression "s/QQQ_PLUSPLUS/ ++ /g"			$1	# ++
sed --in-place --expression "s/QQQ_MINUSMINUS/ -- /g"			$1	# --
sed --in-place --expression "s/QQQ_SHIFT_RIGHT/ >> /g"			$1	# >>
sed --in-place --expression "s/QQQ_SHIFT_LEFT/ << /g"			$1	# <<
sed --in-place --expression "s/QQQ_LOGICAL_AND/ \&\& /g"		$1	# &&
sed --in-place --expression "s/QQQ_LOGICAL_OR/ || /g"			$1	# ||
sed --in-place --expression "s/QQQ_COMPARE/ == /g"			$1	# ==
sed --in-place --expression "s/QQQ_LEQ/ <= /g"				$1	# <=
sed --in-place --expression "s/QQQ_GEQ/ >= /g"				$1	# >=
sed --in-place --expression "s/QQQ_ARROW/ -> /g"			$1	# ->
sed --in-place --expression "s/QQQ_TAB/ \\\\t /g"			$1	# \t
sed --in-place --expression "s/QQQ_CR/ \\\\n /g"			$1	# \n

# Single-character punctuation
sed --in-place --expression "s/QQQ_SINGLE_DOT/ \. /g"			$1	# .
sed --in-place --expression "s/QQQ_SINGLE_EQUALS/ = /g"			$1	# =
sed --in-place --expression "s/QQQ_SINGLE_PLUS/ + /g"			$1	# +
sed --in-place --expression "s/QQQ_SINGLE_MINUS/ - /g"			$1	# -
sed --in-place --expression "s/QQQ_SINGLE_MUL/ * /g"			$1	# *
sed --in-place --expression "s/QQQ_SINGLE_DIV/ \/ /g"			$1	# \
sed --in-place --expression "s/QQQ_SINGLE_MOD/ % /g"			$1	# %
sed --in-place --expression "s/QQQ_BITWISE_NOT/ ~ /g"			$1	# !
sed --in-place --expression "s/QQQ_BITWISE_AND/ \& /g"			$1	# &
sed --in-place --expression "s/QQQ_BITWISE_OR/ | /g"			$1	# |
sed --in-place --expression "s/QQQ_BITWISE_XOR/ \^ /g"			$1	# ^
sed --in-place --expression "s/QQQ_LOGICAL_NOT/ ! /g"			$1	# !
sed --in-place --expression "s/QQQ_LESS_THAN/ < /g"			$1	# <
sed --in-place --expression "s/QQQ_GREATER_THAN/ > /g"			$1	# >
sed --in-place --expression "s/QQQ_LBRACKET/ \[ /g"			$1	# [
sed --in-place --expression "s/QQQ_RBRACKET/ \] /g"			$1	# ]
sed --in-place --expression "s/QQQ_LBRACE/ { /g"			$1	# [
sed --in-place --expression "s/QQQ_RBRACE/ } /g"			$1	# }
sed --in-place --expression "s/QQQ_QUIRK/ \? /g"			$1	# ?
sed --in-place --expression "s/QQQ_LPAREN/ ( /g"			$1	# (
sed --in-place --expression "s/QQQ_RPAREN/ ) /g"			$1	# )
sed --in-place --expression "s/QQQ_COLON/ : /g"				$1	# :
sed --in-place --expression "s/QQQ_SEMICOLON/ ; /g"			$1	# :
sed --in-place --expression "s/QQQ_DOUBLE_QUOTE/ \" /g"			$1	# "
sed --in-place --expression "s/QQQ_SINGLE_QUOTE/ ' /g"			$1	# '
sed --in-place --expression "s/QQQ_COMMA/ , /g"				$1	# ,

# Remove tabs
sed --in-place --expression "s/\\t/ /g"					$1	#

# C keywords
sed --in-place --expression "s/RRR_ALIGNAS/  alignas  /g"		$1	# alignas
sed --in-place --expression "s/RRR_ALIGNOF/  alignof  /g"		$1	# alignof
sed --in-place --expression "s/RRR_AUTO/  auto  /g"			$1	# auto
sed --in-place --expression "s/RRR_BOOL/  bool  /g"			$1	# bool
sed --in-place --expression "s/RRR_BREAK/  break  /g"			$1	# break
sed --in-place --expression "s/RRR_CASE/  case  /g"			$1	# case
sed --in-place --expression "s/RRR_CHAR/  char  /g"			$1	# char
sed --in-place --expression "s/RRR_EXPRCONST/  constexpr  /g"		$1	# constexpr
sed --in-place --expression "s/RRR_CONST/  const  /g"			$1	# const
sed --in-place --expression "s/RRR_CONTINUE/  continue  /g"		$1	# continue
sed --in-place --expression "s/RRR_DEFAULT/  default  /g"		$1	# default
sed --in-place --expression "s/RRR_DOUBLE/  double  /g"			$1	# double
sed --in-place --expression "s/RRR_DOWHILE/  do  /g"			$1	# do
sed --in-place --expression "s/RRR_ELSE/  else  /g"			$1	# else
sed --in-place --expression "s/RRR_ENUM/  enum  /g"			$1	# enum
sed --in-place --expression "s/RRR_EXTERN/  extern  /g"			$1	# extern
sed --in-place --expression "s/RRR_FALSE/  false  /g"			$1	# false
sed --in-place --expression "s/RRR_FLOAT/  float  /g"			$1	# float
sed --in-place --expression "s/RRR_FOR/  for  /g"			$1	# for
sed --in-place --expression "s/RRR_GOTO/  goto  /g"			$1	# goto
sed --in-place --expression "s/RRR_IF/  if  /g"				$1	# if
sed --in-place --expression "s/RRR_INLINE/  inline  /g"			$1	# inline
sed --in-place --expression "s/RRR_INT/  int  /g"			$1	# int
sed --in-place --expression "s/RRR_LONG/  long  /g"			$1	# long
sed --in-place --expression "s/RRR_NULLPTR/  nullptr  /g"		$1	# nullptr
sed --in-place --expression "s/RRR_REGISTER/  register  /g"		$1	# register
sed --in-place --expression "s/RRR_RESTRICT/  restrict  /g"		$1	# restrict
sed --in-place --expression "s/RRR_RETURN/  return  /g"			$1	# return
sed --in-place --expression "s/RRR_SHORT/  short  /g"			$1	# short
sed --in-place --expression "s/RRR_SIGNED/  signed  /g"			$1	# signed
sed --in-place --expression "s/RRR_SIZEOF/  sizeof  /g"			$1	# sizeof
sed --in-place --expression "s/RRR_STATIC/  static  /g"			$1	# static
sed --in-place --expression "s/RRR_SASSERT/  static_assert  /g"		$1	# static_assert
sed --in-place --expression "s/RRR_STATIC/  static  /g"			$1	# static
sed --in-place --expression "s/RRR_STRUCT/  struct  /g"			$1	# struct
sed --in-place --expression "s/RRR_SWITCH/  switch  /g"			$1	# switch
sed --in-place --expression "s/RRR_THRDLCL/  thread_local  /g"		$1	# thread_local
sed --in-place --expression "s/RRR_TRUE/  true  /g"			$1	# true
sed --in-place --expression "s/RRR_TYPEDEF/  typedef  /g"		$1	# typedef
sed --in-place --expression "s/RRR_TYPEOF/  typeof  /g"			$1	# typeof
sed --in-place --expression "s/RRR_NEQTYPEOF/  typeof_unequal  /g"	$1	# typeof_unequal
sed --in-place --expression "s/RRR_TYPEOF/  typeof  /g"			$1	# typeof
sed --in-place --expression "s/RRR_UNION/  union  /g"			$1	# union
sed --in-place --expression "s/RRR_VOID/  void  /g"			$1	# void
sed --in-place --expression "s/RRR_VOLATILE/  volatile  /g"		$1	# volatile
sed --in-place --expression "s/RRR_WHILE/  while  /g"			$1	# while
sed --in-place --expression "s/RRR_WHILE/  while  /g"			$1	# while
sed --in-place --expression "s/RRR__ALIGNAS/  _Alignas  /g"		$1	# _Alignas
sed --in-place --expression "s/RRR__ALIGNOF/  _Alignof  /g"		$1	# _Alignof
sed --in-place --expression "s/RRR__ATOMIC/  _Atomic  /g"		$1	# _Atomic
sed --in-place --expression "s/RRR__BITINT/  _BitInt  /g"		$1	# _BitInt
sed --in-place --expression "s/RRR__BOOL/  _Bool  /g"			$1	# _Bool
sed --in-place --expression "s/RRR__COMPLEX/  _Complex  /g"		$1	# _Complex
sed --in-place --expression "s/RRR__DECIMAL128/  _Decimal128  /g"	$1	# _Decimal128
sed --in-place --expression "s/RRR__DECIMAL32/  _Decimal32  /g"		$1	# _Decimal32
sed --in-place --expression "s/RRR__DECIMAL64/  _Decimal64  /g"		$1	# _Decimal32
sed --in-place --expression "s/RRR__GENERIC/  _Generic  /g"		$1	# _Generic
sed --in-place --expression "s/RRR__IMAGINARY/  _Imaginary  /g"		$1	# _Imaginary
sed --in-place --expression "s/RRR__NORETURN/  _Noreturn  /g"		$1	# _Noreturn
sed --in-place --expression "s/RRR__SASSERT/  _Static_assert  /g"	$1	# _Static_assert
sed --in-place --expression "s/RRR__THRDLCL/  _Thread_local  /g"	$1	# _Thread_local

# Library-defined symbols
sed --in-place --expression "s/SSS_UINTPTR_T/  uintptr_t  /g"       $1 # uintptr_t
sed --in-place --expression "s/SSS_UINTSIXFOUR_T/  uint64_t  /g"    $1 # uint64_t
sed --in-place --expression "s/SSS_UINTEIGHT_T/  uint8_t  /g"       $1 # uint64_t
sed --in-place --expression "s/SSS_FPRINTF/  fprintf  /g"           $1 # fprintf
sed --in-place --expression "s/SSS_PRINTF/  printf  /g"             $1 # printf
sed --in-place --expression "s/SSS_FFLUSH/  fflush  /g"             $1 # fflush
sed --in-place --expression "s/SSS_STDOUT/  stdout  /g"             $1 # stdout
sed --in-place --expression "s/SSS_STDERR/  stderr  /g"             $1 # stderr
sed --in-place --expression "s/SSS_PRIUSIXFOUR/  PRIu64  /g"        $1 # PRIu64
sed --in-place --expression "s/SSS_SRAND/  srand  /g"               $1 # srand
sed --in-place --expression "s/SSS_TIME/  time  /g"                 $1 # time
sed --in-place --expression "s/SSS_RAND/  rand  /g"                 $1 # rand
sed --in-place --expression "s/SSS_NULL/  NULL  /g"                 $1 # NULL
sed --in-place --expression "s/SSS_MAIN/  main  /g"                 $1 # main

# Constants
sed --in-place --expression "s/CCC_EIGHT_FS/  0xffffffff  /g"       $1 # 0xffffffff
sed --in-place --expression "s/CCC_TWOHUNDREDK/  200000  /g"        $1 # 200000
sed --in-place --expression "s/CCC_FIVEK/  5000  /g"                $1 # 5000
sed --in-place --expression "s/CCC_TENTWENTYFOUR/  1024  /g"        $1 # 1024
sed --in-place --expression "s/CCC_ONEK/  1000  /g"                 $1 # 1000
sed --in-place --expression "s/CCC_FF/  0xff  /g"                   $1 # 0xff
sed --in-place --expression "s/CCC_HEXEIGHTY/  0x80  /g"            $1 # 0x80
sed --in-place --expression "s/CCC_EIGHTHUNDRED/  800  /g"          $1 # 800
sed --in-place --expression "s/CCC_SIXHUNDRED/  600  /g"            $1 # 600
sed --in-place --expression "s/CCC_ONEHUNDRED/  100  /g"            $1 # 100
sed --in-place --expression "s/CCC_HCTWO/  c2  /g"                  $1 # c2
sed --in-place --expression "s/CCC_HFOURF/  4f  /g"                 $1 # 4f
sed --in-place --expression "s/CCC_DTWOSIX/  26  /g"                $1 # 26
sed --in-place --expression "s/CCC_DTWOTHREE/  23  /g"              $1 # 23
sed --in-place --expression "s/CCC_DSEVENTEEN/  17  /g"             $1 # 17
sed --in-place --expression "s/CCC_DSIXTEEN/  16  /g"               $1 # 16
sed --in-place --expression "s/CCC_DTHIRTEEN/  13  /g"              $1 # 13
sed --in-place --expression "s/CCC_HFIFTEEN/  0xf  /g"              $1 # 0xf
sed --in-place --expression "s/CCC_HFOURTEEN/  0xe  /g"             $1 # 0xe
sed --in-place --expression "s/CCC_HTHIRTEEN/  0xd  /g"             $1 # 0xd
sed --in-place --expression "s/CCC_HTWELVE/  0xc  /g"               $1 # 0xc
sed --in-place --expression "s/CCC_HELEVEN/  0xb  /g"               $1 # 0xb
sed --in-place --expression "s/CCC_HTEN/  0xa  /g"                  $1 # 0xa
sed --in-place --expression "s/CCC_HNINE/  0x9  /g"                 $1 # 0x9
sed --in-place --expression "s/CCC_HEIGHT/  0x8  /g"                $1 # 0x8
sed --in-place --expression "s/CCC_HSEVEN/  0x7  /g"                $1 # 0x7
sed --in-place --expression "s/CCC_HSIX/  0x6  /g"                  $1 # 0x6
sed --in-place --expression "s/CCC_HFIVE/  0x5  /g"                 $1 # 0x5
sed --in-place --expression "s/CCC_HFOUR/  0x4  /g"                 $1 # 0x4
sed --in-place --expression "s/CCC_HTHREE/  0x3  /g"                $1 # 0x3
sed --in-place --expression "s/CCC_HTWO/  0x2  /g"                  $1 # 0x2
sed --in-place --expression "s/CCC_HONE/  0x1  /g"                  $1 # 0x1
sed --in-place --expression "s/CCC_HZERO/  0x0  /g"                 $1 # 0x0
sed --in-place --expression "s/CCC_DNINE/  9  /g"                   $1 # 9
sed --in-place --expression "s/CCC_DEIGHT/  8  /g"                  $1 # 8
sed --in-place --expression "s/CCC_DSEVEN/  7  /g"                  $1 # 7
sed --in-place --expression "s/CCC_DSIX/  6  /g"                    $1 # 6
sed --in-place --expression "s/CCC_DFIVE/  5  /g"                   $1 # 5
sed --in-place --expression "s/CCC_DFOUR/  4  /g"                   $1 # 4
sed --in-place --expression "s/CCC_DTHREE/  3  /g"                  $1 # 3
sed --in-place --expression "s/CCC_DTWO/  2  /g"                    $1 # 2
sed --in-place --expression "s/CCC_DONE/  1  /g"                    $1 # 1
sed --in-place --expression "s/CCC_DZERO/  0  /g"                   $1 # 0



