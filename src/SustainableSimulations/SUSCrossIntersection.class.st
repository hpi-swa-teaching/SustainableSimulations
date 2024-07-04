Class {
	#name : #SUSCrossIntersection,
	#superclass : #SUSIntersection,
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 15:32'
}
SUSCrossIntersection >> connectionPointPositions [
	| positions directions |
	positions := {2 negated @ 2. 0 @ 4. 2 @ 2} * SUSDrawing normalLaneWidth.
	directions := {90. 0. 270}
				collect: [:each | from direction rotateBy: each degreesToRadians about: 0 @ 0].
	^ {from}, ((1 to: 3)
		collect: [:index | SUSDirectedPoint
				newWithPosition: (from absoluteOffset: (positions at: index))
				inDirection: (directions at: index)]).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSCrossIntersection >> createDrawing [
	^ SUSCrossIntersectionDrawing newFrom: from to: to position
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 7/3/2024 08:30'
}
SUSCrossIntersection >> createStrategy [

	^ (SUSCrossIntersectionRightBeforeLeftStrategy newFromRoad: self)
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:02'
}
SUSCrossIntersection >> getOppositeLaneFrom: aLane [
	| index |
	index := lanes indexOf: aLane.
	^ lanes at: (index + 5 \\ 12 + 1).
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 14:00'
}
SUSCrossIntersection >> getOppositeLanesFrom: aLane [
	| index laneCollection|
	index := lanes indexOf: aLane.
	index := ((index - 1 / 3) floor ) * 3 + 2.
	laneCollection := OrderedCollection new.
	laneCollection add: (lanes at: (index + 4 \\ 12 + 1)).
	laneCollection add: (lanes at: (index + 5 \\ 12 + 1)).
	laneCollection add: (lanes at: (index + 6 \\ 12 + 1)).
	^ laneCollection
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 10:51'
}
SUSCrossIntersection >> isBlockedFrom: aLane [ 
	^ (strategy isBlockedFrom: aLane)
]
