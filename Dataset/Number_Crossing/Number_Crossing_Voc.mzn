int: row; 
set of int: Row = 1..row;
int: column; 
set of int: Column = 1..column;
array[Row,Column] of var 0..9: Solution;
array[Row] of var 0..3:left;
array[Row] of var 0..row*3:right;
array[Row] of var 0..3:top;
array[Row] of var 0..row*3:bottom; 
set of int: Range = 1..column div 2;
include "gecode.mzn";
output [ show(left[i]) ++ " "|i in Row]
        ++ [ show(right[i]) ++ " "|i in Row]++ [ show(top[i]) ++ " "|i in Row]++ [ show(bottom[i]) ++ " "|i in Row];   

solve ::int_search([Solution[i,j] | i in Row, j in Column], random, indomain_random, complete) satisfy;