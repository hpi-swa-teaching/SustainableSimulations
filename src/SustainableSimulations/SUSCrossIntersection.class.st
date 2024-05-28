Class {
	#name : #SUSCrossIntersection,
	#superclass : #SUSAbstractRoad,
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 5/28/2024 01:43'
}
SUSCrossIntersection class >> newOnSimulation: aSimulation [
	^ self new simulation: aSimulation;
		postInitialization;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:44'
}
SUSCrossIntersection >> createConnectionPoints [
	| positions directions |
	positions := {0 @ 0.5. 0.5 @ 0. 1 @ 0.5. 0.5 @ 1}.
	directions := {-1 @ 0. 0 @ 1. 1 @ 0. 0 @ -1}.
	^ (1 to: 4)
		collect: [:index | (SUSConnectionPoint
				newForRoad: self
				withDirection: (directions at: index))
				center: (self extent * positions at: index);
				 yourself]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:31'
}
SUSCrossIntersection >> createDrawing [
	| drawing |
	drawing := SUSDrawing newCrossIntersetion.
	self extent: drawing extent.
	^ drawing
]
