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
	#'squeak_changestamp' : 'Len 6/25/2024 10:40'
}
SUSCrossIntersection >> createDrawing [
	| drawing |
	drawing := SUSCrossIntersectionDrawing newFrom: from to: to position.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].
	
	self extent: drawing extent; 
		position: drawing position.
	^ drawing
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 11:22'
}
SUSCrossIntersection >> createStrategy [

	^ (SUSCrossIntersectionRightOfWayStrategy newFromRoad: self)
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 11:41'
}
SUSCrossIntersection >> getBlockedLanesFrom: aLane [ 
	| index |
	index := lanes indexOf: aLane.
	index := index - 1 \\ 3 + 1.
	index = 1
		ifTrue: [^ self getBlockedLanesWithLeftTurnFrom: aLane].
	index = 2
		ifTrue: [^ self getBlockedLanesWithNoTurnFrom: aLane].
	index = 3
		ifTrue: [^ self getBlockedLanesWithRightTurnFrom: aLane]
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 11:41'
}
SUSCrossIntersection >> getBlockedLanesWithLeftTurnFrom: aLane [ 
	| index blockedLanes |
	index := lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (lanes at: index + 2 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 3 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 5 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 6 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 7 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 8 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 9 \\ 12 + 1).
	^ blockedLanes
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 11:41'
}
SUSCrossIntersection >> getBlockedLanesWithNoTurnFrom: aLane [ 
	| index blockedLanes |
	index := lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (lanes at: index + 1 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 2 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 3 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 4 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 7 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 8 \\ 12 + 1).
	^ blockedLanes
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 11:41'
}
SUSCrossIntersection >> getBlockedLanesWithRightTurnFrom: aLane [ 
	| index blockedLanes |
	index := lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (lanes at: index + 3 \\ 12 + 1).
	blockedLanes
		add: (lanes at: index + 7 \\ 12 + 1).
	^ blockedLanes
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

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 14:00'
}
SUSCrossIntersection >> shouldGiveRightOfWay [
	"check for two left turners"
	longStandingCars size = 2
		ifTrue: [| car1 car2 |
			car1 := longStandingCars asOrderedCollection at: 1.
			car2 := longStandingCars asOrderedCollection at: 2.
			(car1 route first = 1
					and: car2 route first = 1
					and: ((self getOppositeLanesFrom: car1 lane nextLanes first)
							includes: car2 lane nextLanes first))
				ifTrue: [^ true]].
	"check for remaining edgecases"
	longStandingCars size >= 3
		ifTrue: [^ true].
	^ false.
]
