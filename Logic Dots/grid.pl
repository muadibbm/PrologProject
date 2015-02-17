/* SWI Prolog libraries used  */
:- use_module(library(lists)).
:- use_module(library(clpfd)).

make_grid([RowNum | Row], [ColNum | Col], [X/Y | BlockedPoints], Grid) :- nl.