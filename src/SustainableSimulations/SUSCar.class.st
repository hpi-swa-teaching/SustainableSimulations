Class {
	#name : #SUSCar,
	#superclass : #SUSVehicle,
	#instVars : [
		'driver',
		'fuelLevel',
		'color'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:47'
}
SUSCar >> color [
	
	^ color.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/19/2024 16:40'
}
SUSCar >> color: aColor [
	
	color := aColor.
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
	#'squeak_changestamp' : 'ek 5/19/2024 16:37'
}
SUSCar >> initialize [

	super initialize.
	maxSpeed := 200.
	acceleration := 10.
	lengh := 1.
	driver := 'Unknown'.
	fuelLevel := 100.
	color := Color red.
	
]
