include "gecode.mzn";
int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;
set of int: N = 0..9;
array[H,W] of var 0..9: b; 
array[H,W] of var bool: m; 


constraint forall (i in H, j in W where b[i,j] in N) (sum(dx in {-1,0,1}, dy in {-1,0,1})(m[i+dx,j+dy]) == b[i,j]);

solve ::int_search([m[i,j] | i in H, j in W], random, indomain_random, complete) satisfy;

output [show(b[i,j]) ++" " | i in H, j in W];         