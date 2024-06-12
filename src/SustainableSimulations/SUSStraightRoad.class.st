Class {
	#name : #SUSStraightRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'from',
		'to',
		'speedLimit'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/13/2024 00:48'
}
SUSStraightRoad >> createDrawingFrom: aConnectionPoint to: aPoint [
	| drawing |
	drawing := SUSStraightRoadDrawing newFrom: from position to: to position.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	self position: drawing position.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 23:03'
}
SUSStraightRoad >> from: aDirectedPoint to: aPoint [
	from := aDirectedPoint.
	to := SUSDirectedPoint newWithPosition: aPoint inDirection: aDirectedPoint direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 23:01'
}
SUSStraightRoad >> otherConnectionPointPositionsThan: aConnectionPoint [ 
	^ { SUSConnectionPoint newForRoad: self at: to}
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
