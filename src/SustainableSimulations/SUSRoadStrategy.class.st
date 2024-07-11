"
Abstract Class for different right of way rules / strategies for different road types

Instance Variables
	road:	SUSAbstractRoad
		
road
	- The road on which the strategy is applied to.
"
Class {
	#name : #SUSRoadStrategy,
	#superclass : #Object,
	#instVars : [
		'road'
	],
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'PM 7/11/2024 18:54'
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
	#'squeak_changestamp' : 'PM 7/11/2024 19:52'
}
SUSRoadStrategy >> isBlockedByOwnLanesFrom: aLane [ 
	^ (self getBlockedLanesFrom: aLane)
		anySatisfy: [:each | each vehicles isEmpty not]
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:44'
}
SUSRoadStrategy >> isBlockedFrom: aLane [ 
	^ (self isBlockedByOwnLanesFrom: aLane)
		or: (self isBlockedByOtherLanesFrom: aLane)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 19:10'
}
SUSRoadStrategy >> maxSearchDistance [
	^ 200
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
	#'squeak_changestamp' : 'PM 7/11/2024 19:47'
}
SUSRoadStrategy >> searchForCarAtIndex: aNumber [ 
	^ road
		searchVehicleBackwardsFromLane: (road lanes at: aNumber)
		withMaxDist: self maxSearchDistance
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:52'
}
SUSRoadStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	self subclassResponsibility
]
