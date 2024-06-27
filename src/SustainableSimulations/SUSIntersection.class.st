Class {
	#name : #SUSIntersection,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'standingCars',
		'lastRightOfWayTime'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:28'
}
SUSIntersection >> driving: aCar [

	(standingCars includes: aCar) ifTrue: [
		standingCars remove: aCar]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:29'
}
SUSIntersection >> giveRightOfWay [
	Time millisecondClock - lastRightOfWayTime > 1000
		ifTrue: [standingCars asOrderedCollection atRandom rightOfWayTime: 2000.
				 standingCars removeAll.
			lastRightOfWayTime := Time millisecondClock]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:29'
}
SUSIntersection >> initialize [
	super initialize.

	standingCars := Set new.
	lastRightOfWayTime := 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:29'
}
SUSIntersection >> standing: aCar [ 
	standingCars add: aCar.
	"check for two left turners"
	standingCars size = 2
		ifTrue: [| car1 car2 |
			car1 := standingCars asOrderedCollection at: 1.
			car2 := standingCars asOrderedCollection at: 2.
			(car1 route first = 1
					and: car2 route first = 1
					and: ((self getOppositeLanesFrom: car1 lane nextLanes first)
							includes: car2 lane nextLanes first))
				ifTrue: [self giveRightOfWay]].
	"check for remaining edgecases"
	standingCars size >= 3
		ifTrue: [self giveRightOfWay]
]
