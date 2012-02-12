% 

flatten(Xs, Ys) :- flatten_dl(Xs, Ys/[]).
flatten_dl([X|Xs], Ys/Zs) :- flatten_dl(X, Ys1/Zs), flatten_dl(Xs, Ys/Ys1).
flatten_dl(X, [X|Xs]/Xs) :- atomic(X), X \= [].
flatten_dl([], Xs/Xs).

:- begin_tests(flatten).
test(test01) :- flatten([], []).
test(test02) :- flatten([a], [a]).
test(test03) :- flatten([[a]], [a]).
test(test03) :- flatten([[a], [b, [c]]], [c, b, a]).
:- end_tests(flatten).

