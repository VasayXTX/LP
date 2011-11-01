% between_val(X, Y, Z) is true, if Z is an integer between X and Y inclusive

between_val(X, Y, Y) :- Y >= X.
between_val(X, Y, Z) :- Y > X, succ(Y1, Y), between_val(X, Y1, Z).

% Tests

:- begin_tests(between_val).
test(test01, [fail]) :- between_val(1, 0, 1).
test(test02) :- between_val(0, 10, 10).
test(test03) :- between_val(0, 10, 0).
test(test04) :- between_val(0, 10, 5).
:- end_tests(between_val).

