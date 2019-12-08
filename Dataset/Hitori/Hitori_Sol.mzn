int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of Row: Board; 
array[Row,Column] of var 0..1: Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];    
solve satisfy;

constraint forall(i in Row,k in Row)(sum(j in Column where Solution[i,j] == 0)(Board[i,j] == k) <=1);
constraint forall(j in Column,k in Row)(sum(i in Row where Solution[i,j] == 0)(Board[i,j] == k) <=1);
constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where dx ==0 xor dy ==0) (not (Solution[i,j]==1) \/ not (Solution[i+dx, j+dy] ==1));
