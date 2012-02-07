% maxlist(L, X) is true, if X is a biggest element in the list

maximum(X, Y, X) :- X >= Y.
maximum(X, Y, Y) :- X < Y.

maxlist([H|T], X) :- maxlist(T, H, X).
maxlist([H|T], M, X) :- maximum(H, M, Z), maxlist(T, Z, X).
maxlist([], X, X).

% Tests
:- begin_tests(maxlist).
test(test01, [fail]) :- maxlist([], _).
test(test02) :- maxlist([1], 1).
test(test03) :- maxlist([1, 2, 3], 3).
test(test04, [true(Max =:= 5)]) :- maxlist([1, 2, 5, 3], Max).
:- end_tests(maxlist).
