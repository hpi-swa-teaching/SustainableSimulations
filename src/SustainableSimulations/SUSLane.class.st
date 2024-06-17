Class {
	#name : #SUSLane,
	#superclass : #Object,
	#instVars : [
		'cars',
		'nextLanes',
		'path',
		'length',
		'blockedT'
	],
	#category : #'SustainableSimulations-Roads'
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
	#'squeak_changestamp' : 'Len 6/16/2024 19:12'
}
SUSLane >> TESTgetRotation3VerticesWithTValue: aNumber [
	| p1 p2 p3 dx dy |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: (path vertices at: 2).
	p3 := path pointInWorld: path vertices last.
	
	dx := (p2 x - p1 x) * 2 * (1 - aNumber) + (p3 x - p2 x) * 2 * aNumber.
	dy := (p2 y - p1 y) * 2 * (1 - aNumber) + (p3 y - p2 y) * 2 * aNumber.
	
	dx = 0 ifTrue: [
		dy > 0 ifTrue: [^ {1. 90}] ifFalse: [dy < 0 ifTrue: [^ {1. -90}] ifFalse: [^ {0. -90}]]].
	dx < 0 ifTrue: [^ {1. (dy / dx) arcTan radiansToDegrees + 180}].
	^ {1. (dy / dx) arcTan radiansToDegrees}
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
	#'squeak_changestamp' : 'Len 6/10/2024 01:10'
}
SUSLane >> blockedT [
	^ blockedT
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 19:01'
}
SUSLane >> calculateLength [
	((path vertices size) == 3) 
		ifTrue: [self calculateLength3Vertices]
		ifFalse: [self calculateLength2Vertices]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 18:56'
}
SUSLane >> calculateLength2Vertices [
	| p1 p2 |
	p1 := path vertices first.
	p2 := path vertices last.
	
	length := (((p1 x - p2 x) squared) + ((p1 y - p2 y)) squared) sqrt
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 19:00'
}
SUSLane >> calculateLength3Vertices [
	| n sum |
	n := 100.
	sum := 0.

	1 to: n do: [:i | 
		| point1 point2 segmentLength |
		point1 := self getPosition3VerticesWithTValue: (i - 1) / n.
		point2 := self getPosition3VerticesWithTValue: i / n.
		segmentLength := point1 dist: point2.
		sum := sum + segmentLength].
	length := sum



]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/15/2024 09:53'
}
SUSLane >> cars [
	^ cars
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/15/2024 09:53'
}
SUSLane >> cars: anObject [
	cars := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:28'
}
SUSLane >> getNextCarOnLane: aCar [
	| next |
	next := false.
	cars do: [:each |
		next ifTrue: [^ each].
		aCar = each ifTrue: [next := true].
		].
	^ aCar
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
	#'squeak_changestamp' : 'Len 6/10/2024 10:36'
}
SUSLane >> getRotation2VerticesWithTValue: aNumber [
	| p1 p2 dx dy |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: path vertices last.
	
	dx := (p2 x - p1 x).
	dy := (p2 y - p1 y).
	
	dx = 0 ifTrue: [
		dy > 0 ifTrue: [^ {1. 90}] ifFalse: [dy < 0 ifTrue: [^ {1. -90}] ifFalse: [^ {0. -90}]]].
	dx < 0 ifTrue: [^ {1. (dy / dx) arcTan radiansToDegrees + 180}].
	^ {1. (dy / dx) arcTan radiansToDegrees}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 19:17'
}
SUSLane >> getRotation3VerticesWithTValue: aNumber [
	| p1 p2 p3 dx dy t flip |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: (path vertices at: 2).
	p3 := path pointInWorld: path vertices last.
	flip := 0.
	
	(aNumber >= 0.5)
		ifTrue: [
			dx := (p2 x - p1 x) * 2 * (1 - aNumber) + (p3 x - p2 x) * 2 * aNumber.
			dy := (p2 y - p1 y) * 2 * (1 - aNumber) + (p3 y - p2 y) * 2 * aNumber]
		ifFalse: [
			t := 1 - aNumber.
			flip  := 180.
			dx := (p2 x - p3 x) * 2 * (1 - t) + (p1 x - p2 x) * 2 * t.
			dy := (p2 y - p3 y) * 2 * (1 - t) + (p1 y - p2 y) * 2 * t].
	
	dx = 0 ifTrue: [
		dy > 0 ifTrue: [^ {1. 90}] ifFalse: [dy < 0 ifTrue: [^ {1. -90}] ifFalse: [^ {0. -90}]]].
	dx < 0 ifTrue: [^ {1. (dy / dx) arcTan radiansToDegrees + 180 + flip}].
	^ {1. (dy / dx) arcTan radiansToDegrees + flip}
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
	#'squeak_changestamp' : 'Len 6/10/2024 01:12'
}
SUSLane >> initialize [

	cars := OrderedCollection new.
	nextLanes := OrderedCollection new.
	blockedT := 1
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
	#'squeak_changestamp' : 'PM 6/15/2024 22:43'
}
SUSLane >> nextT3prev: t advanceByLength: L [
	"See https://gamedev.stackexchange.com/questions/27056/how-to-achieve-uniform-speed-of-movement-on-a-bezier-curve"
	| A B C v1 v2 |
	A := path pointInWorld: path vertices first.
	B := path pointInWorld: (path vertices at: 2).
	C := path pointInWorld: path vertices last.
	v1 := (2 * A) - (4 * B) + (2 * C).
	v2 := (2 * A) negated + (2 * B).
	^ t + (L / ((t * v1 + v2) r))
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 22:48'
}
SUSLane >> nextTprev: t advanceByLength: L [
	((path vertices size) == 3) ifTrue: [^ self nextT3prev: t advanceByLength: L].
	^ t + (L / length)
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

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 01:10'
}
SUSLane >> updateBlocked: aNumber [
	blockedT := (length -  aNumber) / length
]
