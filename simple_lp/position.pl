% position(ST, T, P) is true, if P is list of numbers of arguments, specifying the position ST in term T

position(Term, Term, []).
position(S, T, L) :- compound(T), functor(T, _, N), position(N, S, T, L).
position(N, S, T, L) :- N > 1, succ(N1, N), position(N1, S, T, L).
position(N, S, T, [N|Tl]) :- arg(N, T, A), position(S, A, Tl).

% Tests
:- begin_tests(position).
test(test01) :- position(x, sin(x), [1]).
test(test02) :- position(x, 1 * x, [2]).
test(test03) :- position(x, sin(1 + x * y), [1, 2, 1]).
test(test04, [true(P = [2, 1])]) :- position(x, 2 * sin(x), P).
:- end_tests(position).

