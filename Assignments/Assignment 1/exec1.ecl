%%% Code for coursework 1 - 2021
%% Exec 1 Lists
%% Add your code here

%%%extend/2
extend([], []).
extend([(0,_)|Tail], NewList):-
    extend(Tail, NewList).
extend([(1,N)|Tail], [[N]|NewList]):-
    extend(Tail, NewList).
extend([(2,N)|Tail], [[N,N]|NewList]):-
    extend(Tail, NewList).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Exec2 Flights 
%%% flight/5
% flight(Code,fromto(Dep,Dest),etd(Time),eta(Time),cost(Cost)).

flight(oa123,fromto(skg,ath),etd(10),eta(11),cost(120)).
flight(oa124,fromto(skg,ath),etd(12),eta(13),cost(80)).
flight(oa125,fromto(skg,ath),etd(13),eta(14),cost(40)).
flight(oa126,fromto(ath,skg),etd(15),eta(16),cost(45)).
flight(oa127,fromto(ath,skg),etd(17),eta(18),cost(45)).
flight(oa120,fromto(skg,lgw),etd(13),eta(14),cost(140)).
flight(aa101,fromto(ath,lgw),etd(15),eta(18),cost(340)).
flight(aa120,fromto(ath,lhr),etd(16),eta(20),cost(120)).
flight(bt190,fromto(ath,lhr),etd(17),eta(21),cost(90)).
flight(bt100,fromto(lgw,ath),etd(18),eta(19),cost(30)).
flight(bt101,fromto(lgw,edi),etd(12),eta(13),cost(30)).
flight(bt110,fromto(lhr,edi),etd(22),eta(23),cost(30)).
flight(lf200,fromto(ath,fra),etd(15),eta(18),cost(550)).
flight(lf201,fromto(fra,ath),etd(20),eta(23),cost(550)).
flight(lf210,fromto(fra,edi),etd(20),eta(22),cost(200)).
flight(lf211,fromto(edi,fra),etd(16),eta(19),cost(190)).

%% Add your code here

%%% 2a
%%% find_flight/5
find_flight(Dept, Dest, Plan, Cost, ETA):-
    find_flight(Dept, Dest, [Dept], Plan, Cost, ETA, 0).

find_flight(Dept, Dest, _, [CurrCode], Cost, ETA, PreviousFlightETA):-
    flight(CurrCode, fromto(Dept,Dest), etd(ETD), eta(ETA), cost(Cost)),
    PreviousFlightETA + 1 =< ETD.

find_flight(Dept, Dest, Visited, [CurrCode|Plan], Cost, ETA, PreviousFlightETA):-
    flight(CurrCode, fromto(Dept,MiddleDest), etd(ETD), eta(CurrETA), cost(CurrCost)), 
    MiddleDest \= Dest,
    not(member(MiddleDest, Visited)),
    PreviousFlightETA + 1 =< ETD,
    find_flight(MiddleDest, Dest, [MiddleDest|Visited], Plan, NextCost, ETA, CurrETA),
    Cost is NextCost + CurrCost.

%%% 2b
%%% waiting_time/2
waiting_time([_], 0):-
    !.

waiting_time([Flight, NextFlight|RestFlights], WTime):-
    flight(Flight, _, _, eta(FlightETA), _),
    flight(NextFlight, _, etd(NextFlightETD), _, _),
    FlightETA + 1 =< NextFlightETD,
    CurrWTime is NextFlightETD - FlightETA,
    waiting_time([NextFlight|RestFlights], NWTime),
    WTime is CurrWTime + NWTime.

%%% 2c
%%% select_flight/5
select_flight(Dep, Dest, Plan, Before, Cost, MinWait):-
    setof([MinWait, Cost, Plan], 
        (find_flight(Dep, Dest, Plan, Cost, ETA), 
        ETA =< Before, waiting_time(Plan, MinWait)),
        [[MinWait, Cost, Plan]|_]),
    !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ΕΧEC 3
%%% reduction/2
%% Add your code here
reduction([R], R).

reduction(List, R):-
    append(First, [X, Y, Op|Rest], List),
    number(X), number(Y), member(Op, [+, -, *, //, min, max]),
    !,
    T =..[Op,X,Y],
    Res is T,
    append(First, [Res|Rest], Reduced),
    !,
    reduction(Reduced, R).

reduction(List, R):-
    append(First, [X, Op|Rest], List),
    number(X), member(Op, [abs]),
    !,
    T =..[Op,X],
    Res is T,
    append(First, [Res|Rest], Reduced),
    !,
    reduction(Reduced, R).