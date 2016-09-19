/* The isa function takes two parameters, the first links to the second in the semantic network. */
isa(canary,bird).
isa(ostritch,bird).
isa(bird,animal).
isa(fish,animal).
isa(tweety,canary).

/* The hasprop function takes three parameters, the first is the object, the second is the property that object will have and the thrid is the value of that property. */
hasprop(tweety,colour,orange).
hasprop(canary,colour,yellow).
hasprop(ostrich,movement,walk).
hasprop(bird,movement,fly).
hasprop(bird,cover,feathers).
hasprop(fish,cover,scales).
hasprop(fish,movement,swim).
hasprop(animal,cover,skin).

/* The property_query function takes three parameters, the object, the property and the value of that property. 
The function then runs these values through the hasprop query, if true is returned the object has the queried properties. */
property_query(X,Y,Z):-
hasprop(X,Y,Z).
/* If the above function does not reutrn true, then the values are run through this function.
The object is run into an isa query, if there is a link between the object and any other node then that node is run through the propety_query along with the unchanged porperty and value.
 */
property_query(X,Y,Z):-
isa(X,R),
property_query(R,Y,Z).

