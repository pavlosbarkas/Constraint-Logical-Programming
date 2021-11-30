%%%ExecSet4

%%% sublist/2
sublist(L1,L2):-
    append(S1,_,L2),
    append(_,L1,S1).

%%% Exercise 1a
%%% symmetric/1
symmetric(List):-
    append(X, X, List).

%%% Exercise 1b
%%% end_sublist/2
end_sublist(End, List):-
    append(_, End, List).

%%% Exercise 1c
%%% twice_sublist/2
twice_sublist(Sub, List):-
    append(L1, L2, List),
    sublist(Sub, L1),
    sublist(Sub, L2).

%%% Exercise 1d
%%% last_element/2
last_element(List, X):-
    append(_, [X], List).

%%% Exercise 2
%%% missing_letter/3
word([p,r,o,l,o,g]).
word([m,a,t,h,s]).
missing_letter(GivenWord, Missing, Word):-
    word(Word),
    delete(Missing, Word, GivenWord).

%%% Exercise 3
%%% reverse_alt/2
reverse_alt(List1, List2):-
    append(_,[X],List1),
    append([X],_,List2).

%%% Exercise 4
%%% rotate_left/3
rotate_left(Pos, List, RotatedList):-
    append(L1, L2, List),
    length(L1, Pos),
    append(L2, L1, RotatedList).

%%% Exercise 5

atom(hydrogen,[h1,h2,h3,h4,h5,h6,h7]).
atom(carbon,[c1,c2,c3,c4,c5,c6,c7]).
atom(chlorine,[cl]).

%%%atom_bonds_to/2
atom_bonds_to(h1,[c1]).
atom_bonds_to(h2,[c3]).
atom_bonds_to(h3,[c3]).
atom_bonds_to(h4,[c5]).
atom_bonds_to(h5,[c3]).
atom_bonds_to(h6,[c6]).
atom_bonds_to(h7,[c7]).
atom_bonds_to(c1,[c2,c4,h1]).
atom_bonds_to(c2,[c1,c5,ch]).
atom_bonds_to(c3,[c4,h2,h3,h5]).
atom_bonds_to(c4,[c1,c3,c6]).
atom_bonds_to(c5,[c2,c7,h4]).
atom_bonds_to(c6,[c4,c7,h6]).
atom_bonds_to(c7,[c5,c6,h7]).
atom_bonds_to(cl,[c2]).

%%%carbon/1
carbon(C):-
    atom(carbon,List),
    member(C,List).

%%%hydrogen/1
hydrogen(H):-
    atom(hydrogen,List),
    member(H,List).

%%%bonded/2
bonded(X,Y):-
    atom_bonds_to(X,List),
    member(Y,List).

%%%methyl/1
methyl(M):-
    carbon(M),
    bonded(M, H1),
    hydrogen(H1),
    bonded(M, H2),
    hydrogen(H2),
    bonded(M, H3),
    hydrogen(H3),
    H1 \= H2, H1 \= H3, H2 \= H3.

%%% Exercise 6
%%%common_suffix/4

common_suffix(L1,L2,Suffix,Pos):-
    append(_,Suffix,L1),
    append(_,Suffix,L2),
    length(Suffix,Pos).