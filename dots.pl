go :- done.
go :-
  write(">> "), 
  read(X), 
  call(X), 
  ducks, 
  fox, 
  go. 
done :- 
  location(you, house), 
  you_have(egg), 
  write("Thanks for getting the egg."), nl. 
