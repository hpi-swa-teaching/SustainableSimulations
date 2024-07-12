"
A SUSTunnel is a road which repeatedly spawns cars.

Instance Variables
	frequency:		Number
	lastTime:		Number

frequency
	- How often a car should be spawned.

lastTime
	- The last time in milliseconds at which the latest car was spawned

"
Class {
	#name : #SUSTunnel,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'lastTime',
		'frequency'
	],
	#category : #'SustainableSimulations-Roads',
	#'squeak_changestamp' : 'PM 7/11/2024 20:06'
}

{
	#category : #behavior,
	#'squeak_changestamp' : 'MK 7/12/2024 17:28'
}
SUSTunnel >> applyBehavior [
	| deltaTime |
	deltaTime := Time millisecondClock - lastTime - simulation timePaused.
	deltaTime >= (frequency * 1000)
		ifTrue: [self spawnCarFromTunnel.
			lastTime := Time millisecondClock]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 20:18'
}
SUSTunnel >> connectionPointPositions [
	^ {from}
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:24'
}
SUSTunnel >> createDrawing [
	^ SUSTunnelDrawing newFrom: from to: to position
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'Len 6/23/2024 10:21'
}
SUSTunnel >> initialize [
	super initialize.
	frequency := 10.
	lastTime := Time millisecondClock - (frequency * 1000)
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'PM 7/11/2024 19:28'
}
SUSTunnel >> postInitialize [
	simulation addTunnel: self.
	lanes second shouldRemoveVehicles: true
]

{
	#category : #spawning,
	#'squeak_changestamp' : 'PM 7/11/2024 11:50'
}
SUSTunnel >> spawnCarFromTunnel [
	| car |
	car := SUSCar newOnRoad: self withMaxSpeed: 50 asNumber.
	car spawnRoad: 0.
	simulation addMorphInLayer: car
]
