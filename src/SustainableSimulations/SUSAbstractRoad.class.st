Class {
	#name : #SUSAbstractRoad,
	#superclass : #Object,
	#instVars : [
		'adjacentRoads',
		'exitPoints'
	],
	#category : #SustainableSimulations
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/25/2024 19:05'
}
SUSAbstractRoad >> adjacentRoads [
	^ adjacentRoads
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/25/2024 19:05'
}
SUSAbstractRoad >> adjacentRoads: anObject [
	adjacentRoads := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/25/2024 19:07'
}
SUSAbstractRoad >> exitPoints [
	^ exitPoints
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/25/2024 19:07'
}
SUSAbstractRoad >> exitPoints: anObject [
	exitPoints := anObject
]
