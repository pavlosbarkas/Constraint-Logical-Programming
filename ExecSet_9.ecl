%%%ExecSet9
:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).

%%% Exercise 1
worker(1,[4,1,3,5,6],[30,8,30,20,10]).
worker(2,[6,3,5,2,4],[140,20,70,10,90]).
worker(3,[8,4,5,7,10],[60,80,10,20,30]).
worker(4,[3,7,8,9,1],[30,40,10,70,10]).
worker(5,[7,1,5,6,4],[40,10,30,20,10]).
worker(6,[8,4,7,9,5],[20,100,130,220,50]).
worker(7,[5,6,7,4,10],[30,30,30,20,10]).
worker(8,[2,6,10,8,3],[50,40,20,10,60]).
worker(9,[1,3,10,9,6],[50,40,10,20,30]).
worker(10,[1,2,7,9,3],[20,20,30,40,50]).

solveEx1(Jobs, Cost):-
    findall(W, worker(W,_,_) ,Workers),
    apply_cons1(Workers, Jobs, Costs),
    ic_global:alldifferent(Jobs),
    sumlist(Costs, Cost),
    bb_min(labeling(Jobs),Cost,_).

apply_cons1([], [], []).
apply_cons1([W|Rest], [J|Jobs], [C|Costs]):-
    worker(W, MyJobs, MyCosts),
    element(I, MyJobs, J),
    element(I, MyCosts, C),
    apply_cons1(Rest, Jobs, Costs).

%%% Exercise 2
%%% num_gen_min/3

num_gen_min([N1,5,N2,N3,3], [M1,M2,0,M3,1], D):-
    [N1,N2,N3,M1,M2,M3] #:: [0..9],
    ic_global:alldifferent([N1,N2,N3,M1,M2,M3,5,3,0,1]),
    Num1 #= 10000*N1 + 1000*5 + 100*N2 + 10*N3 + 3,
    Num2 #= 10000*M1 + 1000*M2 + 0 + 10*M3 + 1,
    D #= abs(Num1 - Num2),
    bb_min(labeling([N1,N2,N3,M1,M2,M3]), D, _).

%%% Exercise 3
student(alex,[4,1,3,5,6]).
student(nick,[6,3,5,2,4]).
student(jack,[8,4,5,7,10]).
student(helen,[3,7,8,9,1]).
student(maria,[7,1,5,6,4]).
student(evita,[8,4,7,9,5]).
student(jacky,[5,6,7,4,10]).
student(peter,[2,6,10,8,3]).
student(john,[1,3,10,9,6]).
student(mary,[1,6,7,9,10]).

solveEx3(Students, Cost):-
    findall(S, student(S,_), Sts),
    apply_cons2(Sts,Prefs,Index, Students),
    sumlist(Index, Cost),
    ic_global:alldifferent(Prefs),
    bb_min(labeling(Prefs), Cost, _).
    
apply_cons2([], [], [], []).
apply_cons2([S|RestS], [P|RestP], [I|RestI], [(S,P)|RestAssng]):-
    student(S,Prefs),
    element(I,Prefs,P),
    apply_cons2(RestS, RestP, RestI, RestAssng).

%%% Exercise 4
%%% load_trucks/4

box(1,140).
box(2,200).
box(3,450).
box(4,700).
box(5,120).
box(6,300).
box(7,250).
box(8,125).
box(9,600).
box(10, 650).

load_trucks(TA, LA, TB, LB):-
    findall(W, box(_,W), Weights),
    length(TA, 3),
    length(TB, 4),
    assign_boxes(TA, Weights, LA),
    LA #=< 1200,
    assign_boxes(TB, Weights, LB),
    LB #< 1350,
    append(TA, TB, AllT),
    ic_global:alldifferent(AllT),
    Cost #= 2550 - (LA + LB),
    bb_min(labeling(AllT), Cost, _).

assign_boxes([], _, 0).
assign_boxes([Box|Boxes], Weights, W):-
    element(Box, Weights, WBox),
    assign_boxes(Boxes, Weights, RestW),
    W #= WBox + RestW.

%%% Exercise 5
provider(a,[0,750,1000,1500],[0,10,13,17]).
provider(b,[0,500,1250,2000],[0,8,12,22]).
provider(c,[0,1000,1750,2000],[0,15,18,25]).
provider(d,[0,1000,1500,1750],[0,13,15,17]).

%%% space/2
space(I, C):-
    findall(P, provider(P,_,_), Ps),
    length(Ps, PsSize),
    providers(1, PsSize, Providers),
    apply_cons(Ps, I, Costs),
    sumlist(I, GB),
    GB #> 3600,
    GB #< 4600,
    sumlist(Costs, C),
    ic_global:alldifferent(Providers),
    bb_min(labeling(I), C, _).

/* Αντιστοίχιση των ονομάτων των παρόχων με αριθμούς ώστε να λειτουργεί
   η alldifferent*/
providers(X, X, [X]):- 
    !.

providers(First, Last, [First|Rest]):-
    First =< Last,
    NewFirst is First + 1,
    providers(NewFirst, Last, Rest).

apply_cons([], [], []).
apply_cons([Provider|RestProviders], [Option|RestOptions], [C|Costs]):-
    provider(Provider, POptions, PCosts),
    element(Index, POptions, Option),
    element(Index, PCosts, C),
    apply_cons(RestProviders, RestOptions, Costs).

%%% Exercise 6
%%% antennas/3

antennas(N,Max,Pos):-   
    length(Pos,N),
    Pos #:: [0..40],
    ic_global:alldifferent(Pos),
    ic_global:ordered(<,Pos),
    check_dif(Pos,Dif),
    flatten(Dif,NDif),
    ic_global:alldifferent(NDif),
    ic_global:maxlist(Pos,Max),
    bb_min(labeling(Pos),Max,_).

check_dif([],[]).
check_dif([H|T],[D|Dif]):- 
    check(H,T,D),
    check_dif(T,Dif).
    
check(_,[],[]).
check(X,[H|T],[D|Dif]):- 
    D #= abs(X - H),
    check(X,T,Dif).

