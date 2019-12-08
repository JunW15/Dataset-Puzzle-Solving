int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..8: Board;
array[Row,Column] of var 0..1: Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column]; 
constraint forall(i in Row, j in Column where Board[i,j] > 0)(Solution[i,j] == false);
solve satisfy;

constraint forall (i in Row, j in Column where Board[i,j] == 1) (sum(i1 in Row where i1<i)(Solution[i1,j]) >0);
constraint forall (i in Row, j in Column where Board[i,j] == 2) (sum(i1 in Row where i1<i, j1 in Column where j1>j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1]) >0);
constraint forall (i in Row, j in Column where Board[i,j] == 3) (sum(j1 in Column where j1>j)(Solution[i,j1]) >0);
constraint forall (i in Row, j in Column where Board[i,j] == 4) (sum(i1 in Row where i1>i, j1 in Column where j1>j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1]) >0);
constraint forall (i in Row, j in Column where Board[i,j] == 5) (sum(i1 in Row where i1>i)(Solution[i1,j]) >0);
constraint forall (i in Row, j in Column where Board[i,j] == 6) (sum(i1 in Row where i1>i, j1 in Column where j1<j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1]) >0);
constraint forall (i in Row, j in Column where Board[i,j] == 7) (sum(j1 in Column where j1<j)(Solution[i,j1]) >0);
constraint forall (i in Row, j in Column where Board[i,j] == 8) (sum(i1 in Row where i1>i, j1 in Column where j1>j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1]) >0);

constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where not (dx =0 /\ dy =0)) (not (Solution[i,j]==1) \/ not (Solution[i+dx, j+dy] ==1));


constraint forall (i in Row) (sum (j in Column) (Solution[i,j]) <= 1);
constraint forall (j in Column) (sum (i in Row) (Solution[i,j]) <= 1);                                  