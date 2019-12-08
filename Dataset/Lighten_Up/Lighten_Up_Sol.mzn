int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of -1..5: Board;      
set of int: N = 0..4;           
test visible(int: i1, int: j1, int: i2, int: j2) = 
    ((i1 == i2) /\ forall(j in min(j1,j2)..max(j1,j2))(Board[i1,j] == -1))
    \/
    ((j1 == j2) /\ forall(i in min(i1,i2)..max(i1,i2))(Board[i,j1] == -1));
array[Row,Column] of var 0..1: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];   
constraint forall(i in Row, j in Column where Board[i,j] != -1)(Solution[i,j] == 0);
solve satisfy;

constraint forall(i in Row, j in Column where Board[i,j] in N)(
    sum(dx in {-1,0,1}, dy in {-1,0,1} where abs(dx) != abs(dy) /\ Solution[i+dx,j+dy] == 1)(1) == Board[i,j]);

                             
constraint forall(i in Row, j in Column where Board[i,j] == -1)(
             exists(j1 in Column where visible(i,j,i,j1))(Solution[i,j1] == 1) \/
             exists(i1 in Row where visible(i,j,i1,j))(Solution[i1,j] == 1) 
           );

constraint forall(i1,i2 in Row, j1,j2 in Column where 
                  (i1 != i2 \/ j1 != j2) /\ Board[i1,j1] == -1 
                  /\ Board[i2,j2] == -1 /\ visible(i1,j1,i2,j2))(
             not (Solution[i1,j1] ==1) \/ not (Solution[i2,j2] ==1)
           );

