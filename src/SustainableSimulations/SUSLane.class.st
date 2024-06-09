Class {
	#name : #SUSLane,
	#superclass : #Object,
	#instVars : [
		'cars',
		'nextLanes',
		'path',
		'length',
		'blocked'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:58'
}
SUSLane class >> newLaneWithPath: aLineMorph [

	^SUSLane new path: aLineMorph;
		calculateLength;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 19:11'
}
SUSLane >> addCar: aCar [

	cars add: aCar
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 21:09'
}
SUSLane >> addNextLane: aNextLane [

	nextLanes addLast: aNextLane
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 00:21'
}
SUSLane >> blocked [
	^ blocked
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 00:21'
}
SUSLane >> blocked: aTupel [
	blocked := aTupel
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:56'
}
SUSLane >> calculateLength [
	| p1 p2 |
	p1 := path vertices first.
	p2 := path vertices last.
	
	length := ((p1 x - p2 x) squared + (p1 y - p2 y) squared) sqrt
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/9/2024 20:07'
}
SUSLane >> getPosition2VerticesWithTValue: aNumber [
	| p1 p2 |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: path vertices last.
	
	^ ((1 - aNumber) * p1) + (aNumber * p2)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/9/2024 20:06'
}
SUSLane >> getPosition3VerticesWithTValue: aNumber [
	| p1 p2 p3 |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: (path vertices at: 2).
	p3 := path pointInWorld: path vertices last.
	
	^ ((1 - aNumber) * (1 - aNumber) * p1) + (2 * (1 - aNumber) * aNumber * p2) + (aNumber * aNumber * p3)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/9/2024 20:10'
}
SUSLane >> getPositionWithTValue: aNumber [
	((path vertices size) == 3) ifTrue: [^ self getPosition3VerticesWithTValue: aNumber].
	^ self getPosition2VerticesWithTValue: aNumber
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 00:08'
}
SUSLane >> getPreviousCarOnLane: aCar [
	| previous |
	previous := aCar.
	cars do: [:each |
		aCar = each ifTrue: [^ previous].
		previous := each].
	^ aCar
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/9/2024 21:05'
}
SUSLane >> getRotation2VerticesWithTValue: aNumber [
	| p1 p2 p3 dx dy |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: (path vertices at: 2).
	p3 := path pointInWorld: path vertices last.
	
	dx := (p2 x - p1 x).
	dy := (p2 y - p1 y).
	
	dx = 0 ifTrue: [^ -90].
	^ (dy / dx) arcTan radiansToDegrees
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/9/2024 21:05'
}
SUSLane >> getRotation3VerticesWithTValue: aNumber [
	| p1 p2 p3 dx dy |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: (path vertices at: 2).
	p3 := path pointInWorld: path vertices last.
	
	dx := (p2 x - p1 x) * 2 * (1 - aNumber) + (p3 x - p2 x) * 2 * aNumber.
	dy := (p2 y - p1 y) * 2 * (1 - aNumber) + (p3 y - p2 y) * 2 * aNumber.
	
	dx = 0 ifTrue: [^ -90].
	^ (dy / dx) arcTan radiansToDegrees
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/9/2024 20:31'
}
SUSLane >> getRotationWithTValue: aNumber [
	((path vertices size) == 3) ifTrue: [^ self getRotation3VerticesWithTValue: aNumber].
	^ self getRotation2VerticesWithTValue: aNumber
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:58'
}
SUSLane >> initialize [

	cars := OrderedCollection new.
	nextLanes := OrderedCollection new
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:55'
}
SUSLane >> length [
	^ length
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 21:19'
}
SUSLane >> nextLanes [
	^ nextLanes
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 19:27'
}
SUSLane >> path: aLineMorph [
	
	path := aLineMorph
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 00:11'
}
SUSLane >> removeCar: aCar [

	cars remove: aCar
]
