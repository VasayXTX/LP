#!/usr/bin/swipl -g run_tests,halt -s
% Calc N-element's of Fibonacci numbers

% Recursive implementation
fib_rec(0, 0).
fib_rec(1, 1).
fib_rec(N, F) :-
  succ(N1, N),
  succ(N2, N1),
  fib_rec(N1, F1),
  fib_rec(N2, F2),
  plus(F1, F2, F).

% Iteration implementation
fib_it(0, 0).
fib_it(N, F) :- fib_it(N, 0, 1, F).
fib_it(I, F1, F2, F) :-
  I > 1,
  succ(I1, I),
  F3 is F1 + F2,
  fib_it(I1, F2, F3, F).
fib_it(1, F1, F2, F2).

% Tests

% Recursive implementation
:- begin_tests(fib_rec).
test(test01) :- fib_rec(0, 0).
test(test02) :- fib_rec(1, 1).
test(test03) :- fib_rec(3, 2).
test(test04, [true(F =:= 8)]) :- fib_rec(6, F).
:- end_tests(fib_rec).

% Iteration implementation
:- begin_tests(fib_it).
test(test05) :- fib_it(0, 0).
test(test06) :- fib_it(1, 1).
test(test07) :- fib_it(3, 2).
test(test08, [true(F =:= 8)]) :- fib_it(6, F).
:- end_tests(fib_it).
