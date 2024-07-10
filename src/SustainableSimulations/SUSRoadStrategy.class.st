"
Abstract Class for different right of way rules / strategys for different road types
"
Class {
	#name : #SUSRoadStrategy,
	#superclass : #Object,
	#instVars : [
		'road'
	],
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:49'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 10:46'
}
SUSRoadStrategy class >> newFromRoad: aRoad [ 
	^ self new road: aRoad
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:56'
}
SUSRoadStrategy >> getBlockedLanesFrom: aLane [
	self subclassResponsibility
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:03'
}
SUSRoadStrategy >> isBlockedByOtherLanesFrom: aLane [
	self subclassResponsibility
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:11'
}
SUSRoadStrategy >> isBlockedByOwnLanesFrom: aLane [ 
	(self getBlockedLanesFrom: aLane)
		do: [:each | each cars
				ifNotEmpty: [^ true]].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:02'
}
SUSRoadStrategy >> isBlockedFrom: aLane [ 
	^ ((self isBlockedByOwnLanesFrom: aLane) or: (self isBlockedByOtherLanesFrom: aLane))
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

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:52'
}
SUSRoadStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	self subclassResponsibility
]
