Class {
	#name : #SUSLane,
	#superclass : #Object,
	#instVars : [
		'vehicles',
		'nextLanes',
		'path',
		'length',
		'blocked'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:58'
}
SUSLane class >> newLaneWithPath: aLineMorph [

	^SUSLane new path: aLineMorph;
		calculateLength;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 21:09'
}
SUSLane >> addNextLane: aNextLane [

	nextLanes addLast: aNextLane
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:15'
}
SUSLane >> addVehicle: aCar [

	vehicles add: aCar
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:56'
}
SUSLane >> calculateLength [
	| p1 p2 |
	p1 := path vertices first.
	p2 := path vertices last.
	
	length := ((p1 x - p2 x) squared + (p1 y - p2 y) squared) sqrt
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:51'
}
SUSLane >> checkIfFreeWithT: aNumber withVehicle: aVehicle [

	vehicles do: [:each |
		each = aVehicle 
			ifTrue: [^ true]
			ifFalse: [
				((aNumber * length + (aVehicle length)) >= (each lastT * length - (each length))) 
					ifTrue: [^ false]]].
	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:42'
}
SUSLane >> getPositionWithTValue: aNumber [
	| p1 p2 |
	p1 := path vertices first.
	p2 := path vertices last.
	
	^ ((1 - aNumber) * p1) + (aNumber * p2)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:20'
}
SUSLane >> initialize [

	vehicles := OrderedCollection new.
	nextLanes := OrderedCollection new
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 20:55'
}
SUSLane >> length [
	^ length
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/1/2024 21:19'
}
SUSLane >> nextLanes [
	^ nextLanes
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 19:27'
}
SUSLane >> path: aLineMorph [
	
	path := aLineMorph
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/2/2024 18:15'
}
SUSLane >> removeVehicle: aVehicle [

	vehicles remove: aVehicle
]
