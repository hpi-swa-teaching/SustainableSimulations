Class {
	#name : #SUSCurvyRoad,
	#superclass : #SUSAbstractRoad,
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSCurvyRoad >> createDrawing [
	^ SUSCurvyRoadDrawing newFrom: from to: to.
]
