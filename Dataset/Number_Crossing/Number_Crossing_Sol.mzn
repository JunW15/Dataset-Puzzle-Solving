int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of var 0..9: Solution;
array[Row] of -1..row*column:left;
array[Row] of -1..row*column:right;
array[Row] of -1..row*column:top;
array[Row] of -1..row*column:bottom; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif |
         i in Row, j in Column];
solve satisfy;
constraint forall(i in Row where left[i] >= 0)(sum(j in Column where Solution[i,j] != 0)(1) == left[i]);
constraint forall(j in Column where top[j] >=0)(sum(i in Row where Solution[i,j] !=0)(1) == top[j]);
constraint forall(i in Row where right[i] >=0)(sum(j in Column)(Solution[i,j]) == right[i]);
constraint forall(j in Column where bottom[j] >=0)(sum(i in Row)(Solution[i,j]) == bottom[j]);
constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where not (dx =0 /\ dy =0)) ((not (Solution[i,j] >0)) \/ (not (Solution[i+dx, j+dy] >0)));