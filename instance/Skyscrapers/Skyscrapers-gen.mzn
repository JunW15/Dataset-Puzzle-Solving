include "gecode.mzn";

int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;

array[H,W] of var 0..h:b;
array[H] of var 0..h:left;
array[H] of var 0..h:right;
array[H] of var 0..h:top;
array[H] of var 0..h:down; 


array[H,W] of var 1..h: m; 


constraint forall(i in H, j in W where b[i,j]>0)(m[i,j] == b[i,j]);

constraint forall(i in H where left[i]>0)( sum(j in W where m[i,j] >= max([m[i,k] | k in 1..j]))(1) == left[i]);
constraint forall(i in H where right[i]>0)(sum(j in W where m[i,j] >= max([m[i,k] | k in j..w]))(1) == right[i]);
constraint forall(j in W where top[j]>0)(  sum(i in H where m[i,j] >= max([m[k,j] | k in 1..i]))(1) == top[j]);
constraint forall(j in W where down[j]>0)( sum(i in H where m[i,j] >= max([m[k,j] | k in i..h]))(1) == down[j]);



constraint (sum(i in H)(left[i])>h);
constraint (sum(i in H)(top[i])>h);
constraint (sum(i in H)(down[i])>h);
constraint (sum(i in H)(right[i])>h);

include "alldifferent.mzn"; 
constraint forall(i in H)(alldifferent(j in W)(m[i,j]));
constraint forall(j in W)(alldifferent(i in H)(m[i,j]));

solve ::int_search([m[i,j] | i in H, j in W], random, indomain_random, complete) satisfy;

output  [show(m[i,j]) ++ " "| i in H, j in W]
        ++ [show(left[i]) ++ " "| i in H]
        ++ [show(right[i]) ++ " "| i in H]
        ++ [show(top[i]) ++ " " | i in H]
        ++ [show(down[i]) ++ " " | i in H];