Class {
	#name : #SUSVehicle,
	#superclass : #RectangleMorph,
	#instVars : [
		'maxSpeed',
		'acceleration',
		'position',
		'length',
		'simulation',
		'lane'
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
	#'squeak_changestamp' : 'Len 6/2/2024 18:34'
}
SUSVehicle >> initialize [
	super initialize.
	maxSpeed := 100.
	acceleration := 1.
	length := 30.
	"position := 0 @ 0."
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:28'
}
SUSVehicle >> length [
	
	^ length.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:28'
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
