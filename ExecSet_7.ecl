%%%ExecSet7

%%%Exercise 1
%%% (a)
%%%transitions/3
transition(s1, 10, s2).
transition(s1, 20, s3).
transition(s1, 50, s6).

transition(s2, 10, s3).
transition(s2, 20, s4).

transition(s3, 10, s4).
transition(s3, 20, s5).

transition(s4, 10, s5).
transition(s4, 20, s6).

transition(s5, 10, s6).

%%% (b)
%%%coins_to_insert/3
coins_to_insert(S, [], S).

coins_to_insert(SInitial, [CurrCoin|Coins], SFinal):-
    transition(SInitial, CurrCoin, STemp),
    coins_to_insert(STemp, Coins, SFinal).

%%% (c) 
%%% Καλούμε findall(L, coins_to_insert(s1, L, s6), List)
%%% Με length(List, N) παίρνουμε το πλήθος των διαφορετικών τρόπων

%%%Exercise 2
%%% (a)
%%%connection/3
connect(i1, i2, b1).
connect(rb1, i1, b2).
connect(rb1, i1, b3).
connect(rb1, i2, b4).
connect(i1, rb2, b5).
connect(i1, rb2, b6).
connect(i2, rb2, b7).

connection(Loc1, Loc2, Bridge):-
    connect(Loc1, Loc2, Bridge).

connection(Loc1, Loc2, Bridge):-
    connect(Loc2, Loc1, Bridge).

%%% (b)
%%%walk/3
walk(Dep, Target, Bridges):-
    walk(Dep, Target, [], Bridges).

walk(Dep, Target, Visited, [Bridge]):-
    connection(Dep, Target, Bridge),
    not(member(Bridge, Visited)).

walk(Dep, Target, Visited, [Bridge|RestBridges]):-
    connection(Dep, Temp, Bridge),
    not(member(Bridge, Visited)),
    walk(Temp, Target, [Bridge|Visited], RestBridges).

%%% (c)
%%%euler/0
%%% Καλούμε not((walk(X,Y,L), length(L,7)))