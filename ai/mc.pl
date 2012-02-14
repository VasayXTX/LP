% Missionaries and Cannibals

% DFS template

solve_dfs(State, History, []) :-
  final_state(State).

solve_dfs(State, History, [Move|Moves]) :-
  move(State, Move),
  update(State, Move, State1),
  legal(State1),
  not(member(State1, History)),
  %print(State1),
  %print('\n'),
  solve_dfs(State1, [State1|History], Moves).

test_dfs(Problem, Moves) :-
  initial_state(Problem, State),
  solve_dfs(State, [State], Moves).

% Problem
/* mc(Boat, Left, Right)
 *   Boat  -  bank with boat
 *   Left  -  content of the left bank. It's list, first element - count of the Missionaries
 *   Right -  content of the right bank. It's list, first element - count of the Missionaries
 */

initial_state(mc, mc(left, [3, 3], [0, 0])).
final_state(mc(right, [0, 0], [3, 3])).

valid_move([Bm, Bc], [Cm, Cc]) :-
  member(Cm, [0, 1, 2]), member(Cc, [0, 1, 2]),
  S is Cm + Cc, S =< 2, S > 0,
  Nm is Bm - Cm, Nm >= 0,
  Nc is Bc - Cc, Nc >= 0.
move(mc(left, L, R), Cargo) :- valid_move(L, Cargo).
move(mc(right, L, R), Cargo) :- valid_move(R, Cargo).

update(mc(B, L, R), Cargo, mc(B1, L1, R1)) :-
  update_boat(B, B1),
  update_banks(Cargo, B, L, R, L1, R1).

update_boat(left, right).
update_boat(right, left).

update_banks([Cm, Cc], left, [Lm, Lc], [Rm, Rc], [Lm1, Lc1], [Rm1, Rc1]) :-
  Lm1 is Lm - Cm, Lc1 is Lc - Cc,
  Rm1 is Rm + Cm, Rc1 is Rc + Cc.
update_banks([Cm, Cc], right, [Lm, Lc], [Rm, Rc], [Lm1, Lc1], [Rm1, Rc1]) :-
  Lm1 is Lm + Cm, Lc1 is Lc + Cc,
  Rm1 is Rm - Cm, Rc1 is Rc - Cc.

legal(mc(left, L, R)) :- legal_bank(R).
legal(mc(right, L, R)) :- legal_bank(L).
legal_bank([0, _]) :- !.
legal_bank([_, 0]) :- !.
legal_bank([N, N]).

% Tests

% Test for 'legal_bank'
:- begin_tests(legal).
test(test01) :- legal_bank([3, 0]).
test(test02) :- legal_bank([0, 3]).
test(test03) :- legal_bank([2, 2]).
test(test04, fail) :- legal_bank([2, 3]).
:- end_tests(legal).

% Test for 'update_banks'
:- begin_tests(update_banks).
test(test01) :- update_banks([1, 1], left, [3, 3], [0, 0], [2, 2], [1, 1]).
test(test02) :- update_banks([2, 0], left, [3, 3], [0, 0], [1, 3], [2, 0]).
test(test03) :- update_banks([1, 1], right, [2, 2], [1, 1], [3, 3], [0, 0]).
test(test04) :- update_banks([2, 0], right, [1, 1], [2, 2], [3, 1], [0, 2]).
:- end_tests(update_banks).

% Test for 'valid_move'
:- begin_tests(move).
test(test01) :- valid_move([3, 3], [2, 0]).
test(test02) :- valid_move([3, 3], [1, 0]).
test(test03) :- valid_move([1, 1], [1, 1]).
test(test04, fail) :- valid_move([3, 3], [3, 0]).
test(test05, fail) :- valid_move([3, 3], [-1, 2]).
test(test06, fail) :- valid_move([0, 0], [1, 0]).
:- end_tests(move).

