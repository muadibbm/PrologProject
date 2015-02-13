
:- consult('grid.pl').
:- consult('solve.pl').

problem(1,[0,1],[0,1],[[_,_],
					   [_,_]]).

problem(2, [1,2,3],[1,2,3],[[_,_,_],
							[_,_,_],
							[_,_,_]]).

run(RowConstraints, ColConstraints, BlockedCells) :- 
	make_grid(RowConstraints, ColConstraints, BlockedCells, Grid),
	solve(RowConstraints, ColConstraints, Grid, SolvedGrid),
	output(SolvedGrid).

output([GridRow | RestOfGridRows]) :- nl.
