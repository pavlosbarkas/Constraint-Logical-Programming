%%%ExecSet10
:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).

%%% Exercise 1
%%% museum/1
team(alpha, 60, 2).
team(beta, 30, 1).
team(gamma, 50, 2).
team(delta, 40, 5).

museum(Starts):-
    findall(T, team(T,_,_), Teams),
    findall(V, team(_,V,_), Visitors),
    findall(H, team(_,_,H), Hours),
    length(Teams, N),
    length(Starts, N),
    Starts #:: 0..inf,
    state_visiting_hours(Starts, Hours, Ends),
    ic_global:maxlist(Ends, MakeSpan),
    cumulative(Starts, Hours, Visitors, 100),
    bb_min(labeling(Starts), MakeSpan, bb_options{strategy:restart}).

state_visiting_hours([], [], []).
state_visiting_hours([S|Starts], [H|Hours], [E|Ends]):-
    E #= S + H,
    state_visiting_hours(Starts, Hours, Ends).

%%% Exercise 2
%%% schedule_reads/1
reading(course1,3,12).
reading(course2,5,20).
reading(course3,2,8).
reading(course4,7,22).

schedule_reads(Starts):-
    findall(C, reading(C,_,_), Courses),
    findall(D, reading(_,D,_), Durations),
    findall(E, reading(_,_,E), ExamDates),
    length(Courses, N),
    length(Starts, N),
    Starts #:: [1..31],
    state_constraints(Starts, Durations, Ends, ExamDates),
    ic_global:maxlist(Ends, MakeSpan),
    disjunctive(Starts, Durations),
    bb_min(labeling(Starts), MakeSpan, bb_options{strategy:restart}).

state_constraints([], [], [], []).
state_constraints([S|Starts], [D|Durations], [E|Ends], [ED|ExamDates]):-
    E #= S + D,
    E #< ED,
    state_constraints(Starts, Durations, Ends, ExamDates).

%%% Exercise 3
%%% solveEx3/2

solveEx3(Starts, Cost):- 
    Starts = [SA1, SA2, SA3, SB1, SB2, SB3, SC1, SC2, SC3],
    Starts #:: [0..500],
    EndA1 #= SA1 + 5,
    SA1 #>= 5,
    EndA2 #= SA2 + 20,
    EndA3 #= SA3 + 15,
    SA3 #>= 10,
    EndB1 #= SB1 + 5,
	EndB2 #= SB2 + 10,
	SB2 #>= 10,
    EndB3 #= SB3 + 5,
    SB3 #>= 5,
    EndC1 #= SC1 + 10,
    EndC2 #= SC2 + 15,
    SC2 #>= 10,
    EndC3 #= SC3 + 10,
    SC3 #>= 20,
    EndA1 #=< SA2,
    EndA2 #=< SA3,
    EndB1 #=< SB2,
    EndB2 #=< SB3,
    EndC1 #=< SC2,
    EndC2 #=< SC3,
    disjunctive([SA1, SB1, SC1], [5, 5, 10]),
    disjunctive([SA2, SB2, SC2], [20, 10, 15]),
    disjunctive([SA3, SB3, SC3], [15, 5, 10]),

    Cost #= (EndA1 - 20) + (EndA2 - 40) + (EndA3 - 35) + (EndB1 - 30) + (EndB2 - 25) + (EndB3 - 30) + 
            (EndC1 - 15) + (EndC2 - 35) + (EndC3- 35),
            
    bb_min(labeling(Starts), Cost, _).