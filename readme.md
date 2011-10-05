# dots and boxes game

by (Jan) [github.com/jankeromnes] & (Yann) [github.com/espadrine]

## data

* `b: [h, v]` the board 
* `h: [r ... r]` the rows of horizontal links
* `v: [r ... r]` the rows of vertical links
* `r: [p ... p]` the positions of links
* `p: int` a position of a link

## algorithms

* `ins()` insert a not yet existing link
 - if it closes a box, +1 point and play again 
