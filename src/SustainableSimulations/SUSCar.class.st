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
	#'squeak_changestamp' : 'MK 5/27/2024 21:34'
}
SUSCar >> initialize [
	super initialize.
	self extent: 30@15;
		color: Color red.

	timeRoadStart := Time millisecondClock.
	maxSpeed := 50.
	acceleration := 10.
	length := 1.
	driver := 'Unknown'.
	fuelLevel := 100.
	
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
