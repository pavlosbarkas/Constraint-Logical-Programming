/*
    Ονοματεπώνυμο: Παύλος Μπάρκας 
    Αριθμός Μητρώου: dai18022
*/

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