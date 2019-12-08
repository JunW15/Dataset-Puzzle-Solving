int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row] of int:left;
array[Row] of int:right;
array[Row] of int:top;
array[Row] of int:bottom; 
array[Row,Column] of var 0..1: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];
solve satisfy;

constraint forall(i in Row where left[i]>0)( sum(j in Column where Solution[i,j] == 1)(right[j]) == left[i]);
constraint forall(j in Column where top[j]>0)(  sum(i in Row where Solution[i,j] == 1)(bottom[i]) == top[j]);