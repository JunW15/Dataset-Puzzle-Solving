include "alldifferent.mzn";
int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..row:Board;
array[Row,1..column-1] of 0..1:horizontal;
array[1..row-1,Column] of 0..1:vertical;
array[Row,Column] of var 1..row:Solution;
int: s = 3; 
set of int: Sub = 1..s;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];    
constraint forall(i in Row, j in Column where Board[i,j]>0) (Solution[i,j] == Board[i,j]);
solve satisfy;


constraint forall (i in Row) (alldifferent( [ Solution[i,j] | j in Column ]) );
constraint forall (j in Column) (alldifferent( [ Solution[i,j] | i in Row ]) );
constraint forall (i in Sub, j in Sub)( alldifferent(i1 in Sub, j1 in Sub)(Solution[(i-1)*s + i1, (j-1)*s + j1]));
constraint forall (i in Row, j in 1..column-1 where horizontal[i,j]==0)(abs(Solution[i,j]-Solution[i,j+1]) !=1);
constraint forall (i in Row, j in 1..column-1 where horizontal[i,j]==1)(abs(Solution[i,j]-Solution[i,j+1]) ==1);
constraint forall (i in 1..row-1, j in Column where vertical[i,j]==0)(abs(Solution[i,j]-Solution[i+1,j]) != 1);
constraint forall (i in 1..row-1, j in Column where vertical[i,j]==1)(abs(Solution[i,j]-Solution[i+1,j]) == 1);

