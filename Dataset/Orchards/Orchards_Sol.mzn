int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
int: colour;
array[Row,Column] of 1..colour: Board; 
set of int: N = 1..colour;
array[Row,Column] of var bool: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
solve satisfy;

constraint forall (i in Row, j in Column where Solution[i,j] == true) (sum(dx in {-1,0,1}, dy in {-1,0,1} where abs(dx) != abs(dy))(Solution[i+dx,j+dy]) ==1);
constraint forall (k in N) (sum (i in Row, j in Column where Board[i,j]==k) (Solution[i,j]) == 2);
