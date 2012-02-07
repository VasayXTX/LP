% position_univ(ST, T, P) is true, if P is list of numbers of arguments, specifying the position ST in term T

position_univ(Term, Term, []).
position_univ(S, T, L) :- compound(T), T =.. [_|A], position_univ(A, 1, S, L).
position_univ([Ha|_], N, S, [N|Tl]) :- position_univ(S, Ha, Tl).
position_univ([_|Ta], N, S, L) :- succ(N, N1), position_univ(Ta, N1, S, L).

% Tests
:- begin_tests(position_univ).
test(test01, [fail]) :- position_univ(x, sin(1), _).
test(test02) :- position_univ(x, sin(x), [1]).
test(test03) :- position_univ(x, 1 * x, [2]).
test(test04) :- position_univ(x, sin(1 + x * y), [1, 2, 1]).
test(test05, [true(P = [2, 1])]) :- position_univ(x, 2 * sin(x), P).
:- end_tests(position_univ).

