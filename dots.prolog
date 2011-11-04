% Start the game.
go :- wins(0,0,0,[0,0]).

% Number of columns minus one.
col(1).

% Board interaction.
% A board is a list of as many numbers between 1 and 15 as there are squares.
% For a 3x3 board, there are 9 numbers in that list, etc.

% The following predicate chooses the size of the board to 3x3.
isFull(Board) :- forall(member(I,Board),I >= 15).

% Asking Prolog who wins?
% Turn is either 0 or 1. It keeps track of the players.
% Score1 is the score of the player of Turn 0.
wins(_,Score0,Score1,Board) :- isFull(Board), !, writef('#0:%w; #1:%w',[Score0,Score1]).
wins(0,Score0,Score1,Board) :- huplay(Board,Score0,NewBoard,NewScore0), wins(1,NewScore0,Score1,NewBoard).
wins(1,Score0,Score1,Board) :- huplay(Board,Score1,NewBoard,NewScore1), wins(0,Score0,NewScore1,NewBoard).


huplay(Board,Score,NewBoard,NewScore) :- write(Board), write(' Position? '), read(Pos), write('Where? (0:top, etc.) '), read(Val), chosen(Board,Score,Pos,Val,NewBoard,NewScore).

% Up
chosen(Board,Score,Pos,0,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+1, NewSquare2 is Square+4, col(Col), NextPos is Pos-Col, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,PartialNewBoard), NewSquare == 15, write('Win a point!'), nl, PartialNewScore is Score+1, not(isFull(PartialNewBoard)), huplay(PartialNewBoard,PartialNewScore,NewBoard,NewScore).
chosen(Board,Score,Pos,0,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+1, NewSquare2 is Square+4, col(Col), NextPos is Pos-Col, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,PartialNewBoard), NewSquare == 15, nl, NewScore is Score+1, NewBoard = PartialNewBoard.
chosen(Board,Score,Pos,0,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+1, NewSquare2 is Square+4, col(Col), NextPos is Pos-Col, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,NewBoard), NewScore is Score.

% Right

% End of line happens once in two.
chosen(Board,Score,Pos,1,NewBoard,NewScore) :- nth0(Pos,Board,Square), col(Col), Col is mod(Pos,Col), NewSquare is Square+2, new(Board,Pos,NewSquare2,PartialNewBoard), NewSquare == 15, write('Win a point!'), nl, PartialNewScore is Score+1, not(isFull(PartialNewBoard)), huplay(PartialNewBoard,PartialNewScore,NewBoard,NewScore).
chosen(Board,Score,Pos,1,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+2, NewSquare2 is Square+8, NextPos is Pos+1, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare2,PartialNewBoard), NewSquare == 15, write('Win a point!'), nl, PartialNewScore is Score+1, not(isFull(PartialNewBoard)), huplay(PartialNewBoard,PartialNewScore,NewBoard,NewScore).
chosen(Board,Score,Pos,1,NewBoard,NewScore) :- nth0(Pos,Board,Square), col(Col), Col is mod(Pos,Col), NewSquare is Square+2, new(Board,Pos,NewSquare,PartialNewBoard), NewSquare == 15, nl, NewScore is Score+1, NewBoard = PartialNewBoard.
chosen(Board,Score,Pos,1,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+2, NewSquare2 is Square+8, NextPos is Pos+1, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,PartialNewBoard), NewSquare == 15, nl, NewScore is Score+1, NewBoard = PartialNewBoard.
chosen(Board,Score,Pos,1,NewBoard,NewScore) :- nth0(Pos,Board,Square), col(Col), Col is mod(Pos,Col), NewSquare is Square+2, new(Board,Pos,NewSquare,NewBoard), NewScore is Score.
chosen(Board,Score,Pos,1,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+2, NewSquare2 is Square+8, NextPos is Pos+1, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,NewBoard), NewScore is Score.

% Bottom

chosen(Board,Score,Pos,2,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+4, NewSquare2 is Square+1, col(Col), NextPos is Pos+Col, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,PartialNewBoard), NewSquare == 15, write('Win a point!'), nl, PartialNewScore is Score+1, not(isFull(PartialNewBoard)), huplay(PartialNewBoard,PartialNewScore,NewBoard,NewScore).
chosen(Board,Score,Pos,2,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+4, NewSquare2 is Square+1, col(Col), NextPos is Pos+Col, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,PartialNewBoard), NewSquare == 15, nl, NewScore is Score+1, NewBoard = PartialNewBoard.
chosen(Board,Score,Pos,2,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+4, NewSquare2 is Square+1, col(Col), NextPos is Pos+Col, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,NewBoard), NewScore is Score.

% Left

chosen(Board,Score,Pos,3,NewBoard,NewScore) :- nth0(Pos,Board,Square), col(Col), 0 is mod(Pos,Col), NewSquare is Square+8, NewSquare2 is Square+2, new(Board,Pos,NewSquare,PartialNewBoard), NewSquare == 15, write('Win a point!'), nl, PartialNewScore is Score+1, not(isFull(PartialNewBoard)), huplay(PartialNewBoard,PartialNewScore,NewBoard,NewScore).
chosen(Board,Score,Pos,3,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+8, NewSquare2 is Square+2, NextPos is Pos-1, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,PartialNewBoard), NewSquare == 15, write('Win a point!'), nl, PartialNewScore is Score+1, not(isFull(PartialNewBoard)), huplay(PartialNewBoard,PartialNewScore,NewBoard,NewScore).
chosen(Board,Score,Pos,3,NewBoard,NewScore) :- nth0(Pos,Board,Square), col(Col), 0 is mod(Pos,Col), NewSquare is Square+8, new(Board,Pos,NewSquare,PartialNewBoard), NewSquare == 15, nl, NewScore is Score+1, NewBoard = PartialNewBoard.
chosen(Board,Score,Pos,3,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+8, NewSquare2 is Square+2, NextPos is Pos-1, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,PartialNewBoard), NewSquare == 15, nl, NewScore is Score+1, NewBoard = PartialNewBoard.
chosen(Board,Score,Pos,3,NewBoard,NewScore) :- nth0(Pos,Board,Square), col(Col), 0 is mod(Pos,Col), NewSquare is Square+8, new(Board,Pos,NewSquare,NewBoard), NewScore is Score.
chosen(Board,Score,Pos,3,NewBoard,NewScore) :- nth0(Pos,Board,Square), NewSquare is Square+8, NewSquare2 is Square+2, NextPos is Pos-1, new(Board,NextPos,NewSquare2,PartialNewBoard1), new(PartialNewBoard1,Pos,NewSquare,NewBoard), NewScore is Score.


% A new board with everything the same but pos.
new([Head|Tail],0,Val,[Val|Tail]).
new([Head|Tail],Pos,_,[Head|Tail]) :- Pos < 0.
new([Head|Tail],Pos,_,[Head|Tail]) :- length([Head|Tail],Max), Pos >= Max.
new([Head|Tail],Pos,Val,[Head|NewTail]) :- NewPos is Pos - 1, new(Tail,NewPos,Val,NewTail).


% Artificial Intelligence.

aiplay([7|Tail],Score,NewBoard,NewScore) :- chosen([7|Tail],Score,3,NewBoard,NewScore).

