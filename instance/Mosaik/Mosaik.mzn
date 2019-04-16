int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;

array[H,W] of -1..9: b; 

set of int: N = 0..9;
array[H,W] of var bool: m; 

                             
constraint forall (i in H, j in W where b[i,j] in N) (sum(dx in {-1,0,1}, dy in {-1,0,1})(m[i+dx,j+dy]) == b[i,j]);


solve satisfy;

output [ if fix(m[i,j]) then "W" else "."
        endif ++ if j == w then "\n" else " " endif |
        i in H, j in W];         