%%%ExecSet6

%%%Exercise 1
%%%less_than_ten/1
sample(2).
sample(5).
sample(14).
sample(7).
sample(26).

less_than_ten(X):-
    findall(N, (sample(N), N<10), Res),
    length(Res, X).

%%%Exercise 2
%%%set_diff/3
set_diff(List1,List2,Diff):-
    findall(X, (member(X,List1), not(member(X,List2))), Diff).

%%%Exercise 3
%%%minlist/2
minlist(Min,List):-
    setof(X, member(X,List), [Min|_]).

%%%Exercise 4
%%%proper_set_s/1
proper_set_s(List):-
    setof(X, member(X,List), Res),
    List == Res.

%%%Exercise 5
%%%map_f/3
square(X,Y):-
    Y is X*X.
double(X,Y):-
    Y is 2*X.

map_f(Op,List,Result):-
    findall(X, map_aux(Op,List,X), Result).

map_aux(Op,List,Res):-
    member(X,List),
    Pred=..[Op,X,Res],
    call(Pred).

%%%Exercise 6
%%%stack
:-dynamic stack/1.
stack([]).

push(X):-
    retract(stack(List)),
    append(List,[X],Res),
    asserta(stack(Res)).

pop(X):-
    retract(stack(List)),
	append(_,[X],List),
	delete(X,List,Res),
	asserta(stack(Res)).

%%%Exercise 7
:-op(450,yfx,and).
:-op(500,yfx,or).
%%%
:-op(400,fy,--).
:-op(600,xfx,==>).
:-op(500,yfx,xor).
:-op(500,yfx,nor).
:-op(450,yfx,nand).

Arg1 and Arg2 :- Arg1,Arg2.
Arg1 or _Arg2 :- Arg1.
_Arg1 or Arg2 :- Arg2.
%%%
--Arg :- not(Arg).
Arg1 ==> Arg2 :- --Arg1 or Arg2.
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

