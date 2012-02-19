% Solution for stable marriage problem

% Designations
%   a - avraham
%   b - binyamin
%   c - chaim
%   d - david
%   e - elazar
%   1 - zvia
%   2 - chana
%   3 - ruth
%   4 - sarah
%   5 - tamar

% Men's preferences
preferences(a, [2, 5, 1, 3, 4]).
preferences(b, [1, 2, 3, 4, 5]).
preferences(c, [2, 3, 5, 4, 1]).
preferences(d, [1, 3, 2, 4, 5]).
preferences(e, [5, 3, 2, 1, 4]).

% Women's preferences
preferences(1, [e, a, d, b, c]).
preferences(2, [d, e, b, a, c]).
preferences(3, [a, d, b, c, e]).
preferences(4, [c, b, d, a, e]).
preferences(5, [d, b, c, e, a]).

generate_and_test(Men, Women, Marriages) :-
  generate(Men, Women, Marriages),
  stable(Men, Women, Marriages).

generate([], [], []).
generate([Man|Men], Women, [m(Man, Woman)|Marriages]) :-
  select(Woman, Women, Women1),
  generate(Men, Women1, Marriages).

stable([], _, _).
stable([Man|Men], Women, Marriages) :-
  stable_1(Women, Man, Marriages),
  stable(Men, Women, Marriages).

stable_1([], _, _).
stable_1([Woman|Women], Man, Marriages) :-
  not(unstable(Man, Woman, Marriages)),
  stable_1(Women, Man, Marriages).

unstable(Man, Woman, Marriages) :-
  member(m(Man, Wife), Marriages),
  member(m(Husband, Woman), Marriages),
  prefers(Man, Woman, Wife),
  prefers(Woman, Man, Husband).

prefers(Person, OtherPerson, Spouse) :-
  preferences(Person, Preferences),
  rest(OtherPerson, Preferences, Rest),
  member(Spouse, Rest).

rest(X, [X|Xs], Xs).
rest(X, [_|Ys], Zs) :-
  rest(X, Ys, Zs).
  
% Tests
% Tests for predicat 'rest'
:- begin_tests(rest).
test(test01) :- rest(1, [1], []).
test(test02) :- rest(1, [0, 1], []).
test(test03) :- rest(1, [1, 2], [2]).
test(test04) :- rest(2, [1, 2, 3, 4], [3, 4]).
:- end_tests(rest).

% Tests for predicat 'married'
:- begin_tests(married).
test(test01) :- married(a, 1, [m(a,1),m(b,2),m(c,3),m(d,4),m(e,5)]).
test(test02) :- married(e, 5, [m(a,1),m(b,2),m(c,3),m(d,4),m(e,5)]).
test(test04, fail) :- married(c, 2, [m(a,1),m(b,2),m(c,3),m(d,4),m(e,5)]).
:- end_tests(married).

% Tests for predicat 'prefers'
:- begin_tests(prefers).
test(test01) :- prefers(b, 1, 2).
test(test02) :- prefers(b, 4, 5).
test(test03) :- prefers(1, e, a).
test(test04, fail) :- prefers(b, 3, 2).
:- end_tests(prefers).

