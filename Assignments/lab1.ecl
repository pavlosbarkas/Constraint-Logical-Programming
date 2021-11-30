/*
    Ονοματεπώνυμο: Παύλος Μπάρκας 
    Αριθμός Μητρώου: dai18022
*/
add_r1.
add_r2.
add_r3.

subtract_r1.
subtract_r2.
subtract_r3.

store_r1.
store_r2.
store_r3.

load_r1.
load_r2.
load_r3.

command(add_r1, state(acc(X), reg1(Y), R2, R3), state(acc(X+Y), reg1(Y), R2, R3)).
command(add_r2, state(acc(X), R1, reg2(Y), R3), state(acc(X+Y), R1, reg2(Y), R3)).
command(add_r3, state(acc(X), R1, R2, reg3(Y)), state(acc(X+Y), R1, R2, reg3(Y))).

command(subtract_r1, state(acc(X), reg1(Y), R2, R3), state(acc(X-Y), reg1(Y), R2, R3)).
command(subtract_r2, state(acc(X), R1, reg2(Y), R3), state(acc(X-Y), R1, reg2(Y), R3)).
command(subtract_r3, state(acc(X), R1, R2, reg3(Y)), state(acc(X-Y), R1, R2, reg3(Y))).

command(store_r1, state(acc(X), reg1(_), R2, R3), state(acc(X), reg1(X), R2, R3)).
command(store_r2, state(acc(X), R1, reg2(_), R3), state(acc(X), R1, reg2(X), R3)).
command(store_r3, state(acc(X), R1, R2, reg3(_)), state(acc(X), R1, R2, reg3(X))).

command(load_r1, state(acc(_), reg1(X), R2, R3), state(acc(X), reg1(X), R2, R3)).
command(load_r2, state(acc(_), R1, reg2(X), R3), state(acc(X), R1, reg2(X), R3)).
command(load_r3, state(acc(_), R1, R2, reg3(X)), state(acc(X), R1, R2, reg3(X))).

%%%findOps/3
findOps(O1, O2, O3) :- 
    command(O1, state(acc(c1), reg1(0), reg2(c2), reg3(c3)), State1),
	command(O2, State1, State2),
	command(O3, State2, state(_, reg1((c1-c2)+c3), _, _)).