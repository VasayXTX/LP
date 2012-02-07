% Program to calc factorial

% Recursive implementation
factorial_rec(0, 1).
factorial_rec(N, F) :- N > 0, succ(N1, N), factorial_rec(N1, F1), F is F1 * N.

% Iteration implementation
factorial_it(N, F) :- factorial_it(N, 1, F).
factorial_it(N, A, F) :- N > 0, succ(N1, N), A1 is A * N, factorial_it(N1, A1, F).
factorial_it(0, F, F).

% Tests

% Recursive implementation
:- begin_tests(factorial_rec).
test(test01) :- factorial_rec(0, 1), !.
test(test02) :- factorial_rec(1, 1), !.
test(test03) :- factorial_rec(4, 24), !.
test(test04, [true(F =:= 120)]) :- factorial_rec(5, F), !.
:- end_tests(factorial_rec).

% Iteration implementation
:- begin_tests(factorial_it).
test(test05) :- factorial_it(0, 1).
test(test06) :- factorial_it(1, 1).
test(test07) :- factorial_it(4, 24).
test(test08, [true(F =:= 120)]) :- factorial_it(5, F).
:- end_tests(factorial_it).

