int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..column+row: Board;
array[Row,Column] of var bool:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
constraint forall(i in Row, j in Column where Board[i,j]>0)(Solution[i,j] == false);
solve satisfy;

constraint forall(i1 in Row, j1 in Column where Board[i1,j1]>0)(sum(i2 in Row, j2 in Column where ((i1 == i2) /\ forall(j in min(j1,j2)..max(j1,j2))(Solution[i1,j] == false))
    \/
    ((j1 == j2) /\ forall(i in min(i1,i2)..max(i1,i2))(Solution[i,j1] == false)))(1) == Board[i1,j1]);
    
constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where abs(dx)!=abs(dy)) (not Solution[i,j] \/ not Solution[i+dx, j+dy]);

