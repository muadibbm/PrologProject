/* SWI Prolog libraries used  */
:- use_module(library(lists)).
:- use_module(library(clpfd)).

/* dist predicate using the Knowledge Base */
dist(montreal, ottawa, 103).
dist(montreal, quebecCity, 156).
dist(calgary, edmonton, 172).
dist(vancouver, victoria, 59).
dist(edmonton, lethbridge, 318).
dist(hamilton, sarnia, 143).
dist(victoria, burnaby, 62).
dist(montreal, vancouver, 2290).
dist(ottawa, vancouver, 2200).
dist(vancouver, hamilton, 2681).
dist(edmonton, hamilton, 2122).
dist(hamilton, kingston, 180).
dist(sarnia, kingston, 335).

/* Route predicate */
route(FROM, TO) :-
	dist(FROM, X, _),
	dist(X, TO, _);
	dist(TO, Y, _),
	dist(Y, FROM, _).
	
route(FROM, TO, Route) :- nil.