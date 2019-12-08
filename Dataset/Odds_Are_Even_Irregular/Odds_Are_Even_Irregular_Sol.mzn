include "alldifferent.mzn";
int: colour = 9; 
int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..row: Board; 
array[Row,Column] of 0..1: OE;
array[Row,Column] of var Row: Solution;
array[Row,Column] of 1..colour:Region;

output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
constraint forall(i in Row, j in Column where Board[i,j] > 0 )( Solution[i,j] == Board[i,j]);  
solve satisfy;

constraint forall(i in Row) (alldifferent(j in Column) (Solution[i,j]));
constraint forall(j in Column) (alldifferent(i in Row) (Solution[i,j]));
constraint forall (k in 1..colour)(alldifferent(i in Row, j in Column where Region[i,j] == k)(Solution[i,j]));
constraint forall (i in Row, j in Column where OE[i,j] == 1)(Solution[i,j] mod 2 == 1);
constraint forall (i in Row, j in Column where OE[i,j] == 0)(Solution[i,j] mod 2 == 0);

