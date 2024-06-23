Class {
	#name : #SUSCurvyRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'speedLimit'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/22/2024 22:10'
}
SUSCurvyRoad >> createDrawing [
	| drawing |
	drawing := SUSCurvyRoadDrawing newFrom: from to: to.
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
SUSCurvyRoad >> postInitialize [
]
