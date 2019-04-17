include "alldifferent.mzn";
int: s; 
int: h; 
int: w; 
set of int: H = 1..h; 
set of int: W = 1..h;
set of int: S = 1..s;
array[H,W] of 0..h: b; 
array[H,W] of var H: m;

constraint forall(i in H, j in W where b[i,j] > 0 )( m[i,j] == b[i,j]);
constraint forall(i in H) (alldifferent(j in W) (m[i,j]));
constraint forall(j in W) (alldifferent(i in H) (m[i,j]));
constraint forall (i in S, j in S)( alldifferent(i1 in S, j1 in S)(m[(i-1)*s + i1, (j-1)*s + j1]));

solve satisfy;

output [ show(m[i,j]) ++ if j == w then "\n" else " " endif 
        |i in H, j in W];
