include "alldifferent.mzn"; 
int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..row: Board; 
array[Row] of int:left;
array[Row] of int:right;
array[Row] of int:top;
array[Row] of int:bottom; 
array[Row,Column] of var 1..row: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];          
constraint forall(i in Row, j in Column where Board[i,j]>0)(Solution[i,j]==Board[i,j]);
solve satisfy;

constraint forall(i in Row where left[i]>0)( sum(j in Column where Solution[i,j] >= max([Solution[i,k] | k in 1..j]))(Solution[i,j]) == left[i]);
constraint forall(i in Row where right[i]>0)(sum(j in Column where Solution[i,j] >= max([Solution[i,k] | k in j..column]))(Solution[i,j]) == right[i]);
constraint forall(j in Column where top[j]>0)(  sum(i in Row where Solution[i,j] >= max([Solution[k,j] | k in 1..i]))(Solution[i,j]) == top[j]);
constraint forall(j in Column where bottom[j]>0)( sum(i in Row where Solution[i,j] >= max([Solution[k,j] | k in i..row]))(Solution[i,j]) == bottom[j]);

constraint forall(i in Row)(alldifferent(j in Column)(Solution[i,j]));
constraint forall(j in Column)(alldifferent(i in Row)(Solution[i,j]));

   