include "gecode.mzn";
int: h; 
set of int: H = 1..h;
int: w = 10; 
set of int: W = 1..w;


array[H,W] of var -1..9:b;
array[W] of var int:s;


array[H,W] of var 0..9:m;

constraint forall (i in H, j in W where b[i,j]>=0)(m[i,j] == b[i,j]);
constraint forall (j in W)(sum(i in H)(m[i,j]) == s[j]);
include "alldifferent.mzn"; 
constraint forall(i in H)(alldifferent(j in W)(m[i,j]));
constraint forall (i in H, j in W, dx in {-1, 0, 1}, dy in {-1, 0, 1} where not (dx ==0 /\ dy ==0)/\ i+dx in H /\ j+dy in W) (m[i,j] != m[i+dx,j+dy]);


solve ::int_search([m[i,j] | i in H, j in W], random, indomain_random, complete) satisfy;

output [ show(m[i,j]) ++ " "|i in H, j in W]
        ++ [show(s[i]) ++ " " |i in W];   