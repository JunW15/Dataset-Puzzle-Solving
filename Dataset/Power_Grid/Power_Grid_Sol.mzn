int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of bool: Board;
array[Row] of 0..9: right;
array[Column] of 0..9: bottom;
array[Row,Column] of var bool:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
solve satisfy;
        
constraint forall(i in Row )(sum(j in Column)(Solution[i,j]) == 2);
constraint forall(j in Column )(sum(i in Row)(Solution[i,j]) == 2);
constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where not (dx =0 /\ dy =0)) (not Solution[i,j] \/ not Solution[i+dx, j+dy]);
constraint forall (i in Row, j1 in Column, j in Column where (Solution[i,j] /\ Solution[i,j1]) == 1 /\ j != j1 /\right [i] != 0)(abs(j - j1) == right[i] + 1 );
constraint forall (j in Column, i1 in Row, i in Row where (Solution[i,j] /\ Solution[i1,j]) == 1 /\ i != i1 /\ bottom[j] != 0)(abs(i - i1) == bottom[j] + 1);
