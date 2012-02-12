% Dutch

dutch(Xs,RedsWhitesBlues) :-
	distribute_dls(Xs, RedsWhitesBlues/WhitesBlues, WhitesBlues/Blues, Blues/[]).

distribute_dls([red(X)|Xs], Reds/Reds1, Whites, Blues) :-
	distribute_dls(Xs, Reds/[red(X)|Reds1], Whites, Blues).
distribute_dls([white(X)|Xs], Reds, Whites/Whites1, Blues) :-
	distribute_dls(Xs, Reds, Whites/[white(X)|Whites1], Blues).
distribute_dls([blue(X)|Xs], Reds, Whites, Blues/Blues1) :-
	distribute_dls(Xs, Reds, Whites, Blues/[blue(X)|Blues1]).
distribute_dls([], Reds/Reds, Whites/Whites, Blues/Blues).

% Tests
:- begin_tests(dutch).
test(test01) :- dutch([], []).
test(test02) :- dutch([white(1), blue(2), red(3)], [red(3), white(1), blue(2)]).
test(test03) :- dutch(
  [white(1), red(2), blue(3), red(4), red(5), blue(6)],
  [red(5), red(4), red(2), white(1), blue(6), blue(3)]
).
:- end_tests(dutch).

