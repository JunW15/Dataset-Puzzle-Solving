int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row] of 0..9: right;
array[Column] of 0..9: bottom;
array[Row,Column] of var bool:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
solve satisfy;