Class {
	#name : #SUSIntersection,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'standingCars',
		'longStandingCars',
		'lastRightOfWayTime'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 12:50'
}
SUSIntersection >> driving: aCar [

	(standingCars includes: aCar) ifTrue: [
		standingCars remove: aCar].
	(longStandingCars includes: aCar) ifTrue: [
		longStandingCars remove: aCar].
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 14:04'
}
SUSIntersection >> getBlockedLanesFrom: aLane [ 
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
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 12:52'
}
SUSIntersection >> giveRightOfWay [
	Time millisecondClock - lastRightOfWayTime > 1000
		ifTrue: [longStandingCars asOrderedCollection atRandom rightOfWayTime: 2000.
			longStandingCars removeAll.
			standingCars removeAll.
			lastRightOfWayTime := Time millisecondClock]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 12:50'
}
SUSIntersection >> initialize [
	super initialize.

	standingCars := Set new.
	longStandingCars := Set new.
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
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:39'
}
SUSIntersection >> shouldGiveRightOfWay [
	self subclassResponsibility
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 14:11'
}
SUSIntersection >> standing: aCar [ 
	(standingCars includes: aCar)
		ifTrue: [longStandingCars add: aCar].
	standingCars add: aCar.
	self isEmpty
		ifFalse: [^ self].
	(self shouldGiveRightOfWay) ifTrue: [self giveRightOfWay].
]
