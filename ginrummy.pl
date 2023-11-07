comb_all([],[]).

comb_all([X|T],[X|Comb]) :-
    comb_all(T,Comb).

comb_all([_|T],Comb) :-
    comb_all(T,Comb).

sum_pts([],0).

sum_pts([C|T],S) :-
    sum(T,S_),
    (C =< 10 -> C_ = C ; C_ = 10),
    S is C_ + S_.

comb_n(0,_,[]).

comb_n(N,[X|T],[X|Comb]) :-
    N>0,
    N1 is N-1,
    comb_n(N1,T,Comb).

comb_n(N,[_|T],Comb) :-
    N>0,
    comb_n(N,T,Comb).

sets_of_3(X, S) :-
    comb_n(3, X, S),
    [A/_,B/_,C/_] = S,
    A = B, B = C.

runs_of_3(X, R) :-
    sort(X,X2),
    comb_n(3,X2,R),
    [R1/S1,R2/S2,R3/S3] = R,
    S1 = S2, S2 = S3,
    1 is R3 - R2,
    1 is R2 - R1.

% cards_of_sets(X, C) :-
% findall(C,sets_of_3([1/a,1/b,1/c,2/x,2/d,3/c,3/b,3/a,1/d],C),Cs),comb_all(Cs,S),union(S,U).
