
solve(Row,Column,Blocked,Node,Path):-
	equally(Row,Column),
	list_adder(Row,Total),
	breadthfirst(Row,Column,Blocked,Total,[[Node]],RevPath),
	reverse(RevPath,Path).


breadthfirst(Row,Column,Blocked,Total,[[Node|Path]|_],[Node|Path]):-
	goal(Row,Column,Total,Node).

breadthfirst(Row,Column,Blocked,Total,[Path|Paths],SolutionPath):-
 	expand_breadthfirst(Row,Column,Blocked,Total,Path,ExpPaths),
	append(Paths,ExpPaths,NewPaths),
 	breadthfirst(Row,Column,Blocked,Total,NewPaths,SolutionPath).

expand_breadthfirst(Row,Column,Blocked,Total,[Node|Path],ExpPaths):-
 	findall([NewNode,Node|Path],
	move_cyclefree(Row,Column,Blocked,Total,Path,Node,NewNode),
	ExpPaths).

move_cyclefree(Row,Column,Blocked,Total,Visited,Node,NextNode):-
	member(X, [0,1]),
	markDot(Node,Blocked,X,Row,Column,NextNode,NewRow,NewColumn),
	\+ member(NextNode,Visited).

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
%X is the index,list,index,newList	
remove_at(X,[X|Xs],1,Xs).
remove_at(X,[Y|Xs],K,[Y|Ys]) :- K > 1, 
   K1 is K - 1, remove_at(X,Xs,K1,Ys).

%X is the element,List,position,Newlist
insert_at(X,L,K,R) :- remove_at(X,R,K,L).

decrementAt(I,List,NewList):-
	J is I + 1,
	nth0(I,List,Value),
	remove_at(Junk,List,J,NewList1),
	NewValue is Value - 1,
	insert_at(NewValue,NewList1,J,NewList).
	
markDot(Dotted,Blocked,X,Row,Column,NewDotted,NewRow,NewColumn):-
	member(Y, [0,1]),
	\+ member(X/Y,Blocked),
	nth0(X,Row,RConstraint),
	RConstraint \= 0,
	nth0(Y,Column,CConstraint),
	CConstraint \= 0,
	append([X/Y],Dotted,NewDotted),
	decrementAt(X,Row,NewRow),
	decrementAt(Y,Column,NewColumn).
	%Row = NewRow,
	%Column = NewColumn.

goal(Row,Column,Total,Dotted):- 
	checkSumEquality(Row,0),
	checkSumEquality(Column,0),
	length(Dotted, Length),
	Total == Length.