int: row;
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of -1..column+row: Board;
array[Row,Column] of var 0..1:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
constraint forall(i in Row, j in Column where Board[i,j]>-1)(Solution[i,j] == 0);  
solve satisfy;


constraint forall(i in Row, j in Column where Board[i,j]>-1)(sum(i1 in Row)(Solution[i1,j])+sum(j1 in Column)(Solution[i,j1] == 1) == Board[i,j]);
constraint forall(i in Row, j in Column where Board[i,j]>-1)(sum(dx in {-1,0,1}, dy in {-1,0,1} where not (dx =0 /\ dy =0))(Solution[i+dx,j+dy] == 1) ==0);
constraint forall(i in Row, j in Column where Solution[i,j]==1)(sum(dx in {-1,0,1}, dy in {-1,0,1} where not (dx =0 /\ dy =0))(Solution[i+dx,j+dy] == 1) ==0);

constraint forall(i in Row, j in Column where Solution[i,j]==1)(sum(i1 in Row)(Board[i1,j]>-1)+sum(j1 in Column)(Board[i,j1]>-1) >0);
