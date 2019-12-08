int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
int: n;
array[Row,Column] of -2..9: Board; 
set of int: N = 1..n;
array[Row,Column] of var 0..n: Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif |
         i in Row, j in Column];
constraint forall(i in Row, j in Column where Board[i,j] in N)(Board[i,j] == Solution[i,j]);
solve satisfy;

constraint forall(i in Row, k in N)(sum(j in Column)(Solution[i,j] == k) ==1);
constraint forall(j in Column, k in N)(sum(i in Row)(Solution[i,j] == k) ==1);
constraint forall(i in Row, j in Column where Board[i,j] == -2)(Solution[i,j] == 0);
constraint forall(i in Row, j in Column where Board[i,j] == -1)(Solution[i,j] in N);


