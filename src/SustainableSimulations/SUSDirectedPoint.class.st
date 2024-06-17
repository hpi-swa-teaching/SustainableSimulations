Class {
	#name : #SUSDirectedPoint,
	#superclass : #Object,
	#instVars : [
		'position',
		'direction'
	],
	#category : #'SustainableSimulations-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/11/2024 02:09'
}
SUSDirectedPoint class >> newWithPosition: aPoint inDirection: anotherPoint [
	^ self new position: aPoint;
		direction: anotherPoint;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:05'
}
SUSDirectedPoint >> absoluteOffset: aPoint [
	^ (self relativeOffset: aPoint)+ self position
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 14:41'
}
SUSDirectedPoint >> calculateIntersectionPoint: aLine [
	| x1 y1 x2 y2 dx1 dy1 dx2 dy2 denominator t1 t2 |
        
        "Get coordinates and direction vectors"
        x1 := self position x.
        y1 := self position y.
        x2 := aLine position x.
        y2 := aLine position y.
        dx1 := self direction x.
        dy1 := self direction y.
        dx2 := aLine direction x.
        dy2 := aLine direction y.
        
 	denominator := (dx1 * dy2) - (dy1 * dx2).
	denominator == 0 ifTrue: [ self error: 'Lines are parallel to each other' ].
	t1 := (((x2 - x1) * dy2) - ((y2 - y1) * dx2)) / denominator.
	t2 := (((x2 - x1) * dy1) - ((y2 - y1) * dx1)) / denominator.
   	^ (x1 + (t1 * dx1))@(y1 + (t1 * dy1))
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
	#'squeak_changestamp' : 'PM 6/12/2024 23:40'
}
SUSDirectedPoint >> initialize [
	direction := 0@0.
	position := 0@0
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 6/15/2024 16:45'
}
SUSDirectedPoint >> isPointBehind: aPoint [
	| x1 y1 x21 y21 t |
	x1 := position x asFloat.
	y1 := position y asFloat.
	x21 := direction x asFloat.
	y21 := direction y asFloat.

	x21 = 0 ifTrue: [
		y21 = 0 ifTrue: [ ^false ].
		y21 > 0 ifTrue: [^ aPoint y < y1]
			ifFalse: [ ^ aPoint y > y1]
		].

	t := (aPoint x asFloat - x1) / x21.
	^ t < 0
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:39'
}
SUSDirectedPoint >> linearDist: aPoint [
	^ self position dist: (self projectionOf: aPoint)
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
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 23:27'
}
SUSDirectedPoint >> projectionOf: aPoint [
	direction = (0@0) ifTrue: [ ^ aPoint ].
	^ aPoint nearestPointAlongLineFrom: self position to: (self position + direction)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 6/15/2024 15:09'
}
SUSDirectedPoint >> relativeOffset: aPoint [
	| rotatedDirection normDirection offset |
	rotatedDirection := (direction rotateBy: 270 degreesToRadians about: 0@0) normalized.
	normDirection := direction normalized.
	
	offset := ((rotatedDirection * aPoint x) + (normDirection * aPoint y)).
	^ (offset x rounded) @ (offset y rounded)
]
