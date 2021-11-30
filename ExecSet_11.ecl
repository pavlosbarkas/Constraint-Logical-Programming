%%%ExecSet11
:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).
:-lib(ic_sets).

%%% Exercise 1
houses([1,3,4,5,6,10,12,14,15,17,20,22]).

fair_father(S1, S2, S3):-
    houses(Houses),
    length(Houses, N),
    intsets([S1, S2, S3], 3, 1, N),

    Array =..[a|Houses],
    weight(S1, Array, SumValue),
    weight(S2, Array, SumValue),
    weight(S3, Array, SumValue),
    all_disjoint([S1, S2, S3]),
    129 #= 3 * SumValue,
    insetdomain(S1,_,_,_),
    insetdomain(S2,_,_,_),
    insetdomain(S3,_,_,_),
    write(SumValue).

%%% Exercise 2
value([10,30,45,50,65,70,75,80,90,100]).
weights([100,110,200,210,240,300,430,450,500,600]).

robbery_planner(N, Groups, TotalCost):-
    value(Values),
    weights(Weights),
    length(Weights, Boxes),
    intsets(Groups, N, 1, Boxes),
    all_disjoint(Groups),

    ValuesArray =..[a|Values],
    WeightsArray =..[b|Weights],
    state_cons(Groups, ValuesArray, WeightsArray, TotalCost),

    sumlist(Values, MaxValue),
    Opt #= MaxValue - TotalCost,
    bb_min(labelSets(Groups), Opt, _).


state_cons([], _, _, 0).
state_cons([G|Groups], ValuesArray, WeightsArray, TotalCost):-
    weight(G, ValuesArray, CurrCost),
    weight(G, WeightsArray, WG),
    WG #< 600, WG #> 0,
    state_cons(Groups, ValuesArray, WeightsArray, NextCost),
    TotalCost #= NextCost + CurrCost.

labelSets([]).
labelSets([G|Groups]):- 
    insetdomain(G,_,_,_), 
    labelSets(Groups).