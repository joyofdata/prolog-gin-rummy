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

sort_suits(Hand,Hand2) :-
    sort(Hand.d,D2),
    sort(Hand.h,H2),
    sort(Hand.s,S2),
    sort(Hand.c,C2),
    Hand2 = hand{d:D2,h:H2,s:S2,c:C2}.

% https://stackoverflow.com/a/49503900/562440
% sets_of_4_2(hand{c:[4/c], d:[4/d, q/d, j/d, t/d, 9/d], h:[5/h, 4/h, 3/h], s:[4/s]}, Sets).
% Sets = [[4/d, 4/h, 4/s, 4/c]].

sets_of_4_2(Hand,Sets) :-
    findall(
        [R1/S1,R2/S2,R3/S3,R4/S4],
        (
            member(R1/S1,Hand.d),
            member(R2/S2,Hand.h),
            member(R3/S3,Hand.s),
            member(R4/S4,Hand.c),
            R1=R2,R2=R3,R3=R4
        ),Sets).

sets_of_3_2_(Hand,Sa,Sb,Sc,Sets) :-
    findall(
        [R1/S1,R2/S2,R3/S3],
        (
            member(R1/S1,Hand.Sa),
            member(R2/S2,Hand.Sb),
            member(R3/S3,Hand.Sc),
            R1=R2,R2=R3
        ),Sets).

% sets_of_3_2(hand{c:[4/c,5/c], d:[4/d, q/d, j/d, t/d, 9/d], h:[5/h, 4/h, 3/h], s:[5/s,4/s]},Sets).
% Sets = [[4/d, 4/h, 4/s]] ;
% Sets = [[4/d, 4/h, 4/c]] ;
% Sets = [[4/d, 4/s, 4/c]] ;
% Sets = [[5/h, 5/s, 5/c], [4/h, 4/s, 4/c]] ;

sets_of_3_2(Hand,Sets) :-
    comb(3,[d,h,s,c],X),
    [Sa,Sb,Sc] = X,
    sets_of_3_2_(Hand,Sa,Sb,Sc,Set).