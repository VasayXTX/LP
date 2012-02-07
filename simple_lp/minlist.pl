% minlist(L, M) is true, if M is the smallest element in the list L

minlist([X|Xs], M) :- minlist(Xs, X, M).
minlist([X|Xs], Y, M) :- minimum(X, Y, Z), minlist(Xs, Z, M).
minlist([], M, M).

minimum(X, Y, X) :- X =< Y.
minimum(X, Y, Y) :- X > Y.

% Tests

:- begin_tests(minlist).
test(test01, [fail]) :- minlist([], _).
test(test02) :- minlist([0], 0).
test(test03) :- minlist([0, 1], 0).
test(test04) :- minlist([1, 0], 0).
test(test05, [true(Min =:= 3)]) :- minlist([9, 8, 3, 7, 6], Min).
:- end_tests(minlist).

