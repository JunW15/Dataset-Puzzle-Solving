int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
int: colour;
array[Row,Column] of 1..colour: Board; 
set of int: Parks = 1..colour;
array[Row,Column] of var bool: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
solve satisfy;