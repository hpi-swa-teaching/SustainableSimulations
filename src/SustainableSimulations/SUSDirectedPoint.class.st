Class {
	#name : #SUSDirectedPoint,
	#superclass : #Object,
	#instVars : [
		'position',
		'direction'
	],
	#category : #'SustainableSimulations-Utils'
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
	#'squeak_changestamp' : 'PM 6/11/2024 02:27'
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
	#'squeak_changestamp' : 'PM 6/11/2024 02:09'
}
SUSDirectedPoint >> direction: anObject [
	direction := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 02:09'
}
SUSDirectedPoint >> position [
	^ position
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 02:09'
}
SUSDirectedPoint >> position: anObject [
	position := anObject
]
