%%%ExecSet_1

%%% Exercise 1

%%% and/3
%%% Definition of the and operation
and(0,1,0).
and(0,0,0).
and(1,0,0).
and(1,1,1).

or(0,0,0).
or(0,1,1).
or(1,0,1).
or(1,1,1).

%%% not/2
%%% definition of the not operation
not(1,0).
not(0,1).

%%% nand/3
nand(X,Y,Output):-
	and(X,Y,ANDResult),
	not(ANDResult,Output).

%%% xor_gate/3
xor_gate(0,0,0).
xor_gate(0,1,1).
xor_gate(1,0,1).
xor_gate(1,1,0).

%%% half_adder/4
half_adder(X, Y, S, C):-
    and(X,Y,C),
    xor_gate(X,Y,S).

%%% full_adder/4
full_adder(C, X, Y, S, Ca):-
    half_adder(X, Y, Res, Carry1),
    half_adder(C, Res, S, Carry2),
    or(Carry1, Carry2, Ca).

%%% bit3_adder/
bit3_adder(X0, X1, X2, Y0, Y1, Y2, C0, S0, S1, S2, C3):-
    full_adder(C0,X0,Y0,S0,C1),
    full_adder(C1,X1,Y1,S1,C2),
    full_adder(C2,X2,Y2,S2,C3).

%%% Exercise 2

%% Company Data 
employee(name(john),position(programmer),wage(40000)).
employee(name(alice),position(programmer),wage(35000)).
employee(name(peter),position(uxdesigner),wage(25000)).
employee(name(nick),position(accountant),wage(60000)).
employee(name(helen),position(project_leader),wage(140000)).
employee(name(bob),position(programmer),wage(15000)).
employee(name(mathiew),position(project_namager),wage(50000)).
employee(name(donald),position(public_relations),wage(100000)).
employee(name(igor),position(server_admin),wage(20000)).

data(john,status(married,children(2))).
data(alice,status(single,children(0))).
data(peter,status(married,children(1))).
data(nick,status(married,children(3))).
data(helen,status(single,children(2))).
data(bob,status(single,children(0))).
data(mathiew,status(married,children(1))).
data(donald,status(single,children(1))).
data(igor,status(married,children(1))).

%%% wage/2
wage(Empl,Wage):-
    employee(name(Empl), _, wage(Wage)).

%%% single_with_children/2
single_with_children(Empl, N):-
    data(Empl, status(single, children(N))),
    N > 0.

%%% benefit/3
benefit(Name, Wage, Benefit):-
    employee(name(Name), _, wage(Wage)),
    data(Name, status(single, children(0))),
    Benefit is 0.

benefit(Name, Wage, Benefit):-
    employee(name(Name), _, wage(Wage)),
    data(Name, status(single, children(N))),
    N > 0,
    Benefit is 1500.

benefit(Name, Wage, Benefit):-
    employee(name(Name), _, wage(Wage)),
    data(Name, status(married, children(0))),
    Benefit is 500.

benefit(Name, Wage, Benefit):-
    employee(name(Name), _, wage(Wage)),
    data(Name, status(married, children(N))),
    N > 0,
    Benefit is 1100.

%%% Exercise 3

job(smith).
job(baker).
job(carpenter).
job(tailor).

%%% professions/8
professions(Smith, Baker, Carpenter, Tailor, SmithSon, BakerSon, CarpenterSon, TailorSon):-
    job(Smith), job(SmithSon),
    Smith \= smith, SmithSon \= smith, Smith \= SmithSon,
    job(Baker), job(BakerSon), Baker \= BakerSon,
    Baker \= baker, BakerSon \= baker,
    job(Carpenter), job(CarpenterSon), Carpenter \= CarpenterSon,
    Carpenter \= carpenter, CarpenterSon\=carpenter,
    job(Tailor), job(TailorSon), Tailor \= TailorSon,
    Tailor \= tailor, TailorSon \= tailor,
    Baker = CarpenterSon,
    SmithSon = baker.

%%% Exercise 4
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

%%% Exercise 5
