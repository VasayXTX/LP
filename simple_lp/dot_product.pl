% dot_product(L1, L2, Prod) is true, if Prod is the scalar product of lists

dot_product(L1, L2, DtProd) :- dot_product(L1, L2, 0, DtProd).
dot_product([], [], DtProd, DtProd).
dot_product([H1|L1s], [H2|L2s], Tmp, DtProd) :- 
  Tmp1 is Tmp + H1 * H2, 
  dot_product(L1s, L2s, Tmp1, DtProd).

% Tests

:- begin_tests(dot_product).
test(test01) :- dot_product([], [], 0).
test(test02) :- dot_product([2], [2], 4).
test(test03, [true(P =:= 16)]) :- dot_product([2, 3], [2, 4], P).
:- end_tests(dot_product).

