% N-queen problem

queen_doesnt_hit(_, _, []) :- !.
queen_doesnt_hit(Col, Row_dist, [A_queen_col|Other_queens]) :- !,
  Diag_hit_col1 is Col + Row_dist, A_queen_col =\= Diag_hit_col1,
  Diag_hit_col2 is Col - Row_dist, A_queen_col =\= Diag_hit_col2,
  Row_dist1 is Row_dist + 1,
  queen_doesnt_hit(Col, Row_dist1, Other_queens).

safe_position([_]) :- !.
safe_position([A_queen|Other_queens]) :- !,
	queen_doesnt_hit(A_queen, 1, Other_queens),
	safe_position(Other_queens).

do_insert(X, Y, [X|Y]).
do_insert(X, [Y1|Y2], [Y1|Z]) :- do_insert(X, Y2, Z).

permute([X], [X]).
permute([X|Y], Z) :- permute(Y, Z1), do_insert(X, Z1, Z).

safe_layout(Layout, Layout1) :-
	permute(Layout, Layout1), safe_position(Layout1).

gen_list(N, L) :- gen_list(1, N, L).
gen_list(I, N, L) :-
  I < N, I1 is I + 1, gen_list(I1, N, L1), append([I], L1, L).
gen_list(N, N, [N]).

queens(N, Layout) :-
  gen_list(N, Layout1),
  safe_layout(Layout1, Layout).

count_solutions(1, 1).
count_solutions(N, Count) :-
  setof(Layout, queens(N, Layout), L),
  length(L, Count).

% Tests for predicate 'safe_position'
:- begin_tests(safe_position).
test(test01, fail) :- safe_position([1, 2]).
test(test02) :- safe_position([1, 3, 5]).
test(test03) :- safe_position([2, 4, 1, 3]).
:- end_tests(safe_position).

% Tests for predicate 'gen_list'
:- begin_tests(gen_list).
test(test01) :- gen_list(1, [1]).
test(test02) :- gen_list(2, [1, 2]).
test(test03) :- gen_list(4, [1, 2, 3, 4]).
:- end_tests(gen_list).

% Tests for predicate 'count_solutions'
:- begin_tests(count_solutions).
test(test01) :- count_solutions(1, 1).
test(test02) :- count_solutions(4, 2).
test(test03) :- count_solutions(8, 92).
:- end_tests(count_solutions).

