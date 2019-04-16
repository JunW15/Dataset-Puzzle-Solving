include "gecode.mzn";
int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;

array[H,W] of var -1..8: b;

set of int: N = 0..8;
array[H,W] of var bool: m;

constraint forall (i in H, j in W where m[i,j] == true)(b[i,j]==-1);
constraint forall (i in H, j in W where b[i,j] in N) (sum(dx in {-1,0,1}, dy in {-1,0,1} where dx !=0 \/ dy !=0)(m[i+dx,j+dy]) == b[i,j]);

constraint forall (i in H, j in W where m[i,j] == false)(b[i,j] >=0);
constraint forall (i in H, j in W where m[i,j] == true)(sum(dx in {-1,0,1}, dy in {-1,0,1} where b[i+dx,j+dy] > -1)(1)>0);

constraint (sum(i in H, j in W where b[i,j]== 1 \/ b[i,j] == 0)(1)>=(h));
constraint (sum(i in H, j in W where b[i,j] == 1 \/ b[i,j] == 2)(1)>=3*h);
constraint (sum(i in H, j in W where b[i,j] == 2 \/ b[i,j] == 3)(1)>h);
constraint (sum(i in H, j in W where b[i,j] >=5)(1) <h);
constraint (sum(i in H, j in W where m[i,j] == true)(1)<=h*2.5);

solve ::int_search([m[i,j] | i in H, j in W], random, indomain_random, complete) satisfy;


output [show(b[i,j]) ++ " " |i in H, j in W]