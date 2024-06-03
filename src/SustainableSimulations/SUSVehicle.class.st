Class {
	#name : #SUSVehicle,
	#superclass : #RectangleMorph,
	#instVars : [
		'maxSpeed',
		'speed',
		'speedChanged',
		'timeSpeedChange',
		'progress',
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
	#'squeak_changestamp' : 'MK 5/21/2024 19:18'
}
SUSVehicle >> initialize [
	super initialize.
	maxSpeed := 100.
	acceleration := 1.
	length := 1.
	"position := 0 @ 0."
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 5/21/2024 11:16'
}
SUSVehicle >> lengh [
	
	^ length.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 5/21/2024 11:16'
}
SUSVehicle >> lengh: aNumber [
	
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
	#'squeak_changestamp' : 'MK 6/4/2024 00:58'
}
SUSVehicle >> progress: aNumber [
	progress := aNumber.
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
