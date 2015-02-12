
:- consult('grid.pl').
:- consult('solve.pl').

run(RowConstraints, ColConstraints, BlockedCells) :- 
	make_grid(RowConstraints, ColConstraints, BlockedCells, Grid). 