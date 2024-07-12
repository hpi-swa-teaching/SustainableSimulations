"
A SUSAbstractIntersection represents a intersection road.

Instance Variables
	lastRightOfWayTime:	Number
	longStandingVehicles:	OrderedCollection{SUSVehicle}
	standingVehicles:		OrderedCollection{SUSVehicle}
	strategy:				SUSRoadStrategy

lastRightOfWayTime
	- The last time when right of way was given.

longStandingVehicles
	- Vehicles which have been standing a long time

standingVehicles
	- All vehicles which are standing

strategy
	- The strategy with which right of way is given

"
Class {
	#name : #SUSAbstractIntersection,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'lastRightOfWayTime',
		'strategy',
		'standingVehicles',
		'longStandingVehicles'
	],
	#category : #'SustainableSimulations-Roads',
	#'squeak_changestamp' : 'PM 7/11/2024 18:43'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 10:48'
}
SUSAbstractIntersection >> createStrategy [
	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:02'
}
SUSAbstractIntersection >> getOppositeLaneFrom: aLane [
	self subclassResponsibility
]

{
	#category : #'right of way',
	#'squeak_changestamp' : 'PM 7/11/2024 18:37'
}
SUSAbstractIntersection >> giveRightOfWay [
	Time millisecondClock - lastRightOfWayTime > self rightOfWayTime
		ifTrue: [longStandingVehicles asOrderedCollection atRandom rightOfWayTime: 2 * self rightOfWayTime.
			longStandingVehicles removeAll.
			standingVehicles removeAll.
			lastRightOfWayTime := Time millisecondClock]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/11/2024 18:39'
}
SUSAbstractIntersection >> initialize [
	super initialize.
	standingVehicles := Set new.
	longStandingVehicles := Set new.
	strategy := self createStrategy.
	lastRightOfWayTime := 0
]

{
	#category : #'right of way',
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:05'
}
SUSAbstractIntersection >> isBlockedFrom: aLane [
	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:39'
}
SUSAbstractIntersection >> isStanding: aVehicle [ 
	(standingVehicles includes: aVehicle)
		ifTrue: [longStandingVehicles add: aVehicle].
	standingVehicles add: aVehicle.
	self isEmpty
		ifFalse: [^ self].
	(strategy shouldGiveRightOfWayTime: longStandingVehicles)
		ifTrue: [self giveRightOfWay]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:39'
}
SUSAbstractIntersection >> isVehicleDriving: aVehicle [ 
	(standingVehicles includes: aVehicle)
		ifTrue: [standingVehicles remove: aVehicle].
	(longStandingVehicles includes: aVehicle)
		ifTrue: [longStandingVehicles remove: aVehicle]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:37'
}
SUSAbstractIntersection >> rightOfWayTime [
	^ 1000
]

{
	#category : #'right of way',
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:39'
}
SUSAbstractIntersection >> shouldGiveRightOfWay [
	self subclassResponsibility
]
