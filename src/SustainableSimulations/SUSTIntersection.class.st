Class {
	#name : #SUSTIntersection,
	#superclass : #SUSIntersection,
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:05'
}
SUSTIntersection >> connectionPointPositions [
	| positions directions |
	positions := {2 negated @ 2. 2 @ 2} * SUSDrawing normalLaneWidth.
	directions := {90. 270}
				collect: [:each | from direction rotateBy: each degreesToRadians about: 0 @ 0].
	^ {from}, ((1 to: 2)
		collect: [:index | SUSDirectedPoint
				newWithPosition: (from absoluteOffset: (positions at: index))
				inDirection: (directions at: index)]).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:05'
}
SUSTIntersection >> createDrawing [
	| drawing |
	drawing := SUSTIntersectionDrawing newFrom: from to: to position.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].
	
	self extent: drawing extent; 
		position: drawing position.
	^ drawing
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:47'
}
SUSTIntersection >> getOppositeLanesFrom: aLane [
	self flag: #Todo. "Anpassen auf T-Section"
	^ {}.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:47'
}
SUSTIntersection >> getRightTurnLanesFrom: aLane [ 
	self flag: #Todo. "Anpassen auf T-Section"
	^ {}
]
