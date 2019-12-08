int: row; 
set of int: Row = 1..row;
int: column=10; 
set of int: Column = 1..column;
array[Row,Column] of -1..9:Board;
array[Column] of int:bottom;
array[Row,Column] of var 0..9:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
constraint forall (i in Row, j in Column where Board[i,j]>=0)(Solution[i,j] == Board[i,j]);
solve satisfy;

constraint forall (j in Column)(sum(i in Row)(Solution[i,j]) == bottom[j]);
include "alldifferent.mzn"; 
constraint forall(i in Row)(alldifferent(j in Column)(Solution[i,j]));
constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where not (dx ==0 /\ dy ==0)/\ i+dx in Row /\ j+dy in Column) (Solution[i,j] != Solution[i+dx,j+dy]);
