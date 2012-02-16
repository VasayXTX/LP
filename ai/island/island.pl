% Island (Five Jealous Husbands)

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
  solve_dfs(State, [State], Moves),
  print_list(Moves).

print_list([]) :- print('---').
print_list([X|Xs]) :-
  print(X),
  print('\n'),
  print_list(Xs).

% Problem
/* p(Boat, Isle, Bank)
 *   Boat -  bank with boat (isle || bank)
 *   Isle -  content of the island
 *   Bank -  content of the bank
 */

initial_state(island, p(isle, [11, 12, 13, 14, 15, 21, 22, 23, 24, 25], [])).
final_state(p(mainland, [], [11, 12, 13, 14, 15, 21, 22, 23, 24, 25])).

% rest

rest([X|Xs], X, Xs).
rest([_|Xs], Y, Zs) :- rest(Xs, Y, Zs).

% move

move(p(isle, I, _), [P1]):-
  rest(I, P1, _).
move(p(isle, I, _), [P1, P2]):-
  rest(I, P1, I1), rest(I1, P2, _), 
  legal_content([P1, P2]).
move(p(isle, I, _), [P1, P2, P3]):-
  rest(I, P1, I1), rest(I1, P2, I2), rest(I2, P3, _), 
  legal_content([P1, P2, P3]).
move(p(mainland, _, M), [P1]):-
  rest(M, P1, _).
move(p(mainland, _, M), [P1, P2]):-
  rest(M, P1, M1), rest(M1, P2, _), 
  legal_content([P1, P2]).
move(p(mainland, _, M), [P1, P2, P3]):-
  rest(M, P1, M1), rest(M1, P2, M2), rest(M2, P3, _), 
  legal_content([P1, P2, P3]).

% legal_content

legal_content(Xs) :- only_wives(Xs), !.
legal_content(Xs) :- wives_with_husbands(Xs, Xs).

% only_wives

only_wives([]).
only_wives([W|Xs]) :- couple(_, W), only_wives(Xs).

% wives_with_husbands

wives_with_husbands([], _).
wives_with_husbands([H|Xs], Ys):-
  couple(H, _), !, wives_with_husbands(Xs, Ys).
wives_with_husbands([W|Xs], Ys):-
  couple(H, W), rest(Ys, H, _), !, wives_with_husbands(Xs, Ys).
  
% couple

couple(11, 21).
couple(12, 22).
couple(13, 23).
couple(14, 24).
couple(15, 25).

% update

update(p(isle, I, M), Boat, p(mainland, I1, M1)) :-
  ordered_delete(Boat, I, I1),
  ordered_insert(Boat, M, M1).
update(p(mainland, I, M), Boat, p(isle, I1, M1)) :-
  ordered_delete(Boat, M, M1),
  ordered_insert(Boat, I, I1).

% ordered_delete

ordered_delete([], Ys, Ys).
ordered_delete([X|Xs], [X|Ys], Zs) :- !,
  ordered_delete(Xs, Ys, Zs).
ordered_delete([X|Xs], [Y|Ys], Zs) :-
  X > Y, !, Zs = [Y|Ws], ordered_delete([X|Xs], Ys, Ws). %Zs is [Y|Ws].
ordered_delete([_|Xs], [Y|Ys], [Y|Zs]) :-
  ordered_delete(Xs, Ys, Zs).

% ordered_insert

ordered_insert([], Ys, Ys).
ordered_insert(Xs, [], Xs).
ordered_insert([X|Xs], [Y|Ys], Zs) :-
  X >= Y, !, Zs = [Y|Ws], ordered_insert([X|Xs], Ys, Ws).
ordered_insert([X|Xs], Ys, [X|Zs]) :-
  ordered_insert(Xs, Ys, Zs).

% legal

legal(p(_, Xs, Ys)) :-
  legal_content(Xs), legal_content(Ys).

