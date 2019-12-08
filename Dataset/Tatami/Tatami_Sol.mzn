include "alldifferent.mzn"; 
int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
int: n;
int: c = row*column div n;
array[Row,Column] of 0..n: Board;
array[Row,Column] of 1.. c: Region; 
array[Row,Column] of var 1..n: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
constraint forall(i in Row,j in Column where Board[i,j] != 0)(Solution[i,j]==Board[i,j]);
solve satisfy;

constraint forall(k in 1..c)(alldifferent(i in Row, j in Column where Region[i,j] == k)(Solution[i,j]));
constraint forall(i in Row,k in 1..n-1)(sum(j in Column, i1 = i)(Solution[i1,j] == k) = sum(j1 in Column, i2 = i)(Solution[i2,j1] == k+1));
constraint forall(j in Column,k in 1..n-1)(sum(i in Row, j1 = j)(Solution[i,j1] == k) = sum(i in Row, j2 = j)(Solution[i,j2] == k+1));
constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where abs(dx) != abs(dy) /\ i+dx in Row /\ j+dy in Column) (Solution[i,j] != Solution[i+dx, j+dy]); 