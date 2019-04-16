include "gecode.mzn";
int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;

array[H,W] of var 0..h: b; 
int: r = h*h;
array[H] of var 0..r:left;
array[H] of var 0..r:right;
array[H] of var 0..r:top;
array[H] of var 0..r:down; 


array[H,W] of var 1..h: m; 

constraint forall(i in H)( sum(j in W where m[i,j] >= max([m[i,k] | k in 1..j]))(m[i,j]) == left[i]);
constraint forall(i in H)(sum(j in W where m[i,j] >= max([m[i,k] | k in j..w]))(m[i,j]) == right[i]);
constraint forall(j in W)(  sum(i in H where m[i,j] >= max([m[k,j] | k in 1..i]))(m[i,j]) == top[j]);
constraint forall(j in W)( sum(i in H where m[i,j] >= max([m[k,j] | k in i..h]))(m[i,j]) == down[j]);


include "alldifferent.mzn"; 
constraint forall(i in H)(alldifferent(j in W)(m[i,j]));
constraint forall(j in W)(alldifferent(i in H)(m[i,j]));

solve ::int_search([m[i,j] | i in H, j in W], random, indomain_random, complete) satisfy;

output  [show(m[i,j]) ++ " "| i in H, j in W]
        ++ [show(left[i]) ++ " "| i in H]
        ++ [show(right[i]) ++ " "| i in H]
        ++ [show(top[i]) ++ " " | i in H]
        ++ [show(down[i]) ++ " " | i in H];