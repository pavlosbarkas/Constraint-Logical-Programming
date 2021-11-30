%%%ExecSet8
:-lib(ic).
:-lib(ic_global).

%%%Exercise 2
%%% balance_lights/2

weight(10).
weight(20).
weight(30).
weight(50).
weight(60).
weight(90).
weight(100).
weight(150).
weight(250).
weight(500).

balance_lights(Weights, Total):-
    Weights = [W1, W2, W3, W4],
    findall(W, weight(W), List),
    Weights #:: List,
    ic_global:alldifferent(Weights),
    5*W1 #= 5*W2 + 20*W3 + 40*W4,
    labeling(Weights),
    sumlist(Weights, Total).

%%% Exercise 3
%%% num_gen/2

num_gen([N1,5,N2,N3,3], [M1,M2,0,M3,1]):-
    [N1,N2,N3,M1,M2,M3] #:: [0..9],
    ic_global:alldifferent([N1,N2,N3,M1,M2,M3,5,3,0,1]),
    Num1 #= 10000*N1 + 1000*5 + 100*N2 + 10*N3 + 3,
    Num2 #= 10000*M1 + 1000*M2 + 0 + 10*M3 + 1, 
    12848 #= abs(Num1 - Num2),
    labeling([N1,N2,N3,M1,M2,M3]).

%%% Exercise 4
%%% donald/1

donald([D,O,N,A,L,G,E,R,B,T]):-
    [D,O,N,A,L,G,E,R,B,T] #:: [0..9],
    ic_global:alldifferent([D,O,N,A,L,G,E,R,B,T]),
    Donald #= 100000*D + 10000*O + 1000*N + 100*A + 10*L + D,
    Gerald #= 100000*G + 10000*E + 1000*R + 100*A + 10*L + D,
    Robert #= 100000*R + 10000*O + 1000*B + 100*E + 10*R + T,
    Robert #= Donald + Gerald,
    labeling([D,O,N,A,L,G,E,R,B,T]).

%%% Exercise 5
%%% menu/2
item(pizza,12).
item(burger,14).
item(kingburger,18).
item(platSurprise,15).

%%% menu/2
%%% menu(Amount,Order)
menu(N,Final) :-  
    findall(F,item(F,_),Food),
    findall(P,item(_,P),Prices),
    constrain_menu(Food,N,Res,Final),

    %%% Ορισμός πεδίου τιμών του Ν
    ic_global:minlist(Prices, MinPrice),
    N #:: [MinPrice..1.0Inf],
                  
    %%% Xρήση της μικρότερης τιμής για καθορισμό του πλήθους των πιάτων
    Limit is N/MinPrice,
    LimitCeil is ceiling(Limit),
    integer(LimitCeil,LimitInt),
               
    %%% Δημιουργία λίστας αποτελεσμάτων
    length(Food, Len),
    length(Res, Len),
    Res #:: [0..LimitInt],

    labeling(Res).
               
%%% constrain_menu/4
%%% constrain_menu(ListOfMenuItems, Amount, Limit, Order, FinalOrder)
constrain_menu([],0,[],[]).
constrain_menu([F|Food],N,[R|Res],[R - F|Final]) :-   
    item(F,P),
    NN #= N - R*P,
    NN #>= 0,
    constrain_menu(Food,NN,Res,Final).

