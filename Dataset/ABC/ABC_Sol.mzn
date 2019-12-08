int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
set of int:N = 1..max;
int:max;
array[Row,Column] of 0..max:Board;
array[Row] of 0..row:left;
array[Row] of 0..row:right;
array[Row] of 0..row:top;
array[Row] of 0..row:bottom; 
array[Row,Column] of var 0..max: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];
constraint forall(i in Row, j in Column where Board[i,j]>0)(Solution[i,j] == Board[i,j]);
solve satisfy;

constraint forall(i in Row     where left[i]>0)    (Solution[i,min([j | j in Column where Solution[i,j]>0])] =left[i] );
constraint forall(i in Row     where right[i]>0)   (Solution[i,max([j | j in Column where Solution[i,j]>0])] =right[i] );
constraint forall(j in Column  where top[j]>0)     (Solution[min([i | i in Row where Solution[i,j]>0]),j] =top[j]);
constraint forall(j in Column  where bottom[j]>0)  (Solution[max([i | i in Row where Solution[i,j]>0]),j] =bottom[j]);
constraint forall(i in Row, k in N)(sum(j in Column)(Solution[i,j] == k) ==1);
constraint forall(j in Column, k in N)(sum(i in Row)(Solution[i,j] == k) ==1);


