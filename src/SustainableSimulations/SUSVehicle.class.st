Class {
	#name : #SUSVehicle,
	#superclass : #Object,
	#instVars : [
		'maxSpeed',
		'acceleration',
		'lengh',
		'position'
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
	#'squeak_changestamp' : 'ek 5/19/2024 16:18'
}
SUSVehicle >> initialize [

	maxSpeed := 100.
	acceleration := 1.
	lengh := 1.
	position := 0 @ 0.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:46'
}
SUSVehicle >> lengh [
	
	^ lengh.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:23'
}
SUSVehicle >> lengh: aNumber [
	
	lengh := aNumber.
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
