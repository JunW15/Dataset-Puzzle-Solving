include "alldifferent.mzn";
int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..row: Board; 
array[Row,Column] of var Row: Solution;
array[Row,Column] of 1..row:Region;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];           
constraint forall(i in Row, j in Column where Board[i,j] > 0 )( Solution[i,j] == Board[i,j]);
solve satisfy;

constraint forall(i in Row) (alldifferent(j in Column) (Solution[i,j]));
constraint forall(j in Column) (alldifferent(i in Row) (Solution[i,j]));
constraint forall (k in 1..row)(alldifferent( [Solution[i,j] | i in Row, j in Column where Region[i,j] ==k]));
constraint forall (i in Row, j in Column, dx in {-2,-1,1,2}, dy in {-2,-1,1,2} where abs(dx)+abs(dy) == 3 /\ i+dx in Row /\ j+dy in Column) (Solution[i,j] != Solution[i+dx,j+dy]);

