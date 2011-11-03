:- dynamic(score/2).
:- dynamic(turn/1).
:- dynamic(noswitch/0).
:- dynamic(field/3).

score(player1,0).
score(player2,0).
turn(player1).
next(player2).

field(0,0,0).
field(0,1,0).
field(0,2,0).
field(0,3,0).
field(0,4,0).
field(0,5,0).
field(0,6,0).
field(0,7,0).
field(0,8,0).
field(0,9,0).
field(1,0,0).
field(1,1,0).
field(1,2,0).
field(1,3,0).
field(1,4,0).
field(1,5,0).
field(1,6,0).
field(1,7,0).
field(1,8,0).
field(1,9,0).
field(2,0,0).
field(2,1,0).
field(2,2,0).
field(2,3,0).
field(2,4,0).
field(2,5,0).
field(2,6,0).
field(2,7,0).
field(2,8,0).
field(2,9,0).
field(3,0,0).
field(3,1,0).
field(3,2,0).
field(3,3,0).
field(3,4,0).
field(3,5,0).
field(3,6,0).
field(3,7,0).
field(3,8,0).
field(3,9,0).
field(4,0,0).
field(4,1,0).
field(4,2,0).
field(4,3,0).
field(4,4,0).
field(4,5,0).
field(4,6,0).
field(4,7,0).
field(4,8,0).
field(4,9,0).
field(5,0,0).
field(5,1,0).
field(5,2,0).
field(5,3,0).
field(5,4,0).
field(5,5,0).
field(5,6,0).
field(5,7,0).
field(5,8,0).
field(5,9,0).
field(6,0,0).
field(6,1,0).
field(6,2,0).
field(6,3,0).
field(6,4,0).
field(6,5,0).
field(6,6,0).
field(6,7,0).
field(6,8,0).
field(6,9,0).
field(7,0,0).
field(7,1,0).
field(7,2,0).
field(7,3,0).
field(7,4,0).
field(7,5,0).
field(7,6,0).
field(7,7,0).
field(7,8,0).
field(7,9,0).
field(8,0,0).
field(8,1,0).
field(8,2,0).
field(8,3,0).
field(8,4,0).
field(8,5,0).
field(8,6,0).
field(8,7,0).
field(8,8,0).
field(8,9,0).
field(9,0,0).
field(9,1,0).
field(9,2,0).
field(9,3,0).
field(9,4,0).
field(9,5,0).
field(9,6,0).
field(9,7,0).
field(9,8,0).
field(9,9,0).

play(X,Y,V) :-
  V == 1,
  Z is X-1,
  impact(X,Y,1),
  impact(Z,Y,4),
  next.

play(X,Y,V) :-
  V == 2,
  Z is Y+1,
  impact(X,Y,2),
  impact(X,Z,8),
  next.

play(X,Y,V) :-
  V == 4,
  Z is X+1,
  impact(X,Y,4),
  impact(Z,Y,1),
  next.

play(X,Y,V) :-
  V == 8,
  Z is Y-1,
  impact(X,Y,8),
  impact(X,Z,2),
  next.

% no impact outside of the board.
impact(X,Y,V) :- X < 0, true.
impact(X,Y,V) :- X > 9, true.
impact(X,Y,V) :- Y < 0, true.
impact(X,Y,V) :- Y > 9, true.

impact(X,Y,V) :-
  field(X,Y,A),  % recall the value of the field
  B is A+V,      % add V to this value
  swap(X,Y,A,B). % set it

swap(X,Y,A,B) :-
  B == 15,          % the square is full
  reward,           % +1 point!
  assert(noswitch), % play again
  retract(field(X,Y,A)),          % remove old value
  assert(field(X,Y,B)).           % set new value

swap(X,Y,A,B) :-
  retract(field(X,Y,A)),
  assert(field(X,Y,B)).

reward :-
  turn(Player),
  score(Player,X),
  S is X+1,
  retract(score(Player,X)),
  assert(score(Player,S)).

next :-
  noswitch,
  retract(noswitch),
  write('play again'),nl,
  go.

next :-
  turn(player1),
  retract(turn(player1)) ,
  assert(turn(player2)),
  go.

next :-
  turn(player2),
  retract(turn(player2)),
  assert(turn(player1)),
  go.

go :- win.

go :-
  turn(player2), % AI move on player2
  write('AI plays '),
  ai.

go :-
  show,
  turn(Player),
  write(Player), write(' here you go'), nl,
  read(X),
  call(X).

win :-
  finished,
  score(player1,X),
  score(player2,Y),
  win(X,Y).

win(X,Y) :-
  X > Y,
  write('Player1 wins! '),
  writef('score1=%w score2=%w',[X,Y]).

win(X,Y) :-
  Y > X,
  write('Player2 wins! '),
  writef('score1=%w score2=%w',[X,Y]).

win(X,Y) :-
  X == Y,
  write('It\' a draw! '),
  writef('score=%w',[X]).

unfinished :-
  field(X,Y,V), not(V == 15).

finished :-
  not(unfinished).

show :- show(0,0).

show(9,10) :- nl, true.

show(X,10) :- nl,
  Z is X+1,
  show(Z,0).

show(X,Y) :-
  field(X,Y,V),
  write(V),
  write(' '),
  Z is Y+1,
  show(X,Z).

ai :-
  field(X,Y,14),
  write(X),write(','),write(Y),write(',1'),nl,
  play(X,Y,1).

ai :-
  field(X,Y,13),
  write(X),write(','),write(Y),write(',2'),nl,
  play(X,Y,2).

ai :-
  field(X,Y,11),
  write(X),write(','),write(Y),write(',4'),nl,
  play(X,Y,4).

ai :-
  field(X,Y,7),
  write(X),write(','),write(Y),write(',8'),nl,
  play(X,Y,8).

ai :-
  field(X,Y,0),
  write(X),write(','),write(Y),write(',1'),nl,
  play(X,Y,1).

ai :-
  field(X,Y,1),
  write(X),write(','),write(Y),write(',2'),nl,
  play(X,Y,2).

ai :-
  field(X,Y,2),
  write(X),write(','),write(Y),write(',4'),nl,
  play(X,Y,4).

ai :-
  field(X,Y,4),
  write(X),write(','),write(Y),write(',8'),nl,
  play(X,Y,8).

ai :-
  field(X,Y,8),
  write(X),write(','),write(Y),write(',1'),nl,
  play(X,Y,1).

ai :-
  field(X,Y,3),
  write(X),write(','),write(Y),write(',4'),nl,
  play(X,Y,4).

ai :-
  field(X,Y,5),
  write(X),write(','),write(Y),write(',2'),nl,
  play(X,Y,2).

ai :-
  field(X,Y,6),
  write(X),write(','),write(Y),write(',1'),nl,
  play(X,Y,1).

ai :-
  field(X,Y,9),
  write(X),write(','),write(Y),write(',2'),nl,
  play(X,Y,2).

ai :-
  field(X,Y,10),
  write(X),write(','),write(Y),write(',1'),nl,
  play(X,Y,1).

ai :-
  field(X,Y,12),
  write(X),write(','),write(Y),write(',1'),nl,
  play(X,Y,1).

fill :- win.

fill :-
  field(X,Y,Z),
  not(Z == 15),
  retract(field(X,Y,Z)),
  assert(field(X,Y,15)),
  fill.

end_of_file :-
  write('Good bye!').
