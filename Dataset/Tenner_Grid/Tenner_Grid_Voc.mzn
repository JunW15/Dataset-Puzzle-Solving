int: row; 
set of int: Row = 1..row;
int: column=10; 
set of int: Column = 1..column;
array[Row,Column] of -1..9:Board;
array[Column] of int:bottom;
array[Row,Column] of var 0..9:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
constraint forall (i in Row, j in Column where Board[i,j]>=0)(Solution[i,j] == Board[i,j]);
solve satisfy;
