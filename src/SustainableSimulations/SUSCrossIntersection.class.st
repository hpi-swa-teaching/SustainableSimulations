Class {
	#name : #SUSCrossIntersection,
	#superclass : #SUSAbstractRoad,
	#category : #SustainableSimulations
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:03'
}
SUSCrossIntersection >> createConnectionPoints [
	| positions directions |
	positions := {0 @ 0.5. 0.5 @ 0. 1 @ 0.5. 0.5 @ 1}.
	directions := {-1 @ 0. 0 @ -1. 1 @ 0. 0 @ 1}.
	^ (1 to: 4)
		collect: [:index | (SUSConnectionPoint
				newForRoad: self
				withDirection: (directions at: index))
				center: (self extent * positions at: index);
				 yourself]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 21:35'
}
SUSCrossIntersection >> createDrawing [
	| drawing |
	drawing := SUSDrawing newCrossIntersetion.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].
	
	self extent: drawing extent.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:58'
}
SUSCrossIntersection >> from: aDirectedPoint to: aPoint [
	"Do nothing, as cross intersections have a fixed size"
]
