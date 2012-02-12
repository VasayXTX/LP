% solve_puzzle (Street, Lans) is true if term Lans is list of solutions of einstein puzzle, and term Street is placement of houses
% predicate house(C, N, P, D, S) has the following information.
%   C: the color of the house;
%   N: the nationality of the resident;
%   P: the resident's pet;
%   D: the resident's drink;
%   S: the resident's cigarette.

is_right(X, Y, [X,Y|_]).
is_right(X, Y, [_|T]) :- is_right(X, Y, T).

next_to(X, Y, L) :- is_right(X, Y, L).
next_to(X, Y, L) :- is_right(Y, X, L).

house(_, _, _, _, _).

clues(Street) :-
  % The Englishman lives in the red house
  member(house(red, englishman, _, _, _), Street),
  member(house(_, spaniard, dog, _, _), Street),                              % The Spaniard owns the dog
  member(house(green, _, _, coffee, _), Street),                              % Coffee is drunk in the green house
  member(house(_, ukrainian, _, tea, _), Street),                             % The Ukrainian drinks tea
  is_right(house(green, _, _, _, _), house(ivory, _, _, _, _), Street),       % The green house is immediately to the right (your right) of the ivory house
  member(house(_, _, snails, _, winston), Street),                            % The Winston smoker owns snails
  member(house(yellow, _, _, _, kools), Street),                              % Kools are smoked in the yellow house
  [_,_,house(_, _, _, milk, _)|_] = Street,                                   % Milk is drunk in the middle house
  [house(_, norwegian, _, _, _)|_] = Street,                                  % The Norwegian lives in the first house on the left
  next_to(house(_, _, _, _, chesterfields), house(_, _, fox, _, _), Street),  % The man who smokes Chesterfields lives in the house next to the man with the fox
  next_to(house(_, _, _, _, kools), house(_, _, horse, _, _), Street),        % Kools are smoked in the house next to the house where the horse is kept
  member(house(_, _, _, juice, lucky_strike), Street),                        % The Lucky Strike smoker drinks orange juice
  member(house(_, japanese, _, _, parliaments), Street),                      % The Japanese smokes Parliaments
  next_to(house(_, norwegian, _, _, _), house(blue, _, _, _, _), Street).     % The Norwegian lives next to the blue house

queries(Street, Lans) :-
  member(house(_, Who1, zebra, _, _), Street),    % Who owns the Zebra
  member(house(_, Who2, _, water, _), Street),    % Who drinks water
  Lans = [Who1, Who2].

solve_puzzle(Street, Lans) :-
  Street = [_, _, _, _, _],
  clues(Street),
  queries(Street, Lans).

% Tests

/* Tests for 'is_right' */

:- begin_tests(is_right).
test(test01, [fail]) :- is_right(x, 2, [1, x, y, 2]).
test(test02, [fail]) :- is_right(x, y, [1, 2, 3, x]).
test(test03) :- is_right(x, y, [1, x, y, 2]).
:- end_tests(is_right).

/* Tests for 'next_to' */

:- begin_tests(next_to).
test(test04, [fail]) :- next_to(x, y, [x, 1, y]).
test(test05) :- next_to(x, y, [1, x, y, 2]).
:- end_tests(next_to).

/* Tests for 'solve_puzzle' */

:- begin_tests(solve_puzzle).
test(test07, [true(Lans = [japanese, norwegian])]) :- solve_puzzle(_, Lans).
:- end_tests(solve_puzzle).

