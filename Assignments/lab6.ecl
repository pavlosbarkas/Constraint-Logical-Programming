/*
    Ονοματεπώνυμο: Παύλος Μπάρκας 
    Αριθμός Μητρώου: dai18022
*/
%%%Operators
:-op(450,yfx,and).
:-op(500,yfx,or).
:-op(500,yfx,nor).
:-op(450,yfx,nand).
:-op(500,yfx,xor).

:-op(400,fy,--).
:-op(600,xfx,==>).

--Arg1:-not(Arg1).
Arg1 ==> Arg2 :- --Arg1 or Arg2.
Arg1 and Arg2 :- Arg1, Arg2.
Arg1 or _Arg2 :- Arg1.
_Arg1 or Arg2 :-Arg2.
Arg1 xor Arg2 :- Arg1, --Arg2.
Arg1 xor Arg2 :- --Arg1, Arg2.
Arg1 nor Arg2 :- --(Arg1 or Arg2).
Arg1 nand Arg2 :- --(Arg1 and Arg2).

t.
f:-!,fail.

%%%Exercise 8
%%%model/1
model(Lexp):-
    term_variables(Lexp, [X,Y]),
    member(Y, [t,f]),
    member(X, [t,f]),
    Lexp.

model(Lexp):-
    term_variables(Lexp, [X]),
    member(X, [t,f]),
    Lexp.

%%% theory/1
theory([Lexp]) :- 
    Lexp.
theory([H|T]) :- 
    model(H) and theory(T).

%%%Exercise 9
%%% seperate_lists/3
seperate_lists(List,Lets,Nums) :-  
    findall(Y,(member(Y,List),atom(Y)),Lets),
	findall(X,(member(X,List),number(X)),Nums).
