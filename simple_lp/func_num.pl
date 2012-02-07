% func_num(Term, N) is true, if N is number of functors in the term Term

constant(X) :- integer(X).
constant(X) :- atom(X).

func_num(Term, 0) :- constant(Term).
func_num(Term, N) :- compound(Term), Term =.. [_|Arg], func_num_l(Arg, N1), succ(N1, N).
func_num_l([], 0).
func_num_l([H|T], N) :- func_num(H, N1), func_num_l(T, N2), N is N1 + N2.

:- begin_tests(func_num).
test(test01) :- func_num(x, 0).
test(test02) :- func_num(1, 0).
test(test03) :- func_num(sin(x), 1).
test(test04) :- func_num(x * y, 1).
test(test05) :- func_num(sin(x * y), 2).
test(test06, [true(N =:= 3)]) :- func_num(sin(x * y + z), N).
:- end_tests(func_num).

