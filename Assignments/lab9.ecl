/*
    Ονοματεπώνυμο: Παύλος Μπάρκας 
    Αριθμός Μητρώου: dai18022
*/
:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).

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