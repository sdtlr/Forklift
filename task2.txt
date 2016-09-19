(define (domain Depot)
(:requirements :strips :typing :action-costs :adl)

;Declares the types that are to be used by PDDL.
(:types place - object
        inbay - place
        shelf - place
        outbay - place
        parking - place
        unfixed - object
        forklift - unfixed
        pallet - unfixed
)

;Declares the predicates
;The at predicate allows any unfixed objects, the forklift or pallet, to be located at any place.
;The connected predicate allows two places to be connected.
;The available predicate allows the program to know wether the forklift currently has a pallet loaded.
;The clear predicate applies to a place, if initailised as clear there is no pallet in said place.
;The carry predicate is applied when a pallet is pickup up by a forklift, allows identification of pallet and forklift.
(:predicates (at ?x - unfixed ?y - place)
             (connected ?x - place ?y - place)
             (available ?x - forklift)
             (clear ?x - place)
             (carry ?x - forklift ?y - pallet)
)

;Parameters: x is a place that the forklift must travel from, y is where the forklift must travel to.
;The preconditions check that the two places are connected and that the forklift is at the starting place.
;The effect uses the at predicate and changes the location of the forklift from x to y.
(:action drive
  :parameters (?x - place ?y - place ?f - forklift)       
  :precondition (and (or(connected ?x ?y)(connected ?y ?x)) (at ?f ?x))      
  :effect (and (at ?f ?y)
          (not (at ?f ?x))))
  
;Parameters: f is a forklift that will be used to pick up the pallet, p is the pallet and pos is the place that the palet is located.
;The preconditions check that the forklift is at the position (where the pallet is located), the pallet is at the position specified and that the forklift is available.
;The effect uses the clear predicate to set the position to clear, and uses the carry predicate to indicate that the pallet is not being carried by the forklift (f).
(:action pickup   
  :parameters (?f - forklift ?p - pallet ?pos - place)    
  :precondition (and (at ?f ?pos) (at ?p ?pos) (available ?f))  
  :effect (and (clear ?pos) (carry ?f ?p)
	       	(not (at ?p ?pos))
          (not (available ?f))))
         
;Parameters: f is a forklift that will be carrying the pallet, p is the pallet and pos is the place that the palet needs to be placed.
;The preconditions check that the forklift is carrying the pallet, the forklift is at the position specified and that the position is clear.
;The effect uses the at predicate to set the position of the pallet to the desired position, and uses the available predicate to indicate that the forklift has put down the pallet and is now free, finally is sets the position to NOT clear.
(:action setdown
  :parameters (?f - forklift ?p - pallet ?pos - place) 
  :precondition (and (carry ?f ?p) (at ?f ?pos) (clear ?pos))
  :effect (and (at ?p ?pos) (available ?f)
               (not (carry ?f ?p))
               (not (clear ?pos))))
)