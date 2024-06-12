Class {
	#name : #SUSStraightRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'from',
		'to',
		'speedLimit'
	],
	#category : #SustainableSimulations
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:16'
}
SUSStraightRoad >> createConnectionPoints [
	| previousConnectionPoint nextConnectionPoint |
	previousConnectionPoint := (SUSConnectionPoint newForRoad: self withDirection: (-1@0))
		center: (self extent * (0@0.5));
		yourself.
	nextConnectionPoint := (SUSConnectionPoint newForRoad: self withDirection: (1@0))
		center: (self extent * (1@0.5));
		yourself.
	^ {previousConnectionPoint . nextConnectionPoint}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:10'
}
SUSStraightRoad >> createDrawing [
	| drawing |
	drawing := SUSDrawing newNormalRoadWithLength: self length.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 16:54'
}
SUSStraightRoad >> from: aDirectedPoint to: aPoint [
	from := aDirectedPoint.
	to := SUSDirectedPoint newWithPosition: aPoint inDirection: from direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:43'
}
SUSStraightRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:43'
}
SUSStraightRoad >> speedLimit: anObject [
	speedLimit := anObject
]
