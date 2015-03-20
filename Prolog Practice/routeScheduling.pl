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
	check_route(FROM, TO, [FROM], _).

/* check if it has reached the target city */
check_route(_, TO, Visited, Route) :-
	member(SOME_CITY, Visited),
	dist(SOME_CITY, TO, _),
	reverse([TO | Visited], Route).
	
/* check if ther are inbetween city */
check_route(FROM, TO, Visited, Route) :-
	dist(FROM, SOME_CITY, _),
	\+ member(SOME_CITY, Visited),
	check_route(SOME_CITY, TO, [SOME_CITY | Visited], Route).
	
/* Route ternary predicate with Route parameter */
route(FROM, TO, Route) :-
	check_route(FROM, TO, [FROM], Route).
	
/* Shortest path predicate returns true if the minimal distance between From and To is Km along Route */
shortestpath(From, To, Route, Km) :-
	check_route(FROM, TO, [FROM], Route).