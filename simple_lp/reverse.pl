% Reverse of the list

reverse([], []).
reverse([X|Y], L) :- reverse(Y, L1), append(L1, [X], L).

% Tests

:- begin_tests(member).
test(test01) :- reverse([], []).
test(test02) :- reverse([1], [1]).
test(test03) :- reverse([1, 2], [2, 1]).
test(test04) :- reverse([1, 2, 3, 4], [4, 3, 2, 1]).
:- end_tests(member).

