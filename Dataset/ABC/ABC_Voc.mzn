int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
set of int:N = 1..max;
int:max;
array[Row,Column] of 0..max:Board;
array[Row] of 0..row:left;
array[Row] of 0..row:right;
array[Row] of 0..row:top;
array[Row] of 0..row:bottom; 
array[Row,Column] of var 0..max: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];
constraint forall(i in Row, j in Column where Board[i,j]>0)(Solution[i,j] == Board[i,j]);
solve satisfy;