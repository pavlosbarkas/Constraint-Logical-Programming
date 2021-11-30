%ExecSet_3

%Exercise_1
%%% sumoflist/2
sumoflist([],0).

sumoflist([Head|Tail],Sum):-
    sumoflist(Tail, S),
    Sum is Head + S.

%Exercise_2
%%% before_last_element/2
before_last_element([X,_], X).
    
before_last_element([_|Tail], BLE):-
    before_last_element(Tail, BLE).

%Exercise_3
%%% occurs/3
occurs(_,[],0).

occurs(X,[X|Tail],OCC):-
    occurs(X,Tail,NOCC),
    OCC is NOCC + 1.

occurs(X,[Head|Tail],OCC):-
    X \= Head,
    occurs(X,Tail,OCC).

%Exercise_4
%%%count_odd/2
count_odd([],0).

count_odd([Head|Tail],X):-
    1 is Head mod 2,
    count_odd(Tail,NX),
    X is NX + 1.

count_odd([Head|Tail],X):-
    0 is Head mod 2,
    count_odd(Tail,X).

%Exercise_5
%%%count_vowels/2
isVowel(a).
isVowel(e).
isVowel(i).
isVowel(o).
isVowel(u).
isVowel(y).

count_vowels([],0).

count_vowels([Head|Tail],X):-
    isVowel(Head),
    count_vowels(Tail,NX),
    X is NX + 1.

count_vowels([Head|Tail],X):-
    not(isVowel(Head)),
    count_vowels(Tail,X).

%Exercise_6
%%%sum_even/2
sum_even([],0).

sum_even([Head|Tail],Sum):-
    0 is Head mod 2,
    sum_even(Tail, Nsum),
    Sum is Nsum + Head.

sum_even([Head|Tail],Sum):-
    1 is Head mod 2,
    sum_even(Tail,Sum).

%%% Exercise 7
%%% replace/4

replace(X,R,[X|Tail],[R|Tail]).

replace(X,Y,[Head|Tail],[Head|Tail2]):-
    replace(X,Y,Tail,Tail2).