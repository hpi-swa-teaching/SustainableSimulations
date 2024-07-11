"
A SUSCurvyRoad is a curve road, represented as a quadratic bezier curve (three points).

Instance Variables

"
Class {
	#name : #SUSCurvyRoad,
	#superclass : #SUSAbstractRoad,
	#category : #'SustainableSimulations-Roads',
	#'squeak_changestamp' : 'PM 7/11/2024 18:40'
}

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSCurvyRoad >> createDrawing [
	^ SUSCurvyRoadDrawing newFrom: from to: to.
]
