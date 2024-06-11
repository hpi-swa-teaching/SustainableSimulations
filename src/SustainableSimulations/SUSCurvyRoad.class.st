Class {
	#name : #SUSCurvyRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'point',
		'degrees',
		'speedLimit'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/11/2024 03:41'
}
SUSCurvyRoad class >> newOnSimulation: aSimulation to: aPoint withDegrees: aNumber withSpeedLimit: anotherNumber [
	^ self new simulation: aSimulation;
		speedLimit: anotherNumber;
		point: aPoint;
		degrees: aNumber;
		postInitialization;
		yourself
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
	#'squeak_changestamp' : 'PM 6/11/2024 03:35'
}
SUSCurvyRoad >> degrees [
	^ degrees
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 03:35'
}
SUSCurvyRoad >> degrees: anObject [
	degrees := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:36'
}
SUSCurvyRoad >> directionVector [
	^ 1@0 rotateBy: (180 - degrees) degreesToRadians about: 0@0
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
