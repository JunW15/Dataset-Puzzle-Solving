int: row;
set of int: Row1 = 1..row;
int: column; 
set of int: Column1 = 1..column;
array[Row1,Column1] of int: Board;
set of int: Row = 0..row+1;
set of int: Column = 0..column+1;
array[Row,Column] of var 0..8: Solution;

output [ show(Solution[i,j]) ++ if j == column+1 then "\n" else " " endif 
        |i in Row, j in Column];
constraint forall(i in Row1, j in Column1)(Solution[i,j] == 0);
constraint(Solution[0,0]==0);
constraint(Solution[0,row+1]==0);
constraint(Solution[column+1,0]==0);
constraint(Solution[column+1,row+1]==0);
solve satisfy;