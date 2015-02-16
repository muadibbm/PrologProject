
solve([RowNum | Row], [ColNum | Col], [GridRow | RestOfGridRows], SolvedGrid) :- nl.

solve(Row,Column,Node,Path):-
	equally(Row,Column),
	list_adder(Row,Total),
	breadthfirst(Row,Column,Total,[[Node]],RevPath),
	reverse(RevPath,Path).

breadthfirst(Row,Column,Total,[[Node|Path]|_],[Node|Path]):-
	goal(Row,Column,Total,Node).



goal(Row,Column,Total,Grid):- 
	checkSumEquality(Row,0),
	checkSumEquality(Column,0),
	flatten(Grid,G),
	checkTotal(G,Total).

checkSumEquality(L, S) :- Sum = S, list_adder(L, Sum).

checkTotal(G,T):- Occ=T,occurrences(G,o,Occ).

list_adder([],0).
list_adder([X|L],Sum) :- list_adder(L,SL), Sum is X + SL.

occurrences([],_,0).
occurrences([X|Y],X,N):- occurrences(Y,X,W),N is W + 1.
occurrences([X|Y],Z,N):- occurrences(Y,Z,N),X\=Z.	

equally(A,B):-
	equals(list_adder(A,_),list_adder(B,_)).

decrement(A,B):-
	B is A-1.