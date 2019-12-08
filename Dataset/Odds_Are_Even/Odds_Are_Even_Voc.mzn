include "alldifferent.mzn";
int: s; 
int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
set of int: Sub = 1..s;
array[Row,Column] of 0..h: Board; 
array[Row,Column] of 0..1: OE;
array[Row,Column] of var Row: Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
constraint forall(i in Row, j in Column where b[i,j] > 0 )( Solution[i,j] == b[i,j]);  
solve satisfy;