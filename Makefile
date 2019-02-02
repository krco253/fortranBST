# Assignment 1 Makefile
# Fortran Project

# fortran compiler
FT =  /usr/bin/f95
#executable
PROG = binary_tree-f
#flags
FTFLAGS = -g -Wall

$(PROG): binary_tree.f
	$(FT) $(FTFLAGS) binary_tree.f -o $(PROG) 
