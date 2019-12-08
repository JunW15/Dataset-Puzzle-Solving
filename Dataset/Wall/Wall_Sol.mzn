int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..row+column: Board;
array[Row,Column] of var -1..1:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];          
constraint forall(i in Row, j in Column where Board[i,j]>0)(Solution[i,j]==-1);
solve satisfy;

constraint forall(i in Row, j in Column where Board[i,j]==0)(Solution[i,j] != -1);
constraint forall(i1 in Row, j1 in Column where Board[i1,j1]>0)
           (sum(j2 in Column where j2 != j1 /\ (forall(j in min(j1,j2)..max(j1,j2) where j != j1)(Solution[i1,j] == 0)))(1) + 
            sum(i2 in Row where i2 != i1 /\ (forall(i in min(i1,i2)..max(i1,i2) where i != i1)(Solution[i,j1] == 1)))(1) == Board[i1,j1]);