int: row;
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of 0..column+row: Board;
array[Row,Column] of var -1..5:Solution;
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];
constraint forall(i in Row, j in Column where Board[i,j] >0)(Solution[i,j] == -1);
solve satisfy;

constraint forall(i in Row, j in Column where Board[i,j] == 0)(Solution[i,j] != -1);

constraint forall(i1 in Row, j1 in Column where Board[i1,j1]>0)
           (sum(j2 in Column where (Solution[i1,j2] == 0 \/ (Solution[i1,j2] == 3 /\ j1 > j2) \/ (Solution[i1,j2] == 5 /\ j1 < j2)) /\ j2 != j1 /\ (forall(j in min(j1,j2)..max(j1,j2) where j != j1 /\ j != j2)(Solution[i1,j] == 0)))(1) + 
            sum(i2 in Row where (Solution[i2,j1] == 1 \/ (Solution[i2,j1] == 2 /\ i1 < i2) \/ (Solution[i2,j1] == 4 /\ i1 > i2)) /\ i2 != i1 /\ (forall(i in min(i1,i2)..max(i1,i2) where i != i1 /\ i != i2)(Solution[i,j1] == 1)))(1) == Board[i1,j1]);

constraint forall(i in Row, j in Column where Solution[i,j] == 0 \/ Solution[i,j] == 3 \/ Solution[i,j] == 5)
                 (exists(j1 in Column where (Solution[i,j] == 0 \/ (Solution[i,j] == 3 /\ j < j1) \/ (Solution[i,j] == 5 /\ j >j1)) /\ forall(j2 in (min(j,j1) +1) ..(max(j,j1) -1))(Solution[i,j2] == 0))(Board[i,j1] > 0)
                  /\ exists(j1 in Column where (Solution[i,j] == 0 \/ (Solution[i,j] == 3 /\ j <= j1) \/ (Solution[i,j] == 5 /\ j >= j1)) /\ forall(j2 in (min(j,j1) +1) ..(max(j,j1) -1))(Solution[i,j2] == 0))((Solution[i,j1] ==3 /\ j1 <=j) \/ (Solution[i,j1] == 5 /\ j1 >= j)));

      
constraint forall(i in Row, j in Column where Solution[i,j] == 1 \/ Solution[i,j] == 2 \/ Solution[i,j] == 4)
                 (exists(i1 in Row where (Solution[i,j] == 1 \/ (Solution[i,j] == 2 /\ i > i1) \/ (Solution[i,j] == 4 /\ i <i1)) /\ forall(i2 in (min(i,i1) +1) ..(max(i,i1) -1))(Solution[i2,j] == 1))(Board[i1,j] > 0)
                  /\ exists(i1 in Row where (Solution[i,j] == 1 \/ (Solution[i,j] == 2 /\ i >= i1) \/ (Solution[i,j] == 4 /\ i <= i1)) /\ forall(i2 in (min(i,i1) +1) ..(max(i,i1) -1))(Solution[i2,j] == 1))((i1 >= i /\ Solution[i1,j] ==2) \/ (i1 <= i /\ Solution[i1,j] == 4)));
                  
                                                     


     