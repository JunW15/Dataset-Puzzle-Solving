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

constraint forall (i in Row, j in Column where Solution[i,j] >0)(
                  (Solution[i,j] == 1 /\ exists(i1 in Row where i1 < i)(Board[i1,j] > 0)) \/
                  (Solution[i,j] == 2 /\ exists(i1 in Row, j1 in Column where abs(i - i1) == abs(j - j1) /\ i1 < i /\ j1 > j)(Board[i1,j1] > 0)) \/
                  (Solution[i,j] == 3 /\ exists(j1 in Column where j1 > j)(Board[i,j1] > 0)) \/
                  (Solution[i,j] == 4 /\ exists(i1 in Row, j1 in Column where abs(i - i1) == abs(j - j1) /\ i1 > i /\ j1 > j)(Board[i1,j1] > 0)) \/
                  (Solution[i,j] == 5 /\ exists(i1 in Row where i1 > i)(Board[i1,j] > 0)) \/
                  (Solution[i,j] == 6 /\ exists(i1 in Row, j1 in Column where abs(i - i1) == abs(j - j1) /\ i1 > i /\ j1 < j)(Board[i1,j1] > 0)) \/
                  (Solution[i,j] == 7 /\ exists(j1 in Column where j1 < j)(Board[i,j1] > 0)) \/
                  (Solution[i,j] == 8 /\ exists(i1 in Row, j1 in Column where abs(i - i1) == abs(j - j1) /\ i1 < i /\ j1 < j)(Board[i1,j1] > 0)));                                            
                                                                                                                                             
constraint forall (i in Row1, j in Column1)(sum(i1 in Column where i1>i)(Solution[i1,j]==1)+sum(i1 in Row where i1>i, j1 in Column where j1<j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1]==2)+sum(j1 in Column where j1<j)(Solution[i,j1] == 3)+sum(i1 in Row where i1<i, j1 in Column where j1<j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1] == 4)+sum(i1 in Row where i1<i)(Solution[i1,j] == 5)+sum(i1 in Row where i1<i, j1 in Column where j1>j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1]==6)+sum(j1 in Column where j1>j)(Solution[i,j1]==7)+sum(i1 in Row where i1>i, j1 in Column where j1>j /\ abs(i1-i) == abs(j1-j))(Solution[i1,j1]==8) ==Board[i,j]);

                                                     




