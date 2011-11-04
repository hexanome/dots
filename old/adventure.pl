location(egg, duck_pen). 
location(ducks, duck_pen). 
location(fox, woods). 
location(you, house). 
nextto(duck_pen, yard, closed). 
nextto(yard, house, open). 
nextto(yard, woods, open). 
connect(X, Y) :- nextto(X, Y, opened). 
connect(X, Y) :- nextto(Y, X, opened).


goto(X) :-
  location(you, L),
  connect(L, X),
  retract( location(you, L) ),
  assert( location(you, X) ),
  write(' You are in the '), write(X), nl.

you_have(nothing).

goto(X) :-
  write(' You can\'t get there from here. '), nl.

opengate(gate) :-
  assert( nextto(duck_pen, yard, opened ) ).

closegate(gate) :-
  retract( nextto(duck_pen, yard, _) ),
  assert( nextto(duck_pen, yard, closed) ).

chase(ducks) :-
  location(ducks, yard),
  location(you, yard),
  retract( location(ducks, yard) ),
  assert( location(ducks, duck_pen) ),
  write(' The ducks are back in their pen. '), nl.

chase(ducks) :-
  write(' No ducks here. '), nl.

take(X) :- 
  location(you, L), 
  retract( location(X, L) ), 
  assert( you_have(X) ), 
  write(' You now have the '), write(X), nl. 
take(X) :- 
  write(' There is no '), write(X), write(' here.'), nl. 

ducks :- 
  location(ducks, duck_pen), 
  location(you, duck_pen), 
  connect(duck_pen, yard), 
  retract( location(ducks, duck_pen) ), 
  assert( location(ducks, yard) ), 
  write(' The ducks have run into the yard. '), nl.
ducks. 
fox :- 
  location(ducks, yard), 
  location(you, house), 
  write(' The fox has taken a duck. '), nl. 
fox. 

go :- done. 
go :- 
  write('>> '), 
  read(X), 
  call(X), 
  ducks, 
  fox, 
  go. 
done :- 
  location(you, house), 
  you_have(egg), 
  write(' Thanks for getting the egg. '), nl.

