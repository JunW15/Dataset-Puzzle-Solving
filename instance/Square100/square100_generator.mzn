int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;

array[H,W] of var 1..9: b;
array[H,W] of var 1..100: m;

constraint forall(i in H, j in W)
(m[i,j] mod 10 == b[i,j] \/ m[i,j] div 10 == b[i,j]);

constraint forall(i in H)
(sum (j in W)(m[i,j])  == 100);

constraint forall(j in W)
(sum (i in H)(m[i,j]) ==100 );

solve ::int_search([m[i,j] | i in H, j in W], input_order, indomain_random, complete) satisfy;

output ["b= [|" ] ++ [show(b[i,j]) ++ if j == w then 
                                        if i!=h then 
                                          "|\n" else "|];" endif 
                                      else "," endif| i in H, j in W] ++ ["\nh="] ++ [show(h)] ++ [";\nw="] ++ [show(w)] ++[";"];