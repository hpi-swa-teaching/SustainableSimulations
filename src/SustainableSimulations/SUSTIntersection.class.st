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
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:26'
}
SUSTIntersection >> getBlockedLanesFrom: aLane [ 

	| index | 
	index := lanes indexOf: aLane.
	(index \\ 2 = 1) ifTrue: [
		^ self getBlockedLanesWithFirstTurnFrom: aLane] 
	ifFalse: [
		^ self getBlockedLanesWithSecondTurnFrom: aLane].
	
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:44'
}
SUSTIntersection >> getBlockedLanesWithFirstTurnFrom: aLane [ 

	| index blockedLanes | 
	index := lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	index := index + 1 \\ 6 + 1.
	blockedLanes add: (lanes at: index).
	blockedLanes add: (lanes at: (index \\ 6 + 1)).
	blockedLanes add: (lanes at: (index + 1 \\ 6 +1)).
	^ blockedLanes
	
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:42'
}
SUSTIntersection >> getBlockedLanesWithSecondTurnFrom: aLane [ 

	| index blockedLanes | 
	index := lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes add: (lanes at: (index + 2 \\ 6 + 1)).
	^ blockedLanes
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:37'
}
SUSTIntersection >> isBlockedFrom: aLane [ 
	| blockedLanes index |
	index := lanes indexOf: aLane.
	blockedLanes := self getBlockedLanesFrom: aLane.
	blockedLanes
		do: [:each | each cars
				ifNotEmpty: [^ true]].
	index \\ 2 = 0
		ifTrue: [^ false].
	index = 3
		ifTrue: [(self
					searchForCarBackwardsFromLane: (lanes at: 5)
					WithMaxDist: 200)
				ifTrue: [^ true]].
	index \\ 4 = 1
		ifTrue: [(self
					searchForCarBackwardsFromLane: (lanes at: index + 1 \\ 6 + 1)
					WithMaxDist: 200)
				ifTrue: [^ true]].
	^ false
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:41'
}
SUSTIntersection >> shouldGiveRightOfWay [

	longStandingCars size >= 3
		ifTrue: [^ true].
	^ false.
]
