Class {
	#name : #SUSCurvyRoad,
	#superclass : #SUSAbstractRoad,
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
