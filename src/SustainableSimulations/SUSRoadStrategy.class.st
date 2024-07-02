Class {
	#name : #SUSRoadStrategy,
	#superclass : #Object,
	#instVars : [
		'road'
	],
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 10:32'
}
SUSRoadStrategy >> isBlockedFrom: aLane [ 
	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 10:31'
}
SUSRoadStrategy >> road [
	^ road
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 10:31'
}
SUSRoadStrategy >> road: anObject [
	road := anObject
]
