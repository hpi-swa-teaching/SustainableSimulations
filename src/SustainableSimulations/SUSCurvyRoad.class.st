Class {
	#name : #SUSCurvyRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'connectionPointA',
		'connectionPointB',
		'speedLimit'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/11/2024 01:05'
}
SUSCurvyRoad class >> newOnSimulation: aSimulation from: aConnectionPoint to: anotherConnectionPoint withSpeedLimit: anotherNumber [
	^ self new simulation: aSimulation;
		connectionPointA: aConnectionPoint;
		connectionPointB: anotherConnectionPoint;
		speedLimit: anotherNumber;
		postInitialization;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 01:04'
}
SUSCurvyRoad >> connectionPointA [
	^ connectionPointA
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 01:05'
}
SUSCurvyRoad >> connectionPointA: anObject [
	connectionPointA := anObject.
	anObject road: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 01:04'
}
SUSCurvyRoad >> connectionPointB [
	^ connectionPointB
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 01:06'
}
SUSCurvyRoad >> connectionPointB: anObject [
	connectionPointB := anObject.
	anObject road: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 01:04'
}
SUSCurvyRoad >> createConnectionPoints [
	^ {connectionPointA . connectionPointB}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 01:27'
}
SUSCurvyRoad >> createDrawing [
	| drawing |
	drawing := SUSDrawing newCurveFrom: connectionPointA to: connectionPointB.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	^ drawing
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
