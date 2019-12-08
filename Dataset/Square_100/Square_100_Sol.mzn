int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 1..9: Board;
array[Row,Column] of var 1..100: Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
solve satisfy;
        
constraint forall(i in Row, j in Column)
(Solution[i,j] mod 10 == Board[i,j] \/ Solution[i,j] div 10 == Board[i,j]);

constraint forall(i in Row)
(sum (j in Column)(Solution[i,j])  == 100);

constraint forall(j in Column)
(sum (i in Row)(Solution[i,j]) ==100 );