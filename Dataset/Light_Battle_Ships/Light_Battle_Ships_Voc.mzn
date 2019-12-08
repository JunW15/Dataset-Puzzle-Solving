int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
set of int: N = 0..6;
array[Row,Column] of 0..6:Board;
array[Row,Column] of var 0..6: Solution; 
array[Row,Column] of -1..10:Lighthouse;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
solve satisfy;