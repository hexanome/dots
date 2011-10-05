# dots and boxes game

by (Jan) [github.com/jankeromnes] & (Yann) [github.com/espadrine]

## data

* `B: [H, V]` the board 
* `H: [R ... R]` the rows of horizontal links
* `V: [R ... R]` the rows of vertical links
* `R: [p ... P]` the positions of links
* `P: int` a position of a link

## algorithms

* `ins()` insert a not yet existing link
 - if it closes a box, +1 point and play again 
