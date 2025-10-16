CHESS


This was the most challenging project to date on my journey to learning Ruby.

Simply holding all of the functionality within a mental model while adding
to the codebase was far more challenging than previous projects - there 
were just so many moving parts!

Without OOP, it seems that the process of modifying and adding functionality 
to the program would have been absolutely excruciating. 

After building 'tic-tac-toe', 'connect-four' and working through some of the logic
of 'knights-travails', the logic of moving the chess pieces and checking for 
a CHECK scenario or a win was relatively simple if time-consuming.

Distributing pieces to players and squares to the board was also very basic,
the only challenge being when I decided to change the way I had classes
and their objects stored(I let the Player class objects live as instance variables 
within the Board class to make calling certain functions a little bit simpler).

Another change I made was adding another instance variable to the Board class
that would store pointers to Square objects in a hash of 'x, y' coordinates.
This allowed me to check the board and update available moves much more easily
as I could simply scan each piece's potential move radius by adding predetermined
values to its current coordinates(impossible with String and Integer identifiers).
I kept an alternate hash for squares, where they were identified by their classic
chess positions(C4, A5, D8, etc...) for a more intuitive user experience but calculated
movement 'under the hood' using the 'x, y' hash of squares.

It had been awhile since I had implemented serialization within any of my projects,
so it proved challenging to figure the least amount of data needed to restore a 
previous game session. I had to add a 'TURN' variable to my Player class in order
to mainting proper playing order when restoring a previous session.

Other than all of that, two-player chess was not very difficult to write.
My biggest take-away from this project was primarily to do my best to organize
my code in Modules and Classes with proper instance variables. I already know
I could write the same program in less lines and more modularly than I have
done here. If I was a bigger fan of chess, AI would have been a great thing
to implement as well - I'm too excited to move on to SQL and Rails to mess
around with that however!

Enjoy the spaghetti!
