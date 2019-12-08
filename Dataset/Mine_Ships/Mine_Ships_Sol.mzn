int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
set of int: N = 0..6;
array[Row,Column] of -1..6:Board;
array[Row,Column] of var 0..6: Solution; 
output [ show(Solution[i,j]) ++ if j == column then "\n" else " " endif 
        |i in Row, j in Column];  
constraint forall(i in Row, j in Column where Board[i,j] in N)(Solution[i,j] =0);
solve satisfy;

constraint forall(i in Row, j in Column where Solution[i,j] = 1) 
                 (sum(dx in {-1,0,1}, dy in {-1,0,1} where not (dx =0 /\ dy =0) /\ Solution[i+dx,j+dy] >0)(1) = 0);
constraint forall(i in Row, j in Column where Solution[i,j] = 2) 
                 (sum(dx in {-1,0,1}, dy in {-1,0,1} where not (dx =0 /\ dy =0) /\ Solution[i+dx,j+dy] >0)(1) = 1
                 /\ (Solution[i+1,j] = 3 \/ Solution[i+1,j] = 6));
constraint forall(i in Row, j in Column where Solution[i,j] = 3) 
                 (sum(dx in {-1,0,1}, dy in {-1,0,1} where not (dx =0 /\ dy =0) /\ Solution[i+dx,j+dy] >0)(1) = 1
                 /\ (Solution[i-1,j] = 2 \/ Solution[i-1,j] = 6));
constraint forall(i in Row, j in Column where Solution[i,j] = 4) 
                 (sum(dx in {-1,0,1}, dy in {-1,0,1} where not (dx =0 /\ dy =0) /\ Solution[i+dx,j+dy] >0)(1) = 1
                 /\ (Solution[i,j+1] = 5 \/ Solution[i,j+1] = 6));
constraint forall(i in Row, j in Column where Solution[i,j] = 5) 
                 (sum(dx in {-1,0,1}, dy in {-1,0,1} where not (dx =0 /\ dy =0) /\ Solution[i+dx,j+dy] >0)(1) = 1
                 /\ (Solution[i,j-1] = 4 \/ Solution[i,j-1] = 6));
                
constraint forall(i in Row, j in Column where Solution[i,j] = 6) 
                 (sum(dx in {-1,0,1}, dy in {-1,0,1} where not (dx =0 /\ dy =0) /\ Solution[i+dx,j+dy] >0)(1) = 2
                 /\ ((Solution[i-1,j]>0 /\ Solution[i+1,j]>0) \/ (Solution[i,j-1]>0 /\ Solution[i,j+1] >0)));
                 
constraint forall(i in Row, j in Column)((Solution[i,j] >0 /\ Solution[i+1,j] >0 /\ Solution[i+2,j] >0 /\ Solution[i+3,j] >0-> Solution[i+4,j] = 0)
                                       /\(Solution[i,j] >0 /\ Solution[i,j+1] >0 /\ Solution[i,j+2] >0 /\ Solution[i,j+3] >0-> Solution[i,j+4] = 0));
constraint sum(i in Row, j in Column)(Solution[i,j] = 1) = 4;
constraint sum(i in Row, j in Column)(Solution[i,j] = 6) = 4;
constraint sum(i in Row, j in Column)(Solution[i,j] in {2,3,4,5}) = 12;
constraint forall(i in Row, j in Column where Board[i,j] in N)(sum(dx in {-1,0,1}, dy in {-1,0,1} where dx !=0 \/ dy !=0)(Solution[i+dx,j+dy]>0) == Board[i,j]);  