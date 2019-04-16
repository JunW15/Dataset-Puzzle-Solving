int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;
int: n;
array[H,W] of -2..9: b; 
set of int: N = 1..n;
array[H,W] of var 0..n: m;


constraint forall(i in H, j in W where b[i,j] in N)(b[i,j] == m[i,j]);
constraint forall(i in H, k in N)(sum(j in W)(m[i,j] == k) ==1);
constraint forall(j in W, k in N)(sum(i in H)(m[i,j] == k) ==1);


constraint forall(i in H, j in W where b[i,j] == -2)(m[i,j] == 0);
constraint forall(i in H, j in W where b[i,j] == -1)(m[i,j] in N);

solve satisfy;

output [ show(m[i,j]) ++ if j == w then "\n" else " " endif |
         i in H, j in W];
