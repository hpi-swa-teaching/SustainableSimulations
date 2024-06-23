Class {
	#name : #SUSStraightRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'speedLimit'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/22/2024 22:09'
}
SUSStraightRoad >> createDrawing [
	| drawing |
	drawing := SUSStraightRoadDrawing newFrom: from to: to position.
	drawing paths
		do: [:each | self createLaneWithPath: each].
	self extent: drawing extent;
		 position: drawing position.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 19:59'
}
SUSStraightRoad >> postInitialize [
]
