Class {
	#name : #SUSVehicle,
	#superclass : #RectangleMorph,
	#instVars : [
		'maxSpeed',
		'acceleration',
		'deceleration',
		'position',
		'length'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:46'
}
SUSVehicle >> acceleration [

	^ acceleration.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:22'
}
SUSVehicle >> acceleration: aNumber [
	
	acceleration := aNumber.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/26/2024 13:51'
}
SUSVehicle >> deceleration [

	^ deceleration.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/26/2024 13:51'
}
SUSVehicle >> deceleration: aNumber [
	
	deceleration := aNumber.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 5/21/2024 11:19'
}
SUSVehicle >> initialize [
	super initialize.
	maxSpeed := 100.
	acceleration := 1.
	length := 1.
	position := 0 @ 0.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/26/2024 13:50'
}
SUSVehicle >> length [
	
	^ length.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/26/2024 13:50'
}
SUSVehicle >> length: aNumber [
	
	length := aNumber.
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:46'
}
SUSVehicle >> position [
	
	^ position.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:21'
}
SUSVehicle >> position: aPoint [
	
	position := aPoint.
]
