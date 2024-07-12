"
A SUSStraightRoad is a road which is built straight in one direction.

Instance Variables

"
Class {
	#name : #SUSStraightRoad,
	#superclass : #SUSAbstractRoad,
	#category : #'SustainableSimulations-Roads',
	#'squeak_changestamp' : 'PM 7/11/2024 20:05'
}

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSStraightRoad >> createDrawing [
	^ SUSStraightRoadDrawing newFrom: from to: to position
]
