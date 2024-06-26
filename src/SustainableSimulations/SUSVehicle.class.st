Class {
	#name : #SUSVehicle,
	#superclass : #RectangleMorph,
	#instVars : [
		'maxSpeed',
		'speed',
		'acceleration',
		'deacceleration',
		'speedGoal',
		'length',
		'simulation',
		'lane',
		'lastPoint',
		'lastTime',
		'deltaTime',
		'isAccelerating',
		'route'
	],
	#category : #'SustainableSimulations-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:22'
}
SUSVehicle >> acceleration: aNumber [
	
	acceleration := aNumber.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/15/2024 09:23'
}
SUSVehicle >> deacceleration [
	^ deacceleration
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:00'
}
SUSVehicle >> deltaTime [
	^ deltaTime
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:00'
}
SUSVehicle >> deltaTime: anObject [
	deltaTime := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 11:31'
}
SUSVehicle >> initialize [
	super initialize.
	
	maxSpeed := 100.
	acceleration := 1.
	length := 1.
	
	self morphicLayerNumber: 15
	"position := 0 @ 0."
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 20:32'
}
SUSVehicle >> kill [
	simulation removeCar: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:08'
}
SUSVehicle >> lane [
	^ lane
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:08'
}
SUSVehicle >> lane: anObject [
	lane := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 00:05'
}
SUSVehicle >> lastPoint [
	^ lastPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:10'
}
SUSVehicle >> lastPoint: anObject [
	lastPoint := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 14:36'
}
SUSVehicle >> lastTime [
	^ lastTime
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 14:36'
}
SUSVehicle >> lastTime: anObject [
	lastTime := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:46'
}
SUSVehicle >> maxSpeed [

	^ maxSpeed.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:19'
}
SUSVehicle >> maxSpeed: aNumber [
	
	maxSpeed := aNumber.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 15:58'
}
SUSVehicle >> route [
	^ route
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 15:58'
}
SUSVehicle >> route: anObject [
	route := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:32'
}
SUSVehicle >> simulation [
	^ simulation
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:29'
}
SUSVehicle >> simulation: aSimulation [
	simulation := aSimulation
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/4/2024 00:42'
}
SUSVehicle >> speed [
	^speed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/4/2024 00:41'
}
SUSVehicle >> speed: aNumber [
	speed := aNumber.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:51'
}
SUSVehicle >> speedGoal [
	^ speedGoal
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:51'
}
SUSVehicle >> speedGoal: anObject [
	speedGoal := anObject
]
