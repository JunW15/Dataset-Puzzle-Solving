include "alldifferent.mzn";
int: s; 
int: h; 
int: w; 
set of int: H = 1..h; 
set of int: W = 1..h;
set of int: S = 1..s;
array[H,W] of var H: m;


constraint forall(i in H) (alldifferent(j in W) (m[i,j]));
constraint forall(j in W) (alldifferent(i in H) (m[i,j]));
constraint forall (i in S, j in S)( alldifferent(i1 in S, j1 in S)(m[(i-1)*s + i1, (j-1)*s + j1]));

solve ::int_search([m[i,j] | i in H, j in W], input_order, indomain_random, complete) satisfy;

output [show(m[i,j]) ++" " |i in H, j in W];