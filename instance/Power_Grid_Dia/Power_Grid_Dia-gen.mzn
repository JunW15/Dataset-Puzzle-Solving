int: h;
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;
array[H,W] of var bool: b;
array[H] of var 1..9: height;
array[W] of var 1..9: width;

constraint forall(i in H )(sum(j in W)(b[i,j]) == 2);
        
constraint forall(j in W )(sum(i in H)(b[i,j]) == 2);

constraint forall (i in H, j in W, dx in {-1, 0, 1}, dy in {-1, 0, 1} where not (dx =0 /\ dy =0)) (not b[i,j] \/ not b[i+dx, j+dy]);

constraint forall (i in H, j1 in W, j in W where (b[i,j] /\ b[i,j1]) == 1 /\ j != j1 /\height [i] != 0)(abs(j - j1) == height[i] + 1 );
constraint forall (j in W, i1 in H, i in H where (b[i,j] /\ b[i1,j]) == 1 /\ i != i1 /\ width[j] != 0)(abs(i - i1) == width[j] + 1);
constraint sum(i in H, j in W where i == j)(b[i,j]) == 2;
constraint sum(i in H, j in W where i+j == h+1)(b[i,j])==2;

solve ::int_search([b[i,j] | i in H, j in W], input_order, indomain_random, complete) satisfy;

output  [show(height[i]) ++ " " | i in H]
         ++ [show(width[i]) ++ " " | i in H];