Class {
	#name : #SUSCar,
	#superclass : #SUSVehicle,
	#instVars : [
		'driver',
		'fuelLevel',
		'timeRoadStart',
		'blockedOldLane',
		'oldLane'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:36'
}
SUSCar class >> newOnSimulation: aSimulation [
	^ self new 
		simulation: aSimulation;
		postInitialization;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/3/2024 21:17'
}
SUSCar class >> newOnSimulation: aSimulation withSpeed: aNumber [
	^ self new 
		simulation: aSimulation;
		speed: aNumber;
		postInitialization;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/10/2024 23:40'
}
SUSCar class >> newOnSimulation: aSimulation withSpeed: aNumber onRoad: aRoad [
	^ self new 
		simulation: aSimulation;
		speed: aNumber;
		placeCarOnRoad: aRoad;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 00:10'
}
SUSCar >> calculateNewMaxT [
	| previousCar |
	previousCar := lane getPreviousCarOnLane: self.
	previousCar = self 
		ifFalse: [ ^ ((previousCar lastPoint first) * lane length) - 50 / (lane length)].
	^ 1
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 01:22'
}
SUSCar >> calculateNewT [
	| difTime t maxT |
	difTime := (Time millisecondClock) - lastPoint second.
	t := lastPoint first + (difTime / (lane length / (speed / 360))).
	maxT := self calculateNewMaxT.
	
	t > maxT 
		ifTrue: [t := maxT].
	t > lane blockedT
		ifTrue: [t := lane blockedT].
	
	self updateLaneConnectionsWithT: t.
	^ {t. (Time millisecondClock)}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 01:06'
}
SUSCar >> changeLane [
	lane nextLanes isEmpty
		ifFalse: [
			| random |
			random := Random new.
			lane removeCar: self.
			blockedOldLane := true.
			oldLane := lane.
			"lane := lane nextLanes first."
			lane := (lane nextLanes at: (random nextInt: (lane nextLanes size))).
			lane addCar: self.
			lastPoint := {0. (Time millisecondClock)}]
		ifTrue: [{1. (Time millisecondClock)}]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/19/2024 13:00'
}
SUSCar >> drawFrontMarkerOn: aCanvas [
    | frontMarkerBounds |
    frontMarkerBounds := (self bounds origin x + self width - 10 @ self bounds origin y extent: 10 @ self height).
    aCanvas fillRectangle: frontMarkerBounds color: Color yellow.
    aCanvas frameRectangle: frontMarkerBounds width: 2 color: Color black.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/19/2024 13:00'
}
SUSCar >> drawOn: aCanvas [
    super drawOn: aCanvas.
    self drawFrontMarkerOn: aCanvas.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:45'
}
SUSCar >> driver [
		
	^ driver
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:39'
}
SUSCar >> driver: aString [
		
	driver := aString.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:46'
}
SUSCar >> fuelLevel [
	
	^ fuelLevel
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:38'
}
SUSCar >> fuelLevel: aNumber [
	
	fuelLevel := aNumber.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/10/2024 17:24'
}
SUSCar >> initialize [
	super initialize.
	self extent: 30@15;
		color: Color red.
	self addFlexShellIfNecessary.

	timeRoadStart := Time millisecondClock.
	maxSpeed := 50.
	acceleration := 10.
	length := 1.
	driver := 'Unknown'.
	fuelLevel := 100.
	
	lastPoint := {0. Time millisecondClock}.
	blockedOldLane := false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 01:40'
}
SUSCar >> move [
	| t rotation |
	lastPoint := self calculateNewT.
	t := lastPoint first.
	(t >= 1)
		ifTrue: [
			self changeLane.
			t := lastPoint first.].
	self owner center: (lane getPositionWithTValue: t).
	rotation := (lane getRotationWithTValue: t).
	rotation first = 1
		ifTrue:[ self rotationDegrees: rotation second ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/10/2024 23:31'
}
SUSCar >> placeCarOnRoad: aRoad [

	simulation addCar: self.
	lane := aRoad lanes first.
	lane addCar: self.
	
	self center: (lane getPositionWithTValue: 0)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/9/2024 23:58'
}
SUSCar >> postInitialization [
	"TMP Method to spawn a simple car"
	simulation addCar: self.
	lane := simulation roads first lanes first.
	lane addCar: self.
	
	self center: (lane getPositionWithTValue: 0)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 01:21'
}
SUSCar >> updateLaneConnectionsWithT: aNumber [
	blockedOldLane
		ifTrue: [ | pos |
			pos := lane length * aNumber.
			pos > 50
				ifTrue: [
					oldLane updateBlocked: -1.
					blockedOldLane := false.]
				ifFalse: [oldLane updateBlocked: 50 - pos]]
]
