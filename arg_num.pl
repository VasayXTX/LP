% arg_num(Term, N) is true, if N is numbers of all arguments in compound term Term

constant(X) :- integer(X).
constant(X) :- atom(X).

arg_num(T, 0) :- constant(T).
arg_num(T, N) :- compound(T), functor(T, _, C), arg_num(C, T, N1), N is C + N1.
arg_num(0, _, 0).
arg_num(I, T, N) :- I > 0, succ(I1, I), arg_num(I1, T, N1), arg(I, T, A), arg_num(A, N2), N is N1 + N2.


% Tests 
:- begin_tests(arg_num).
test(test01) :- arg_num(x, 0), !.
test(test02) :- arg_num(sin(x), 1), !.
test(test03) :- arg_num(1 + 1, 2), !. 
test(test03) :- arg_num(sin(2 + 2), 3), !.
test(test03, [true(N =:= 3)]) :- arg_num(sin(2 + 2), N), !.
:- end_tests(arg_num).
