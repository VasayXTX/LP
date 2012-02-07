% Program to calc sum of all elements in list

% Recursive implementation
sumlist_rec([], 0).
sumlist_rec([X|Xs], S) :- integer(X), sumlist_rec(Xs, S1), S is S1 + X.

% Iteration implementation
sumlist_it(L, S) :- sumlist_it(L, 0, S).
sumlist_it([X|Xs], A, S) :- integer(X), A1 is X + A, sumlist_it(Xs, A1, S).
sumlist_it([], S, S).

% Tests

:- begin_tests(sumlist_rec).
test(test01) :- sumlist_rec([], 0).
test(test02) :- sumlist_rec([1], 1).
test(test03) :- sumlist_rec([1, 2, 3], 6).
:- end_tests(sumlist_rec).

:- begin_tests(sumlist_it).
test(test01) :- sumlist_it([], 0).
test(test02) :- sumlist_it([1], 1).
test(test03) :- sumlist_it([1, 2, 3], 6).
:- end_tests(sumlist_it).

