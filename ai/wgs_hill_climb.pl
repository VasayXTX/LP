% Solution for problem wolf, goat, cabbage usign hill-climb algorithm

% Hill climbing framework for problem solving

test_hill_climb(Problem, Moves) :-
  initial_state(Problem, State),
  solve_hill_climb(State, [State], Moves).

solve_hill_climb(State, _, []) :-
  final_state(State).
solve_hill_climb(State, History, [Move|Moves]) :-
  hill_climb(State, Move),
  update(State, Move, State1),
  legal(State1),
  not(member(State1, History)),
  solve_hill_climb(State1, [State1|History], Moves).

hill_climb(State, Move) :-
  findall(M, move(State, M), Moves),
  evaluate_and_order(Moves, State, [], MVs),
  member((Move, _), MVs).

evaluate_and_order([Move|Moves], State, MVs, OrderedMVs) :-
  update(State, Move, State1),
  value(State1, Value),
  insert((Move, Value), MVs, MVs1),
  evaluate_and_order(Moves, State, MVs1, OrderedMVs).
evaluate_and_order([], _, MVs, MVs).

insert(MV, [], [MV]).
insert((M, V), [(M1, V1)|MVs], [(M, V), (M1, V1)|MVs]) :-
  V >= V1.
insert((M, V), [(M1, V1)|MVs], [(M1, V1)|MVs1]) :-
  V < V1, insert((M, V), MVs, MVs1).

% WGS problem
/* wgs(Boat, Left, Right)
 *   Boat - берег, у которого находится лодка
 *   Left - содержимое левого берега
 *   Right - содержимое правого берега
 */

initial_state(wgs, wgs(left, [wolf, goat, cabbage], [])).
final_state(wgs(right, [], [wolf, goat, cabbage])).

value(wgs(_, _, R), V) :- length(R, V).

move(wgs(left, L, R), Cargo) :- member(Cargo, L).
move(wgs(right, L, R), Cargo) :- member(Cargo, R).
move(wgs(B, L, R), alone).

update(wgs(B, L, R), Cargo, wgs(B1, L1, R1)) :-
  update_boat(B, B1), update_banks(Cargo, B, L, R, L1, R1).

update_boat(left, right).
update_boat(right, left).

update_banks(alone, B, L, R, L, R).
update_banks(Cargo, left, L, R, L1, R1) :-
  select(Cargo, L, L1), ordered_insert(Cargo, R, R1).
update_banks(Cargo, right, L, R, L1, R1) :-
  select(Cargo, R, R1), ordered_insert(Cargo, L, L1).

ordered_insert(X, [Y|Ys], [X,Y|Ys]) :-
  precedes(X, Y).
ordered_insert(X, [Y|Ys], [Y|Zs]) :-
  precedes(Y, X), ordered_insert(X, Ys, Zs).
ordered_insert(X, [], [X]).

precedes(wolf, X).
precedes(X, cabbage).

legal(wgs(left, L, R)) :- not(illegal(R)).
legal(wgs(right, L, R)) :- not(illegal(L)).

illegal(Ls) :- member(wolf, Ls), member(goat, Ls).
illegal(Ls) :- member(goat, Ls), member(cabbage, Ls).

