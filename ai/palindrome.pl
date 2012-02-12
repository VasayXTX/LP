% Palindrome

palindrome(Xs, Ys) :- palindrome_dl(Xs, Ys/[]).
palindrome_dl([X|Xs], Ys/Zs) :- palindrome_dl(Xs, Ys/[X|Zs]).
palindrome_dl([], Xs/Xs).

:- begin_tests(palindrome).
test(test01) :- palindrome([], []).
test(test02) :- palindrome([a], [a]).
test(test03) :- palindrome([a, b], [b, a]).
test(test04) :- palindrome([a, b, c], [c, b, a]).
:- end_tests(palindrome).

