Class {
	#name : #SUSCar,
	#superclass : #SUSVehicle,
	#instVars : [
		'driver',
		'fuelLevel',
		'timeRoadStart'
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
	#'squeak_changestamp' : 'Len 6/9/2024 20:40'
}
SUSCar >> initialize [
	super initialize.
	self extent: 30@15;
		color: Color red.
	self addFlexShellIfNecessary.

	timeRoadStart := Time millisecondClock.
	timeSpeedChange := 0.
	maxSpeed := 50.
	progress := 0.
	speedChanged := false.
	acceleration := 10.
	length := 1.
	driver := 'Unknown'.
	fuelLevel := 100.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/9/2024 21:23'
}
SUSCar >> move [
	|curTime t| 
	(speed = 0) 
		ifTrue: [t := 1]
		ifFalse: [
			(timeSpeedChange ~= 0) 
				ifTrue: [
					curTime := (Time millisecondClock) - timeSpeedChange.
					t := progress + (curTime / (lane length / (speed / 360)))]
				ifFalse: [
					curTime := (Time millisecondClock) - timeRoadStart.
					t := (curTime / (lane length / (speed / 360))).
					progress := t]].
	  
	(t < 1) 
		ifTrue: [
			self owner center: (lane getPositionWithTValue: t).
			self rotationDegrees: (lane getRotationWithTValue: t)]
		ifFalse: [
			(lane nextLanes isEmpty) 
				ifFalse: [
					| random |
					random := Random new.
					"lane := lane nextLanes first."
					lane := (lane nextLanes at: (random nextInt: (lane nextLanes size))).
					timeRoadStart := (Time millisecondClock)]
				ifTrue: [speed := 0.]]
	
	
		
	
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:50'
}
SUSCar >> postInitialization [
	"TMP Method to spawn a simple car"
	simulation addCar: self.
	lane := simulation roads first lanes first.
	
	self center: (lane getPositionWithTValue: 0)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/4/2024 00:45'
}
SUSCar >> timeSpeedChange: aNumber [
	timeSpeedChange := aNumber.
]
