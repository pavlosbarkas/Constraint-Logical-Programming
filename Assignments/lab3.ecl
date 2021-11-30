/*
    Ονοματεπώνυμο: Παύλος Μπάρκας 
    Αριθμός Μητρώου: dai18022
*/

%%% replace/4
replace(X,R,[X|Tail],[R|Tail]).

replace(X,Y,[Head|Tail],[Head|Tail2]):-
    replace(X,Y,Tail,Tail2).