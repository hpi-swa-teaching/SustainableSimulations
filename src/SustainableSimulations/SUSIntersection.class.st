Class {
	#name : #SUSIntersection,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'standingCars',
		'longStandingCars',
		'lastRightOfWayTime',
		'strategy'
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
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 10:54'
}
SUSIntersection >> initialize [
	super initialize.

	standingCars := Set new.
	longStandingCars := Set new.
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
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:39'
}
SUSIntersection >> shouldGiveRightOfWay [
	self subclassResponsibility
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 13:38'
}
SUSIntersection >> standing: aCar [ 
	(standingCars includes: aCar)
		ifTrue: [longStandingCars add: aCar].
	standingCars add: aCar.
	self isEmpty
		ifFalse: [^ self].
	(strategy shouldGiveRightOfWay: longStandingCars) ifTrue: [self giveRightOfWay].
]
