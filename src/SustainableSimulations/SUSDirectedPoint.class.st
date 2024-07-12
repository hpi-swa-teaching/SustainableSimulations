"
A SUSDirectedPoint is a line in 2d space identified by a postion and a direction vector, which provieds different linear algebra calculations.

Instance Variables
	direction:		Point
	position:		Point

direction
	- Direction vector of the 2d line

position
	- Position of the 2d line

"
Class {
	#name : #SUSDirectedPoint,
	#superclass : #Object,
	#instVars : [
		'position',
		'direction'
	],
	#category : #'SustainableSimulations-Core',
	#'squeak_changestamp' : 'PM 7/10/2024 13:22'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 7/10/2024 13:43'
}
SUSDirectedPoint class >> newWithPosition: aPoint inDirection: anotherPoint [ 
	^ self new position: aPoint;
		 direction: anotherPoint;
		 yourself
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/10/2024 13:24'
}
SUSDirectedPoint >> absoluteOffset: aPoint [ 
	^ self position
		+ (self relativeOffset: aPoint)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 10:14'
}
SUSDirectedPoint >> basicType [
	^ #SUSDirectedPoint
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/10/2024 13:33'
}
SUSDirectedPoint >> calculateIntersectionPoint: aLine [ 
	| x1 y1 x2 y2 dx dy crossProduct t |
	x1 := self position x.
	y1 := self position y.
	x2 := aLine position x.
	y2 := aLine position y.
	dx := aLine direction x.
	dy := aLine direction y.
	crossProduct := self direction crossProduct: aLine direction.
	crossProduct == 0
		ifTrue: [self error: 'Lines are parallel to each other'].
	t := x2 - x1 * dy - (y2 - y1 * dx) / crossProduct.
	^ self direction * t + self position
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 02:09'
}
SUSDirectedPoint >> direction [
	^ direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 6/15/2024 13:35'
}
SUSDirectedPoint >> direction: anObject [ 
	direction := anObject 
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/10/2024 13:35'
}
SUSDirectedPoint >> directionLineA [
	^ SUSDirectedPoint
		newWithPosition: position
		inDirection: (direction rotateBy: 45 degreesToRadians about: 0 @ 0)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/10/2024 13:35'
}
SUSDirectedPoint >> directionLineB [
	^ SUSDirectedPoint
		newWithPosition: position
		inDirection: (direction rotateBy: 315 degreesToRadians about: 0 @ 0)
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/10/2024 13:36'
}
SUSDirectedPoint >> directionOf: aPoint [ 
	(self directionLineA isAbove: aPoint) >= 0
		ifTrue: [(self directionLineB isAbove: aPoint) >= 0
				ifTrue: [^ #Right]
				ifFalse: [^ #Top]]
		ifFalse: [(self directionLineB isAbove: aPoint) >= 0
				ifTrue: [^ #Bottom]
				ifFalse: [^ #Left]]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 23:40'
}
SUSDirectedPoint >> initialize [
	direction := 0@0.
	position := 0@0
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/10/2024 13:36'
}
SUSDirectedPoint >> isAbove: aPoint [ 
	"> 0 aPoint is above line, = 0 aPoint is on
	line, < 0 aPoint is below line"
	^ direction crossProduct: aPoint - position
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/10/2024 13:38'
}
SUSDirectedPoint >> isBehind: aPoint [ 
	"<0: nach Positon; = 0 genau auf Linie mit
	Positon; > 0: vor Position"
	0 @ 0 == direction
		ifTrue: [^ 0].
	^ aPoint - position dotProduct: direction
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/10/2024 13:37'
}
SUSDirectedPoint >> linearDist: aPoint [ 
	^ self position
		dist: (self projectionOf: aPoint)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:27'
}
SUSDirectedPoint >> position [
	^ position
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:27'
}
SUSDirectedPoint >> position: anObject [
	position := anObject
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/11/2024 15:42'
}
SUSDirectedPoint >> projectionOf: aPoint [ 
	0 @ 0 = direction
		ifTrue: [^ aPoint].
	^ aPoint nearestPointAlongLineFrom: self position to: self position + direction
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'PM 7/10/2024 13:39'
}
SUSDirectedPoint >> relativeOffset: aPoint [ 
	| rotatedDirection |
	rotatedDirection := (direction rotateBy: 270 degreesToRadians about: 0 @ 0) normalized.
	^ (rotatedDirection * aPoint x + (direction normalized * aPoint y)) rounded
]
