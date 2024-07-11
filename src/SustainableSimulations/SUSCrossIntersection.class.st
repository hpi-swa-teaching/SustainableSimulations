"
A SUSCrossIntersection is an intersection road in form of a cross.

Instance Variables

"
Class {
	#name : #SUSCrossIntersection,
	#superclass : #SUSAbstractIntersection,
	#category : #'SustainableSimulations-Roads',
	#'squeak_changestamp' : 'PM 7/11/2024 20:13'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:44'
}
SUSCrossIntersection >> connectionPointPositions [
	| positions directions |
	positions := {2 negated @ 2. 0 @ 4. 2 @ 2} * SUSDrawing normalLaneWidth.
	directions := {90. 0. 270}
				collect: [:each | from direction rotateBy: each degreesToRadians about: 0 @ 0].
	^ {from}, ((1 to: 3)
			collect: [:index | SUSDirectedPoint
				newWithPosition: (from absoluteOffset: (positions at: index))
				inDirection: (directions at: index)])
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSCrossIntersection >> createDrawing [
	^ SUSCrossIntersectionDrawing newFrom: from to: to position
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/11/2024 20:03'
}
SUSCrossIntersection >> createStrategy [
	^ SUSCrossIntersectionRightBeforeLeftStrategy newFromRoad: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:44'
}
SUSCrossIntersection >> getOppositeLaneFrom: aLane [ 
	| index |
	index := lanes indexOf: aLane.
	^ lanes at: index + 5 \\ 12 + 1
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:46'
}
SUSCrossIntersection >> getOppositeLanesFrom: aLane [ 
	| index |
	index := lanes indexOf: aLane.
	index := (index - 1 / 3) floor * 3 + 2.
	^ {lanes at: index + 4 \\ 12 + 1. lanes at: index + 5 \\ 12 + 1. lanes at: index + 6 \\ 12 + 1} asOrderedCollection
]

{
	#category : #'right of way',
	#'squeak_changestamp' : 'PM 7/11/2024 18:45'
}
SUSCrossIntersection >> isBlockedFrom: aLane [ 
	^ strategy isBlockedFrom: aLane
]
