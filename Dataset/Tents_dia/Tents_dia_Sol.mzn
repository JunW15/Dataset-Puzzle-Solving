int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..1: Board;
array[Row] of 0..4: right;
array[Column] of 0..4: bottom;
array[Row,Column] of var 0..1: Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
constraint forall(i in Row, j in Column where Board[i,j] == 1)(Solution[i,j] == 0);
solve satisfy;

constraint forall (i in Row, j in Column where Solution[i,j] == 1) (sum(dx in {-1,0,1}, dy in {-1,0,1}  where not (dx =0 /\ dy = 0))(Board[i+dx,j+dy] ==1) >0);
constraint forall (i in Row, j in Column where Board[i,j] == 1) (sum(dx in {-1,0,1}, dy in {-1,0,1}  where not (dx =0 /\ dy = 0))(Solution[i+dx,j+dy] ==1) >0);
constraint forall (i in Row, j in Column, dx in {-1, 0, 1}, dy in {-1, 0, 1} where not (dx =0 /\ dy =0)) (not (Solution[i,j]==1) \/ not (Solution[i+dx, j+dy]==1));
constraint forall(i in Row)(sum(j in Column)(Solution[i,j]==1) == right[i]);
constraint forall(j in Column )(sum(i in Row)(Solution[i,j]==1) == bottom[j]);   
constraint sum(i in Row, j in Column)(Board[i,j]==1) == sum(i in Row, j in Column)(Solution[i,j] == 1);                                                       

