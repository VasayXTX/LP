% Wolf, goat and cabbage

% DFS template

solve_dfs(State, History, []) :-
  final_state(State).

solve_dfs(State, History, [Move|Moves]) :-
  move(State, Move),
  update(State, Move, State1),
  legal(State1),
  not(member(State1, History)),
  solve_dfs(State1, [State1|History], Moves).

test_dfs(Problem, Moves) :-
  initial_state(Problem, State),
  solve_dfs(State, [State], Moves).

% Problem
/* wgs(Boat, Left, Right)
 *   Boat - берег, у которого находится лодка
 *   Left - содержимое левого берега
 *   Right - содержимое правого берега
 */

initial_state(wgs, wgs(left, [wolf, goat, cabbage], [])).
final_state(wgs(right, [], [wolf, goat, cabbage])).

move(wgs(left, L, R), Cargo) :- member(Cargo, L).    % Лодка двигается от левого берега
move(wgs(right, L, R), Cargo) :- member(Cargo, R).   % Лодка двигается от правого берега
move(wgs(B, L, R), alone).

update(wgs(B, L, R), Cargo, wgs(B1, L1, R1)) :-
  update_boat(B, B1), update_banks(Cargo, B, L, R, L1, R1).

update_boat(left, right).
update_boat(right, left).

update_banks(alone, B, L, R, L, R).
update_banks(Cargo, left, L, R, L1, R1) :-
  select(Cargo, L, L1), insert(Cargo, R, R1).
update_banks(Cargo, right, L, R, L1, R1) :-
  select(Cargo, R, R1), insert(Cargo, L, L1).

insert(X, [Y|Ys], [X,Y|Ys]) :-
  precedes(X, Y).
insert(X, [Y|Ys], [Y|Zs]) :-
  precedes(Y, X), insert(X, Ys, Zs).
insert(X, [], [X]).

precedes(wolf, X).
precedes(X, cabbage).

legal(wgs(left, L, R)) :- not(illegal(R)).
legal(wgs(right, L, R)) :- not(illegal(L)).

illegal(Ls) :- member(wolf, Ls), member(goat, Ls).
illegal(Ls) :- member(goat, Ls), member(cabbage, Ls).

