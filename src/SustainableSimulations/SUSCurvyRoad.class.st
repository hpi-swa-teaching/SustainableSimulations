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
	#'squeak_changestamp' : 'PM 6/18/2024 14:54'
}
SUSCurvyRoad >> createDrawing [
	| drawing |
	drawing := SUSCurvyRoadDrawing newFrom: from to: to.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	self position: drawing position.
	^ drawing
]
