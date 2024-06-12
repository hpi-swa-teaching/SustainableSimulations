Class {
	#name : #SUSCurvyRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'from',
		'to',
		'speedLimit'
	],
	#category : #SustainableSimulations
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 16:58'
}
SUSCurvyRoad >> askForDegrees [
	^ (UIManager default request: 'Please enter rotation degrees (0 < x < 180)' initialAnswer: 90) asNumber
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 04:06'
}
SUSCurvyRoad >> createConnectionPoints [
	| previousConnectionPoint nextConnectionPoint |
	previousConnectionPoint := (SUSConnectionPoint newForRoad: self withDirection: (-1@0))
		center: 0@SUSDrawing normalLaneWidth;
		yourself.
	nextConnectionPoint := (SUSConnectionPoint newForRoad: self withDirection: self directionVector)
		center: self point;
		yourself.
	^ {previousConnectionPoint . nextConnectionPoint}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 03:44'
}
SUSCurvyRoad >> createDrawing [
	| drawing |
	drawing := SUSDrawing newCurveTo: point withDirection: self directionVector.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 16:58'
}
SUSCurvyRoad >> from: aDirectedPoint to: aPoint [
	| degrees |
	from := aDirectedPoint.
	degrees := self askDegrees.
	to := SUSDirectedPoint newWithPosition: aPoint inDirection: (aDirectedPoint direction rotateBy: degrees about: 0@0).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 03:42'
}
SUSCurvyRoad >> point [
	^ point
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 03:42'
}
SUSCurvyRoad >> point: anObject [
	point := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 00:37'
}
SUSCurvyRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 00:37'
}
SUSCurvyRoad >> speedLimit: anObject [
	speedLimit := anObject
]
