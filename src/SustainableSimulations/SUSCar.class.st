"
A SUSCar is the most generic vehicle, a basic red car.

Instance Variables

"
Class {
	#name : #SUSCar,
	#superclass : #SUSVehicle,
	#category : #'SustainableSimulations-Core',
	#'squeak_changestamp' : 'PM 7/11/2024 16:18'
}

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:46'
}
SUSCar >> drawOn: aCanvas [
	super drawOn: aCanvas.
	aCanvas fillRectangle: self frontMarkerBounds color: Color yellow.
	aCanvas frameRectangle: self frontMarkerBounds width: 2 color: Color black
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:45'
}
SUSCar >> frontMarkerBounds [
	^ self bounds origin x + self width - 10 @ self bounds origin y extent: 10 @ self height
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/11/2024 11:45'
}
SUSCar >> initialize [
	super initialize.
	self extent: 30@15;
		color: Color red;
		addFlexShellIfNecessary
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 14:21'
}
SUSCar >> safetyDistance [
	^ 40
]
