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
	#'squeak_changestamp' : 'Len 6/1/2024 20:10'
}
SUSStraightRoad >> createDrawing [
	| drawing |
	drawing := SUSDrawing newNormalRoadWithLength: self length.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	^ drawing
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/11/2024 00:55'
}
SUSStraightRoad >> handleClick: anEvent [
	(simulation buildMode = #SpawnCar) ifTrue: [
		simulation addMorph: (SUSCar
			newOnSimulation: simulation
			withSpeed: (UIManager default request: 'Please enter car speed' initialAnswer: 50) asNumber
			onRoad: self)]
	
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/10/2024 22:53'
}
SUSStraightRoad >> mouseDown: anEvent [
	self handleClick: anEvent.
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
