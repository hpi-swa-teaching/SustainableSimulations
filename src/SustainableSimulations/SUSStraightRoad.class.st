Class {
	#name : #SUSStraightRoad,
	#superclass : #SUSAbstractRoad,
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSStraightRoad >> createDrawing [
	^ SUSStraightRoadDrawing newFrom: from to: to position
]
