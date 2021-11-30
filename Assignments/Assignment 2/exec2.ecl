%%%% Coursework 2 2021
:-lib(ic).
:-lib(ic_edge_finder).
:-lib(branch_and_bound). 

%%% Exec 1
ram([2,8,8,16,2,4]).
price([30,35,20,38,44,65]).
vcpu([4,8,8,4,4,8]).

select_providers(X, Y, Price):-
    % Δημιουργία λιστών με τις επιλογές κάθε provider για Ram, Cpu και τιμή.
    ram(RamOptions),
    vcpu(CpuOptions),
    price(PriceOptions),
    length(PriceOptions, N),
    % Το πλήθος Ν των Providers είναι όσο το μήκος μιας εκ των λιστών, οπότε οι μεταβλητές
    % X και Υ που εκφράζουν κάποιον Provider θα πάρουν τιμή από 1 έως Ν.
    X #:: [1..N],
    Y #:: [1..N],
    element(X, RamOptions, Ram1),
    Ram1 #> 4,  % Έλεγχος ώστε κάθε VM να έχει τουλάχιστον 4GB Ram.
    element(Y, RamOptions, Ram2),
    Ram2 #> 4,
    element(X, CpuOptions, Cpu1),
    element(Y, CpuOptions, Cpu2),
    Cpu1 + Cpu2 #= 12, % Έλεγχος ώστε οι δύο VM να έχουν σύνολο 12 Vcpus.
    element(X, PriceOptions, Price1),
    element(Y, PriceOptions, Price2),
    ic_global:alldifferent([X, Y]),
    Price #= Price1 + Price2,
    bb_min(labeling([X, Y]), Price, _).

%%% Exec2
class(clp,3,40,3).
class(procedural,3,60,2).
class(analysis,4,50,2).
class(computer_sys,4,40,3).
class(algebra,3,40,4).

lectures(Classes, Starts, Makespan):-
    % Δημιουργία λιστών με τα μαθήματα, τις ώρες διδασκαλίας, 
    % τις άδειες zoom που απαιτεί κάθε μάθημα και τους καθηγητές
    % που απαιτεί κάθε μάθημα.
    findall(C, class(C,_,_,_), Classes),
    findall(H, class(_,H,_,_), Hours),
    findall(L, class(_,_,L,_), Licenses),
    findall(T, class(_,_,_,T), Teachers),
    length(Classes, N),
    length(Starts, N),
    % Πεδίο τιμών των Starts.
    Starts #:: [9..21],
    apply_cons2(Starts, Hours, Ends),
    ic_global:maxlist(Ends,Makespan),
    % Διαμοιρασμός των διαθέσιμων πόρων που είναι οι 6 καθηγητές
    % και οι 100 άδειες zoom.
    cumulative(Starts, Hours, Teachers, 6),
    cumulative(Starts, Hours, Licenses, 100),
    bb_min(labeling(Starts), Makespan, bb_options{strategy:restart}).
    
apply_cons2([], [], []).
apply_cons2([S|Starts], [H|Hours], [E|Ends]):-
    E #= S + H,
    E #=< 21, % επειδή τα μαθήματα ολοκληρώνονται στις 21:00
    apply_cons2(Starts, Hours, Ends).

%%% Exec 3
product(a,40).
product(b,56).
product(c,48).
product(d,64).

company(st(S), dur(D), machines(Machines), M):-
    % Δημιουργία λίστας με τις ποσότητες που πρέπει 
    % να παραχθούν από κάθε προϊόν.
    findall(Q, product(_,Q), Quantities),
    % Δημιουργία κενών λιστών για τον χρόνο εκκίνησης
    % κάθε προϊόντος, τις μηχανές που χρειάζονται και
    % και τις μονάδες ποιοτικού ελέγχου που απαιτούν.
    length(Quantities, N),
    length(S, N),
    length(Machines,N),
    length(QualityControl, N),
    ic_global:sumlist(Quantities, Sum),
    S #:: [0..Sum],
    Machines #:: [2..8],
    % Κάθε προϊόν απαιτεί μία μονάδα από τον πόρο ποιοτικού ελέγχου,
    % ώστε στη συνέχεια να ικανοποιείται ο περιορισμός ότι
    % ο ποιοτικός έλεγχος μπορεί να ελέγχει μέχρι 2 προϊόντα ταυτόχρονα.
    QualityControl #:: [1],
    apply_cons3(Quantities, S, D, Machines, Ends),
    % Διαμοιρασμός των διαθέσιμων μηχανών.
    cumulative(S, Ends, Machines, 8),
    % Διαμοιρασμός των πόρων ποιοτικού ελέγχου.
    cumulative(S, Ends, QualityControl, 2),
    ic_global:maxlist(Ends, Makespan),
    bb_min(labeling([S,Machines]), Makespan, bb_options{strategy:restart}),
    M #= Makespan - 15.

apply_cons3([],[],[],[],[]).
apply_cons3([Q|Qs],[S|Ss],[D|Ds],[M|Ms],[E|Es]):-
    % Η διάρκεια εκτύπωσης κάθε προϊόντος ισούται με την ποσότητα
    % που πρέπει να παραχθεί προς τις μηχανές που το παράγουν,
    % αφού η εκτύπωση διαρκεί ένα λεπτό ανά προϊόν.
    D #= Q / M,
    % Στο τέλος κάθε εκτύπωσης προστίθενται 15 λεπτά που
    % είναι η παραμετροποίηση για το επόμενο προϊόν.
    E #= S + D + 15,
    apply_cons3(Qs, Ss, Ds, Ms, Es).