# $ make --version
# GNU Make 4.1
# Built for x86_64-pc-linux-gnu
# Copyright (C) 1988-2014 Free Software Foundation, Inc.
# License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

PATH_ABS:=../../../lib_dramalife/
DEF_MACROS +="-D DL_NOTE_UNION_PART_BUILD=1"

# Testing - Preprocess err if equal to 3;
DEF_MACROS +="-D DL_NOTE_UNION2_PART_BUILD=2"
CFLAGS:=
DO_NOT_USE_CFLAGS_IN_LIBMAKEFILE=1
