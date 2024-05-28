Class {
	#name : #SUSStraightRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'length',
		'speedLimit'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 5/27/2024 23:45'
}
SUSStraightRoad class >> newOnSimulation: aSimulation withLength: aNumber [
	^ self newOnSimulation: aSimulation withLength: aNumber withSpeedLimit: aSimulation defaultSpeedLimit
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 5/27/2024 23:51'
}
SUSStraightRoad class >> newOnSimulation: aSimulation withLength: aNumber withSpeedLimit: anotherNumber [
	^ self new simulation: aSimulation;
		length: aNumber;
		speedLimit: anotherNumber;
		postInitialization;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:16'
}
SUSStraightRoad >> createConnectionPoints [
	| previousConnectionPoint nextConnectionPoint |
	previousConnectionPoint := (SUSConnectionPoint newForRoad: self withDirection: (-1@0))
		center: (self extent * (0@0.5));
		yourself.
	nextConnectionPoint := (SUSConnectionPoint newForRoad: self withDirection: (1@0))
		center: (self extent * (1@0.5));
		yourself.
	^ {previousConnectionPoint . nextConnectionPoint}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:46'
}
SUSStraightRoad >> createDrawing [
	| drawing |
	drawing := SUSDrawing newNormalRoadWithLength: self length.
	self extent: drawing extent.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:42'
}
SUSStraightRoad >> length [
	^ length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:42'
}
SUSStraightRoad >> length: anObject [
	length := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:43'
}
SUSStraightRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:43'
}
SUSStraightRoad >> speedLimit: anObject [
	speedLimit := anObject
]
