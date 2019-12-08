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

constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where not (dx =0 /\ dy =0)) (not Solution[i,j] \/ not Solution[i+dx, j+dy]);
constraint forall (i in Row) (sum (j in Column) (Solution[i,j]) == 1); constraint forall (j in Column) (sum (i in Row) (Solution[i,j]) == 1);
constraint forall (park in Parks) (sum (i in Row, j in Column where Board[i,j]==park) (Solution[i,j]) == 1);


