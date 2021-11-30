/*
    Ονοματεπώνυμο: Παύλος Μπάρκας 
    Αριθμός Μητρώου: dai18022
*/

%%%common_suffix/4
common_suffix(L1,L2,Suffix,Pos):-
    append(_,Suffix,L1),
    append(_,Suffix,L2),
    length(Suffix,Pos).