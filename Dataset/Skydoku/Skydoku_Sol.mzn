include "alldifferent.mzn";
int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
int: s = 3; 
set of int: Sub = 1..s;
array[Row,Column] of 0..row: Board; 
array[Row] of 0..row:left;
array[Row] of 0..row:right;
array[Row] of 0..row:top;
array[Row] of 0..row:bottom; 
array[Row,Column] of var 1..row:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
constraint forall(i in Row, j in Column where Board[i,j]>0) (Solution[i,j] == Board[i,j]);
solve satisfy;

constraint forall(i in Row) (alldifferent(j in Column) (Solution[i,j]));
constraint forall(j in Column) (alldifferent(i in Row) (Solution[i,j]));
constraint forall (i in Sub, j in Sub)( alldifferent(i1 in Sub, j1 in Sub)(Solution[(i-1)*s + i1, (j-1)*s + j1]));
constraint forall(i in Row where left[i]>0)( sum(j in Column where Solution[i,j] >= max([Solution[i,k] | k in 1..j]))(1) == left[i]);
constraint forall(i in Row where right[i]>0)(sum(j in Column where Solution[i,j] >= max([Solution[i,k] | k in j..column]))(1) == right[i]);
constraint forall(j in Column where top[j]>0)(  sum(i in Row where Solution[i,j] >= max([Solution[k,j] | k in 1..i]))(1) == top[j]);
constraint forall(j in Column where bottom[j]>0)( sum(i in Row where Solution[i,j] >= max([Solution[k,j] | k in i..row]))(1) == bottom[j]);