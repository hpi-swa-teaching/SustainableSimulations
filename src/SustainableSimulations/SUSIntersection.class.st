Class {
	#name : #SUSIntersection,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'lastRightOfWayTime',
		'strategy',
		'standingVehicles',
		'longStandingVehicles'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 10:48'
}
SUSIntersection >> createStrategy [
	self subclassResponsibility
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:02'
}
SUSIntersection >> getOppositeLaneFrom: aLane [
	self subclassResponsibility
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/11/2024 14:56'
}
SUSIntersection >> giveRightOfWay [
	Time millisecondClock - lastRightOfWayTime > 1000
		ifTrue: [longStandingVehicles asOrderedCollection atRandom rightOfWayTime: 2000.
			longStandingVehicles removeAll.
			standingVehicles removeAll.
			lastRightOfWayTime := Time millisecondClock]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/11/2024 14:56'
}
SUSIntersection >> initialize [
	super initialize.

	standingVehicles := Set new.
	longStandingVehicles := Set new.
	strategy := self createStrategy.
	lastRightOfWayTime := 0
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:05'
}
SUSIntersection >> isBlockedFrom: aLane [
	self subclassResponsibility
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/11/2024 14:56'
}
SUSIntersection >> isVehicleDriving: aVehicle [
	(standingVehicles includes: aVehicle) ifTrue: [
		standingVehicles remove: aVehicle].
	(longStandingVehicles includes: aVehicle) ifTrue: [
		longStandingVehicles remove: aVehicle].
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:39'
}
SUSIntersection >> shouldGiveRightOfWay [
	self subclassResponsibility
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/11/2024 14:56'
}
SUSIntersection >> standing: aCar [ 
	(standingVehicles includes: aCar)
		ifTrue: [longStandingVehicles add: aCar].
	standingVehicles add: aCar.
	self isEmpty
		ifFalse: [^ self].
	(strategy shouldGiveRightOfWayTime: longStandingVehicles) ifTrue: [self giveRightOfWay].
]
