/* SWI Prolog libraries used  */
:- use_module(library(lists)).
:- use_module(library(clpfd)).

solve(Row,Column,Blocked,Node,Path):-
	equally(Row,Column),
	list_adder(Row,Total),
	depthfirst(Row,Column,Blocked,[Node],Node,RevPath,Total),
	reverse(RevPath,Path).

depthfirst(Row,Column,_,Visited,Node,Visited,Total):-
	goal(Row,Column,Total,Node).

depthfirst(Row,Column,Blocked,Visited,Node,Path,Total):-
	move_cyclefree(Row,Column,Blocked,Visited,Node,NextNode,NewRow,NewColumn),
	depthfirst(NewRow,NewColumn,Blocked,[NextNode|Visited],NextNode,Path,Total).

move_cyclefree(Row,Column,Blocked,Visited,Node,NextNode,NewRow,NewColumn):-
	move(Node,Blocked,Row,Column,NextNode,NewRow,NewColumn),
	\+ member(NextNode,Visited).

checkSumEquality(L, S) :- Sum = S, list_adder(L, Sum).
 
checkTotal(G,T):- Occ=T,occurrences(G,o,Occ).

list_adder([],0).
list_adder([X|L],Sum) :- list_adder(L,SL), Sum is X + SL.

occurrences([],_,0).
occurrences([X|Y],X,N):- occurrences(Y,X,W),N is W + 1.
occurrences([X|Y],Z,N):- occurrences(Y,Z,N),X\=Z.	

equally(A,B):-
	list_adder(A,SA),
	list_adder(B,SB),
	SA == SB.

decrement(A,B):-
	B is A-1.
%X is the index,list,index,newList	
remove_at(X,[X|Xs],1,Xs).
remove_at(X,[Y|Xs],K,[Y|Ys]) :- K > 1, 
   K1 is K - 1, remove_at(X,Xs,K1,Ys).

%X is the element,List,position,Newlist
insert_at(X,L,K,R) :- remove_at(X,R,K,L).

decrementAt(I,List,NewList):-
	J is I + 1,
	nth0(I,List,Value),
	remove_at(_,List,J,NewList1),
	NewValue is Value - 1,
	insert_at(NewValue,NewList1,J,NewList).

move(Dotted,Blocked,Row,Column,[X/Y|Dotted],NewRow,NewColumn):-
	member(X, [0,1,2,3,4,5,6]),
	member(Y, [0,1,2,3,4,5,6]),
	\+ member(X/Y,Blocked),
	nth0(X,Row,RConstraint),
	RConstraint \= 0,
	nth0(Y,Column,CConstraint),
	CConstraint \= 0,
	decrementAt(X,Row,NewRow),
	decrementAt(Y,Column,NewColumn).

goal(Row,Column,Total,Dotted):- 
	checkSumEquality(Row,0),
	checkSumEquality(Column,0),
	length(Dotted, Length),
	Total == Length.