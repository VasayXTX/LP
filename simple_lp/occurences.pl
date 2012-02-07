% occurences(Sub, Term, N) is true if N is number of occurences subterm Sub in term Term

constant(X) :- integer(X).
constant(X) :- atom(X).

occurences(T, T, 1) :- constant(T).
occurences(ST, T, 0) :- constant(T), ST \= T.
occurences(ST, T, N) :-
  compound(T),
  functor(T, _, C),
  occurences(C, ST, T, N).
occurences(0, _, _, 0).
occurences(I, ST, T, N) :-
  I > 0,
  succ(I1, I),
  arg(I, T, A),
  occurences(ST, A, N1),
  occurences(I1, ST, T, N2),
  N is N1 + N2.

% Tests
:- begin_tests(occurences).
test(test01) :- occurences(x, y, 0).
test(test02) :- occurences(x, y * z, 0).
test(test03) :- occurences(x, sin(y), 0).
test(test04) :- occurences(x, x, 1).
test(test05) :- occurences(x, sin(x), 1).
test(test06) :- occurences(x, x * x, 2).
test(test07, [true(N =:= 2)]) :- occurences(x, sin(x * x), N).
:- end_tests(occurences).

