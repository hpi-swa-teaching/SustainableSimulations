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
	#'squeak_changestamp' : 'PM 6/15/2024 13:09'
}
SUSStraightRoad >> createDrawingFrom: aConnectionPoint to: aPoint [
	| drawing |
	drawing := SUSStraightRoadDrawing newFrom: from to: to.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	self position: drawing position.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/15/2024 13:10'
}
SUSStraightRoad >> from: aDirectedPoint to: aPoint [
	from := aDirectedPoint.
	to := aPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/15/2024 13:13'
}
SUSStraightRoad >> otherConnectionPointPositionsThan: aConnectionPoint [ 
	^ { SUSConnectionPoint newForRoad: self at: (SUSDirectedPoint newWithPosition: to inDirection: from direction)}
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
