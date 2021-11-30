/*
    Ονοματεπώνυμο: Παύλος Μπάρκας 
    Αριθμός Μητρώου: dai18022
*/

sumn(1, 1).

%%%sumn/2
sumn(N, X):-
    N>0, NN is N-1,
    sumn(NN, NX),
    X is NX + N.