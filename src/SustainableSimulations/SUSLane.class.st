"
A SUSLane is a bezier curve on which a vehicle can drive.

Instance Variables
	shouldRemoveVehicles	Boolean
	length:						Number
	nextLanes:					OrderedCollection{SUSLane}
	path:						CurveMorph
	previousLanes:			OrderedCollection{SUSLane}
	road:						SUSAbstractRoad
	vehicles:					OrderedCollection{SUSVehicle}

shouldRemoveVehicles:
	- Whether this lane should remove vehicles as they drive on it.

length
	- Length of this lane

nextLanes
	- The following SUSLanes

path
	- The Curve which is the model for this bezier curve.

previousLanes
	- The previous SUSLanes

road
	- The SUSAbstractRoad which this lane belongs to

vehicles
	- The vehicles which currently drive on this lane

"
Class {
	#name : #SUSLane,
	#superclass : #Object,
	#instVars : [
		'nextLanes',
		'previousLanes',
		'path',
		'length',
		'road',
		'vehicles',
		'shouldRemoveVehicles'
	],
	#category : #'SustainableSimulations-Roads',
	#'squeak_changestamp' : 'PM 7/11/2024 19:29'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 7/11/2024 17:33'
}
SUSLane class >> newLaneWithPath: aLineMorph [ 
	^ SUSLane new path: aLineMorph;
		 calculateLength;
		 yourself
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 7/11/2024 17:33'
}
SUSLane class >> newLaneWithPath: aLineMorph OnRoad: aRoad [ 
	^ SUSLane new path: aLineMorph;
		 road: aRoad;
		 calculateLength;
		 yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 17:32'
}
SUSLane >> addNextLane: aNextLane [
	nextLanes addLast: aNextLane
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 17:32'
}
SUSLane >> addPreviousLane: aPreviousLane [
	previousLanes addLast: aPreviousLane
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 19:30'
}
SUSLane >> addVehicle: aVehicle [
	shouldRemoveVehicles
		ifTrue: [aVehicle remove]
		ifFalse: [vehicles add: aVehicle]
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:32'
}
SUSLane >> calculateLength [
	path vertices size == 3
		ifTrue: [self calculateLength3Vertices]
		ifFalse: [self calculateLength2Vertices]
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:32'
}
SUSLane >> calculateLength2Vertices [
	| p1 p2 |
	p1 := path vertices first.
	p2 := path vertices last.
	length := ((p1 x - p2 x) squared + (p1 y - p2 y) squared) sqrt
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:32'
}
SUSLane >> calculateLength3Vertices [
	| n sum |
	n := 100.
	sum := 0.
	1 to: n do: [:i | 
		| point1 point2 segmentLength |
		point1 := self getPosition3VerticesWithTValue: i - 1 / n.
		point2 := self getPosition3VerticesWithTValue: i / n.
		segmentLength := point1 dist: point2.
		sum := sum + segmentLength].
	length := sum
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:31'
}
SUSLane >> getLengthToT3: t [ 
	| A B C v1 v2 |
	A := path pointInWorld: path vertices first.
	B := path pointInWorld: (path vertices at: 2).
	C := path pointInWorld: path vertices last.
	v1 := 2 * A - (4 * B) + (2 * C).
	v2 := (2 * A) negated + (2 * B).
	^ t * v2 r
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:31'
}
SUSLane >> getLengthToT: t [ 
	path vertices size == 3
		ifTrue: [^ self getLengthToT3: t].
	^ t * length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 17:31'
}
SUSLane >> getNextCarOnLane: aCar [ 
	| next |
	next := false.
	vehicles
		do: [:each | 
			next
				ifTrue: [^ each].
			aCar = each
				ifTrue: [next := true]].
	^ aCar
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:31'
}
SUSLane >> getPosition2VerticesWithTValue: aNumber [ 
	| p1 p2 |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: path vertices last.
	^ 1 - aNumber * p1 + (aNumber * p2)
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:30'
}
SUSLane >> getPosition3VerticesWithTValue: aNumber [ 
	| p1 p2 p3 |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: (path vertices at: 2).
	p3 := path pointInWorld: path vertices last.
	^ 1 - aNumber * (1 - aNumber) * p1 + (2 * (1 - aNumber) * aNumber * p2) + (aNumber * aNumber * p3)
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:30'
}
SUSLane >> getPositionWithTValue: aNumber [ 
	path vertices size == 3
		ifTrue: [^ self getPosition3VerticesWithTValue: aNumber].
	^ self getPosition2VerticesWithTValue: aNumber
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:30'
}
SUSLane >> getPreviousCarOnLane: aCar [ 
	| previous |
	previous := aCar.
	vehicles
		do: [:each | 
			aCar = each
				ifTrue: [^ previous].
			previous := each].
	^ aCar
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:30'
}
SUSLane >> getRotation2VerticesWithTValue: aNumber [ 
	| p1 p2 dx dy |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: path vertices last.
	dx := p2 x - p1 x.
	dy := p2 y - p1 y.
	dx = 0
		ifTrue: [dy > 0
				ifTrue: [^ {1. 90}]
				ifFalse: [dy < 0
						ifTrue: [^ {1. -90}]
						ifFalse: [^ {0. -90}]]].
	dx < 0
		ifTrue: [^ {1. (dy / dx) arcTan radiansToDegrees + 180}].
	^ {1. (dy / dx) arcTan radiansToDegrees}
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:30'
}
SUSLane >> getRotation3VerticesWithTValue: aNumber [ 
	| p1 p2 p3 dx dy t flip |
	p1 := path pointInWorld: path vertices first.
	p2 := path pointInWorld: (path vertices at: 2).
	p3 := path pointInWorld: path vertices last.
	flip := 0.
	aNumber >= 0.5
		ifTrue: [dx := p2 x - p1 x * 2 * (1 - aNumber) + (p3 x - p2 x) * 2 * aNumber.
			dy := p2 y - p1 y * 2 * (1 - aNumber) + (p3 y - p2 y) * 2 * aNumber]
		ifFalse: [t := 1 - aNumber.
			flip := 180.
			dx := p2 x - p3 x * 2 * (1 - t) + (p1 x - p2 x) * 2 * t.
			dy := p2 y - p3 y * 2 * (1 - t) + (p1 y - p2 y) * 2 * t].
	dx = 0
		ifTrue: [dy > 0
				ifTrue: [^ {1. 90}]
				ifFalse: [dy < 0
						ifTrue: [^ {1. -90}]
						ifFalse: [^ {0. -90}]]].
	dx < 0
		ifTrue: [^ {1. (dy / dx) arcTan radiansToDegrees + 180 + flip}].
	^ {1. (dy / dx) arcTan radiansToDegrees + flip}
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 17:30'
}
SUSLane >> getRotationWithTValue: aNumber [ 
	path vertices size == 3
		ifTrue: [^ self getRotation3VerticesWithTValue: aNumber].
	^ self getRotation2VerticesWithTValue: aNumber
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'PM 7/11/2024 19:30'
}
SUSLane >> initialize [
	vehicles := OrderedCollection new.
	nextLanes := OrderedCollection new.
	previousLanes := OrderedCollection new.
	shouldRemoveVehicles := false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 6/23/2024 01:58'
}
SUSLane >> length [
	^ length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 21:19'
}
SUSLane >> nextLanes [
	^ nextLanes
]

{
	#category : #calculation,
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
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 16:40'
}
SUSLane >> nextTprev: t advanceByLength: L [ 
	path vertices size == 3
		ifTrue: [^ self nextT3prev: t advanceByLength: L].
	^ t + (L / length)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 16:40'
}
SUSLane >> path [ 
	^ path
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 16:40'
}
SUSLane >> path: aLineMorph [
	path := aLineMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 08:50'
}
SUSLane >> previousLanes [
	^ previousLanes
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:30'
}
SUSLane >> removeVehicle: aVehicle [
	vehicles remove: aVehicle
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:23'
}
SUSLane >> road [
	^ road
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:23'
}
SUSLane >> road: anObject [
	road := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 19:30'
}
SUSLane >> shouldRemoveVehicles: aBoolean [
	shouldRemoveVehicles := aBoolean
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:28'
}
SUSLane >> vehicles [
	^ vehicles
]
