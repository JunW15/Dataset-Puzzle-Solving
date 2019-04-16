int: h; 
set of int: H = 1..h;
int: w; 
set of int: W = 1..w;

array[H,W] of 1..9: b;
array[H,W] of var 1..100: a;

constraint forall(i in H, j in W)
(a[i,j] mod 10 == b[i,j] \/ a[i,j] div 10 == b[i,j]);

constraint forall(i in H)
(sum (j in W)(a[i,j])  == 100);

constraint forall(j in W)
(sum (i in H)(a[i,j]) ==100 );

solve satisfy;

output [ show(a[i,j]) ++ if j == w then "\n" else " " endif 
        |i in H, j in W];