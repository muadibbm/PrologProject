/* SWI Prolog libraries used  */
:- use_module(library(random)).
:- use_module(library(lists)).

/* Split predicate  -------------------------------------------- */
split(List, Size, List1, List2) :-
	split_helper(List, Size, 0, [], List1, List2).
	
split_helper(Tail, Size, Count, AccList1, List1, List2) :-
	Count == Size,
	reverse(AccList1, List1),
	List2 = Tail.
	
split_helper([Head | Tail], Size, Count, AccList1, List1, List2) :-
	Size > Count,
	NewCounter is Count + 1,
	split_helper(Tail, Size, NewCounter, [Head | AccList1], List1, List2).
	
/* Compress predicate  -------------------------------------------- */
compress(List, NewList) :-
	compress_helper(List, nil, [], NewList).

compress_helper([], _, AccList, List) :-
	reverse(AccList, List).

compress_helper([Head | Tail], CurrentChar, AccList, List) :-
	Head == CurrentChar,
	compress_helper(Tail, CurrentChar, AccList, List);
	\+ Head == CurrentChar,
	compress_helper(Tail, Head, [Head | AccList], List).
	
/* Pack predicate  -------------------------------------------- */
pack([Head | Tail], NewList) :-
	pack_helper([Head | Tail], Head, [], [], NewList).
	
pack_helper([], _, Subset, AccList, NewList) :-
	reverse([Subset | AccList], NewList).
	
pack_helper([Head | Tail], CurrentChar, AccSubset, AccList, NewList) :-
	Head == CurrentChar,
	pack_helper(Tail, CurrentChar, [Head | AccSubset], AccList, NewList);
	\+ Head == CurrentChar,
	pack_helper(Tail, Head, [Head], [AccSubset | AccList], NewList).
	
/* Remove At predicate  -------------------------------------------- */
remove_at(Element, List, Index, NewList) :-
	remove_at_helper(Element, List, Index, 1, [], NewList).

remove_at_helper(_, [], _, _, TmpList, NewList) :-
	reverse(TmpList, NewList).

remove_at_helper(Element, [Head | Tail], Index, Count, TmpList, NewList) :-
	Index == Count,
	NewCount is Count + 1,
	Element = Head,
	remove_at_helper(Element, Tail, Index, NewCount, TmpList, NewList);
	\+ Index == Count,
	NewCount is Count + 1,
	remove_at_helper(Element, Tail, Index, NewCount, [Head | TmpList], NewList).
	
/* Insert At predicate  -------------------------------------------- */
insert_at(Element, List, Index, NewList) :-
	insert_at_helper(Element, List, Index, 1, [], NewList).
	
insert_at_helper(_, [], _, _, TmpList, NewList) :-
	reverse(TmpList, NewList).

insert_at_helper(Element, [Head | Tail], Index, Count, TmpList, NewList) :-
	Index == Count,
	NewCount is Count + 1,
	NewTmpList = [Element | TmpList],
	insert_at_helper(Element, Tail, Index, NewCount, [Head | NewTmpList], NewList);
	\+ Index == Count,
	NewCount is Count + 1,
	insert_at_helper(Element, Tail, Index, NewCount, [Head | TmpList], NewList).
	
/* Random Selection predicate  -------------------------------------------- */
rnd_select(List,Number,NewList) :-
	rnd_select_helper(List, 0, Number, [], NewList).
	
rnd_select_helper(List, Count, Number, IncList, NewList) :-
	length(List, Length),
	Number > Length,
	NewList = IncList;
	Count == Number,
	NewList = IncList;
	Count < Number,
	random_member(RandomElement, List),
	rnd_select_helper2(List, RandomElement, Count, Number, IncList, NewList).
	
rnd_select_helper2(List, RandomElement, Count, Number, IncList, NewList) :-
	\+ member(RandomElement, IncList),
	NewCount is Count + 1,
	rnd_select_helper(List, NewCount, Number, [RandomElement | IncList], NewList);
	member(RandomElement, IncList),
	rnd_select_helper(List, Count, Number, IncList, NewList).

/* Random Selection predicate  -------------------------------------------- */
rnd_permu(List,NewList) :-
	length(List, Length),
	rnd_select(List,Length,NewList).