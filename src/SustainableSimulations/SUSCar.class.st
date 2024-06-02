Class {
	#name : #SUSCar,
	#superclass : #SUSVehicle,
	#instVars : [
		'driver',
		'fuelLevel',
		'timeRoadStart',
		'lastT',
		'lastTime'
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
	#'squeak_changestamp' : 'Len 6/2/2024 18:49'
}
SUSCar >> initialize [
	super initialize.
	self extent: 30@15;
		color: Color red.

	timeRoadStart := Time millisecondClock.
	maxSpeed := 50.
	acceleration := 10.
	length := 30.
	driver := 'Unknown'.
	fuelLevel := 100.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:33'
}
SUSCar >> lastT [
	^ lastT
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:38'
}
SUSCar >> move [
	|curTime t| 

	curTime := (Time millisecondClock) - timeRoadStart.
	t := (curTime / (lane length / (maxSpeed / 360))).
	
	(t < 1) ifTrue: [(lane checkIfFreeWithT: t withVehicle: self) 
			ifTrue: [
				self center: (lane getPositionWithTValue: t).
				lastT := t.
				lastTime := curTime]
			ifFalse: [
				timeRoadStart := timeRoadStart + (curTime - lastTime)]]
			ifFalse: [
				(lane nextLanes isEmpty) 
					ifTrue: [lastT := 1]
					ifFalse: [
						lane removeVehicle: self.
						lane := lane nextLanes first.
						timeRoadStart := (Time millisecondClock).
						lane addVehicle: self.
						lastT := 0]]
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 21:44'
}
SUSCar >> moveAlongBezier: aBezierCurve [
	|curTime| 

	curTime := (Time millisecondClock) - timeRoadStart.

	self position: (aBezierCurve pointAt: (curTime / (aBezierCurve length / (maxSpeed / 360)))).
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:32'
}
SUSCar >> postInitialization [
	"TMP Method to spawn a simple car"
	simulation addVehicle: self.
	lastT := 0.
	lane := simulation roads first lanes first.
	lane addVehicle: self.
	
	self center: (lane getPositionWithTValue: 0)
]
