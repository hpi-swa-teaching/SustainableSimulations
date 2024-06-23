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
	#'squeak_changestamp' : 'PM 6/18/2024 14:56'
}
SUSStraightRoad >> createDrawing [
	| drawing |
	drawing := SUSStraightRoadDrawing newFrom: from to: to position.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].

	self extent: drawing extent.
	self position: drawing position.
	^ drawing
]
