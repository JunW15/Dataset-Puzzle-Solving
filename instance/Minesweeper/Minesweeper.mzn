int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;

array[H,W] of -1..8: b;

set of int: N = 0..8;
array[H,W] of var bool: m;

constraint forall(i in H, j in W where b[i,j] != -1)(m[i,j] == false);

constraint forall (i in H, j in W where b[i,j] in N) (sum(dx in {-1,0,1}, dy in {-1,0,1} where dx !=0 \/ dy !=0)(m[i+dx,j+dy]) == b[i,j]);

solve satisfy;

output [ if b[i,j] != -1 then show(b[i,j])
         else if fix(m[i,j]) then "B" else "." endif
        endif ++ if j == w then "\n" else " " endif |
        i in H, j in W];         