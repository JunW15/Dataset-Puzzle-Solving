int: row;
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..8: Board;
array[Row] of 0..row: right;
array[Column] of 0..row: bottom;
array[Row,Column] of var 0..1: Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column]; 
constraint forall(i in Row, j in Column where Board[i,j] > 0)(Solution[i,j] == 0);
solve satisfy;

constraint forall (i in Row, j in Column where Board[i,j] == 1) (exists(i1 in Row where i1<i)(Solution[i1,j] == 1));
constraint forall (i in Row, j in Column where Board[i,j] == 2) (exists(i1 in Row where i1<i, j1 in Column where j1>j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1] == 1));
constraint forall (i in Row, j in Column where Board[i,j] == 3) (exists(j1 in Column where j1>j)(Solution[i,j1] == 1));
constraint forall (i in Row, j in Column where Board[i,j] == 4) (exists(i1 in Row where i1>i, j1 in Column where j1>j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1] == 1));
constraint forall (i in Row, j in Column where Board[i,j] == 5) (exists(i1 in Row where i1>i)(Solution[i1,j] == 1));
constraint forall (i in Row, j in Column where Board[i,j] == 6) (exists(i1 in Row where i1>i, j1 in Column where j1<j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1] == 1));
constraint forall (i in Row, j in Column where Board[i,j] == 7) (exists(j1 in Column where j1<j)(Solution[i,j1] == 1));
constraint forall (i in Row, j in Column where Board[i,j] == 8) (exists(i1 in Row where i1<i, j1 in Column where j1<j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1] == 1));


constraint forall (i in Row, j in Column where Solution[i,j] == 1)
(sum(i1 in Column where i1>i)(Board[i1,j]==1) +
sum(i1 in Row where i1>i, j1 in Column where j1<j /\ abs(i1-i) == abs(j1-j))(Board[i1,j1]==2) +
sum(j1 in Column where j1<j)(Board[i,j1] == 3) +
sum(i1 in Row where i1<i, j1 in Column where j1<j /\ abs(i1-i) == abs(j1-j))(Board[i1,j1] == 4) +
sum(i1 in Row where i1<i)(Board[i1,j] == 5) +
sum(i1 in Row where i1<i, j1 in Column where j1>j /\ abs(i1-i) == abs(j1-j))(Board[i1,j1]==6) +
sum(j1 in Column where j1>j)(Board[i,j1]==7) +
sum(i1 in Row where i1<i, j1 in Column where j1<j /\ abs(i1-i) == abs(j1-j))(Board[i1,j1]==8) == 1);

constraint forall(i in Row)(sum(j in Column)(Solution[i,j] == 1) == right[i]);
constraint forall(j in Column)(sum(i in Row)(Solution[i,j] == 1) == bottom[j]);                                                          
