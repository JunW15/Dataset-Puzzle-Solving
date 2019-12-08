int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of -1..8: Board;
set of int: N = 0..8;
array[Row,Column] of 0..1: Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
constraint forall(i in Row, j in Column where Board[i,j] != -1)(Solution[i,j] = 1);
solve satisfy;

constraint forall (i in Row, j in Column where Board[i,j] in N) (sum(dx in {-1,0,1}, dy in {-1,0,1} where dx !=0 \/ dy !=0)(Solution[i+dx,j+dy] > 0) == Board[i,j]);

  