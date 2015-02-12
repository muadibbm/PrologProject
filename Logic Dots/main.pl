
:- consult('grid.pl').
:- consult('solve.pl').

run(RowConstraints, ColConstraints, BlockedCells) :- 
	make_grid(RowConstraints, ColConstraints, BlockedCells, Grid). 
	
%this is the sample grid, we use it like problem(1, Rows), solve(Rows), maplist(writeln, Rows). in the terminal
problem(1, [1,2,3],[1,2,3],[[_,_,_],
							[_,_,_],
							[_,_,_]
							]).
problem(2,[0,1],[0,1],[[_,_],
					   [_,_]]).		