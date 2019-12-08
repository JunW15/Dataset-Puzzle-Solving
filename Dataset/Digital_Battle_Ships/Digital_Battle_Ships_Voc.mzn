int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 1..8:Board;
array[Row] of -1..30:right;
array[Row] of -1..30:bottom; 
array[Row,Column] of var 0..6: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
solve satisfy;
