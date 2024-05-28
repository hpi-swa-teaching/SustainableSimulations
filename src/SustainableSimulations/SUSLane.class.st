Class {
	#name : #SUSLane,
	#superclass : #Object,
	#instVars : [
		'cars',
		'nextLanes',
		'path'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 19:27'
}
SUSLane class >> newLaneWithPath: aLineMorph [

	^SUSLane new path: aLineMorph
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 19:11'
}
SUSLane >> addCar: aCar [

	cars add: aCar
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 19:10'
}
SUSLane >> addNextLane: aNextLane [

	nextLanes add: aNextLane
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 19:09'
}
SUSLane >> initialize [

	cars := OrderedCollection new.
	nextLanes := OrderedCollection new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 19:27'
}
SUSLane >> path: aLineMorph [
	
	path := aLineMorph
]
