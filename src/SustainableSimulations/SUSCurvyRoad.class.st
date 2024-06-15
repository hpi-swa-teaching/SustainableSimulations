Class {
	#name : #SUSCurvyRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'from',
		'to',
		'speedLimit'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:47'
}
SUSCurvyRoad >> addConnectionPoints [
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
	#'squeak_changestamp' : 'PM 6/15/2024 17:11'
}
SUSCurvyRoad >> createDrawingFrom: aDirectedPoint to: anotherDirectedPoint [
	| drawing |
	drawing := SUSCurvyRoadDrawing newFrom: aDirectedPoint asDirectedPoint to: anotherDirectedPoint.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	self position: drawing position.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/15/2024 16:33'
}
SUSCurvyRoad >> from: aDirectedPoint to: anotherDirectedPoint [
	from := aDirectedPoint.
	to := anotherDirectedPoint.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/15/2024 16:57'
}
SUSCurvyRoad >> otherConnectionPointPositionsThan: aConnectionPoint [ 
	^ { SUSConnectionPoint newForRoad: self at: to }
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
