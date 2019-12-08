include "nvalue.mzn";
int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of -1..1:Board;
array[Row,Column] of var 0..1: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
constraint forall(i in Row, j in Column where Board[i,j]>-1)(Solution[i,j] = Board[i,j]);
solve satisfy;

constraint forall(i in 1..row-2, j in Column)(nvalue(2,[Solution [i + dy,j] | dy in {0,1,2}]));
constraint forall(i in Row, j in 1..column-2)(nvalue(2,[Solution [i,j + dy] | dy in {0,1,2}]));
constraint forall(i in Row)(sum(j in Column)(Solution[i,j] = 0) - sum(j in Column)(Solution[i,j] = 1) = row mod 2 );
constraint forall(j in Column)(sum(i in Row)(Solution[i,j] = 0) - sum(i in Row)(Solution[i,j] = 1) = row mod 2);
constraint forall(i in Row, i1 in Row where i<i1)(sum(j in Column)(Solution[i,j] != Solution[i1,j])>0);
constraint forall(j in Column, j1 in Column where j<j1)(sum(i in Row)(Solution[i,j] != Solution[i,j1])>0);

 