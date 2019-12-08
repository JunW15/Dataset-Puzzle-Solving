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