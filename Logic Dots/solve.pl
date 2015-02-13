
solve([RowNum | Row], [ColNum | Col], [GridRow | RestOfGridRows], SolvedGrid) :- nl.



list_adder([ ],0).
list_adder([X|L],Sum) :- list_adder(L,SL), Sum is X + SL.

equally(A,B):-
	equals(list_adder(A,0),list_adder(B,0)).

increment(A,B):-
	B is A+1.
	
decrement(A,B):-
	B is A-1.