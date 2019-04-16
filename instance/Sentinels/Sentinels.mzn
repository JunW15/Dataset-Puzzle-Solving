int: h;
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;
array[H,W] of 0..h+w: b;

array[H,W] of var bool:m;



constraint forall(i in H, j in W where b[i,j]>0)(m[i,j] == false);
constraint forall(i1 in H, j1 in W where b[i1,j1]>0)(sum(i2 in H, j2 in W where ((i1 == i2) /\ forall(j in min(j1,j2)..max(j1,j2))(m[i1,j] == false))
    \/
    ((j1 == j2) /\ forall(i in min(i1,i2)..max(i1,i2))(m[i,j1] == false)))(1) == b[i1,j1]);
    
constraint forall (i in H, j in W, dx in {-1, 0, 1}, dy in {-1, 0, 1} where abs(dx)!=abs(dy)) (not m[i,j] \/ not m[i+dx, j+dy]);

solve satisfy;
output [ if fix(m[i,j]) then "S" else "." endif
         ++ if j == w then "\n" else " " endif |
         i in H, j in W];