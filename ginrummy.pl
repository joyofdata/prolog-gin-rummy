r(a,2).
r(2,3).
r(3,4).
r(4,5).
r(5,6).
r(6,7).
r(7,8).
r(8,9).
r(9,t).
r(t,j).
r(j,q).
r(q,k).

% [3/h, 4/h, 5/h, 9/d, t/d, j/d, q/d, 4/d, 4/c, 4/s]

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

sets_of_4(X, S) :-
    comb(4, X, S),
    [A/_,B/_,C/_,D/_] = S,
    A = B, B = C, C = D.

% [9/s,t/s,j/s,q/s]

is_run([_]).

is_run([R1/S1,R2/S2|T]) :- 
    r(R1,R2), 
    S1 = S2, 
    is_run([R2/S2|T]).


% [3/h, 4/h, 5/h, 9/d, t/d, j/d, q/d, 4/d, 4/c, 4/s]

bin_suits([],Di,He,Sp,Cl,Di,He,Sp,Cl).
bin_suits([R/S|T],Di,He,Sp,Cl, Di_,He_,Sp_,Cl_) :- S = d, bin_suits(T,Di,He,Sp,Cl,[R/S|Di_],He_,Sp_,Cl_).
bin_suits([R/S|T],Di,He,Sp,Cl, Di_,He_,Sp_,Cl_) :- S = h, bin_suits(T,Di,He,Sp,Cl,Di_,[R/S|He_],Sp_,Cl_).
bin_suits([R/S|T],Di,He,Sp,Cl, Di_,He_,Sp_,Cl_) :- S = s, bin_suits(T,Di,He,Sp,Cl,Di_,He_,[R/S|Sp_],Cl_).
bin_suits([R/S|T],Di,He,Sp,Cl, Di_,He_,Sp_,Cl_) :- S = c, bin_suits(T,Di,He,Sp,Cl,Di_,He_,Sp_,[R/S|Cl_]).

% ?- bin_suits_2([3/h, 4/h, 5/h, 9/d, t/d, j/d, q/d, 4/d, 4/c, 4/s], H, hand{d:[],h:[],s:[],c:[]}).
% H = hand{c:[4/c], d:[4/d, q/d, j/d, t/d, 9/d], h:[5/h, 4/h, 3/h], s:[4/s]}.

bin_suits_2([],H,H).
bin_suits_2([R/S|T],H,H_) :- bin_suits_2(T,H,H_.put(S,[R/S|H_.get(S)])).