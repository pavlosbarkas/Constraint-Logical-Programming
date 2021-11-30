%%%ExecSet5

%%%Exercise 2
%%%set_diff/3
set_diff([],_,[]).
set_diff([H|T],List,[H|Res]):-
    not(member(H,List)),
    !,
    set_diff(T,List,Res).
set_diff([_|T],List,Res):-
    set_diff(T,List,Res).

%%%Exercise 3
%%%lunion/3
lunion([],L,L).
lunion([H1|T1],List2,List3):-
    member(H1,List2),
    !,
    lunion(T1,List2,List3).
lunion([H1|T1],List2,[H1|T3]):-
    lunion(T1,List2,T3).

%%%Exercise 4
%%%max_list/2
max_list(Max,List):-
    member(Max,List),
    not((member(X,List), X>Max)).

%%%Exercise 5
%%%unique_element/2
unique_element(X,List):-
    delete(X,List,DList),
    not(member(X,DList)).

%%%Exercise 6
%%%proper_set/1
proper_set([]).
proper_set(List):-
    member(X,List),
    not(unique_element(X,List)),
    !,
    fail.
proper_set([_|T]):-
    proper_set(T).

%%%Exercise 7
%%%map/3
double(X,Y):-
    Y is 2*X.

square(X,Y):-
    Y is X*X.

map(_,[],[]).

map(Operation,[H|T],[R|Results]):-
    Pred=..[Operation,H,R],
    call(Pred),
    map(Operation,T,Results).

%%%Exercise 8
%%%reduce/3

reduce(_,[X],X).

reduce(Operation,[X,Y|T],Result):-
    Pred=..[Operation,X,Y,R],
    call(Pred),
    reduce(Operation,[R|T],Result).

%%%Exercise 9
%%%valid_queries/1
valid_queries(Query):-
    call(Query),
    write(Query),
    nl.

%%%Exercise 10
%%%separate_lists/3
seperate_lists([],[],[]).
seperate_lists([H|T],Lets,[H|Nums]):- 
    number(H),
    !, 
	seperate_lists(T,Lets,Nums).
seperate_lists([H|T],[H|Lets],Nums):-
    seperate_lists(T,Lets,Nums).

%%%Exercise 11
%%%max_min_eval/2
max_min_eval([L],L).
max_min_eval([X,Op,Y|T],Result) :-  
    member(Op,[min,max]), 
    Pred=..[Op,X,Y,Res], 
	call(Pred), 
	max_min_eval([Res|T],Result).