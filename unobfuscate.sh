#!/bin/bash
	cp $1 y$1
	# Parse operators, longest first.  A tag should not be a substring of
	# another tag.  For example:  QQQ_SHIFTL_EQUALS and QQQ_SHIFTL make
	# further substitition more difficult than it should be.

	# Three characters
	sed --in-place --expression "s/QQQ_THREEDOTS/ ... /g"	y$1	# ...
	sed --in-place --expression "s/QQQ_SHIFTL_EQUALS/ <<= /g"	y$1	# <<=
	sed --in-place --expression "s/QQQ_SHIFTR_EQUALS/ >>= /g"	y$1	# >>=

	# Two characters
	sed --in-place --expression "s/QQQ_PLUS_EQUALS/ += /g" 		y$1	# +=
	sed --in-place --expression "s/QQQ_MINUS_EQUALS/ -= /g" 	y$1	# -=
	sed --in-place --expression "s/QQQ_MUL_EQUALS/ *=  /g" 		y$1	# *=
	sed --in-place --expression "s/QQQ_DIV_EQUALS/ \/= /g" 		y$1	# /=
	sed --in-place --expression "s/QQQ_MOD_EQUALS/ %= /g" 		y$1	# %=
	sed --in-place --expression "s/QQQ_AND_EQUALS/ \&= /g" 		y$1	# &=
	sed --in-place --expression "s/QQQ_OR_EQUALS/ |= /g" 		y$1	# |=
	sed --in-place --expression "s/QQQ_XOR_EQUALS/ ^= /g" 		y$1	# ^=
	sed --in-place --expression "s/QQQ_NOT_EQUAL/ != /g" 		y$1	# !=
	sed --in-place --expression "s/QQQ_PLUSPLUS/ ++ /g"		y$1	# ++
	sed --in-place --expression "s/QQQ_MINUSMINUS/ -- /g"		y$1	# --
	sed --in-place --expression "s/QQQ_SHIFT_RIGHT/ >> /g"		y$1	# >>
	sed --in-place --expression "s/QQQ_SHIFT_LEFT/ << /g"		y$1	# <<
	sed --in-place --expression "s/QQQ_LOGICAL_AND/ \&\& /g"	y$1	# &&
	sed --in-place --expression "s/QQQ_LOGICAL_OR/ || /g"		y$1	# ||
	sed --in-place --expression "s/QQQ_COMPARE/ == /g"		y$1	# ==
	sed --in-place --expression "s/QQQ_LEQ/ <= /g"			y$1	# <=
	sed --in-place --expression "s/QQQ_GEQ/ >= /g"			y$1	# >=
	sed --in-place --expression "s/QQQ_ARROW/ -> /g"		y$1	# ->
	sed --in-place --expression "s/QQQ_TAB/ \t /g"			y$1	# \t
	sed --in-place --expression "s/QQQ_CR/ \n /g"			y$1	# \n

	# Single character
	sed --in-place --expression "s/QQQ_SINGLE_DOT/ . /g"		y$1	# .
	sed --in-place --expression "s/QQQ_SINGLE_EQUALS/ = /g"		y$1	# =
	sed --in-place --expression "s/QQQ_SINGLE_PLUS/ + /g"		y$1	# +
	sed --in-place --expression "s/QQQ_SINGLE_MINUS/ - /g"		y$1	# -
	sed --in-place --expression "s/QQQ_SINGLE_MUL/ * /g"		y$1	# *
	sed --in-place --expression "s/QQQ_SINGLE_DIV/ \/ /g"		y$1	# \
	sed --in-place --expression "s/QQQ_SINGLE_MOD/ % /g"		y$1	# %
	sed --in-place --expression "s/QQQ_BITWISE_NOT/ ! /g"		y$1	# !
	sed --in-place --expression "s/QQQ_BITWISE_AND/ \& /g"		y$1	# &
	sed --in-place --expression "s/QQQ_BITWISE_OR/ | /g"		y$1	# |
	sed --in-place --expression "s/QQQ_BITWISE_XOR/ % /g"		y$1	# ^
	sed --in-place --expression "s/QQQ_LOGICAL_NOT/ ! /g"		y$1	# !
	sed --in-place --expression "s/QQQ_LESS_THAN/ < /g"		y$1	# <
	sed --in-place --expression "s/QQQ_GREATER_THAN/ > /g"		y$1	# >
	sed --in-place --expression "s/QQQ_LBRACKET/ [ /g"		y$1	# [
	sed --in-place --expression "s/QQQ_RBRACKET/ ] /g"		y$1	# ]
	sed --in-place --expression "s/QQQ_LBRACE/ { /g"		y$1	# [
	sed --in-place --expression "s/QQQ_RBRACE/ } /g"		y$1	# }
	sed --in-place --expression "s/QQQ_QUIRK/ ? /g"			y$1	# ?
	sed --in-place --expression "s/QQQ_LPAREN/ ( /g"		y$1	# (
	sed --in-place --expression "s/QQQ_RPAREN/ ) /g"		y$1	# )
	sed --in-place --expression "s/QQQ_COLON/ : /g"			y$1	# :
	sed --in-place --expression "s/QQQ_SEMICOLON/ ; /g"		y$1	# :
	sed --in-place --expression "s/QQQ_DOUBLE_QUOTE/ \" /g"		y$1	# "
	sed --in-place --expression "s/QQQ_SINGLE_QUOTE/ ' /g"		y$1	# '
	sed --in-place --expression "s/QQQ_COMMA/ , /g"			y$1	# ,


