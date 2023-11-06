% [3/h, 4/h, 5/h, 9/d, 10/d, 11/d, 12/d, 4/d, 4/c, 4/s]

% http://kti.ms.mff.cuni.cz/~bartak/prolog/combinatorics.html

comb(0,_,[]).

comb(N,[X|T],[X|Comb]) :- 
    N>0,
    N1 is N-1,
    comb(N1,T,Comb).

comb(N,[_|T],Comb) :-
    N>0,
    comb(N,T,Comb).

sets_of_3(X, S) :-
    comb(3, X, S),
    [A/_,B/_,C/_] = S,
    A = B, B = C.

runs_of_3(X, R) :-
    sort(X,X2),
    comb(3,X2,R),
    [R1/S1,R2/S2,R3/S3] = R,
    S1 = S2, S2 = S3,
    1 is R3 - R2,
    1 is R2 - R1.