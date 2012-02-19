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
  solve_hill_climb(State1, History, Moves).

hill_climb(State, Move) :-
  findall(M, move(State, M), Moves),
  evaluate_and_order(Moves, State, [], MVs),
  print(MVs),
  print('\n'),
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

% Test for hill-climbing

initial_state(tree, a).
final_state(j).
value(a, 0).

move(a, b). value(b, 1).
move(a, c). value(c, 5).
move(a, d). value(d, 7).
move(a, e). value(e, 2).
move(c, f). value(f, 4).
move(c, g). value(g, 6).
move(d, j). value(j, 9).
move(e, k). value(k, 1).
move(f, h). value(h, 3).
move(f, i). value(i, 2).

update(_, State1, State1).
legal(_).

