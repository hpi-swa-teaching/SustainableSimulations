Class {
	#name : #SUSCrossIntersection,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'standingCars',
		'lastRightOfWayTime'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 15:32'
}
SUSCrossIntersection >> connectionPointPositions [
	| positions directions |
	positions := {2 negated @ 2. 0 @ 4. 2 @ 2} * SUSDrawing normalLaneWidth.
	directions := {90. 0. 270}
				collect: [:each | from direction rotateBy: each degreesToRadians about: 0 @ 0].
	^ {from}, ((1 to: 3)
		collect: [:index | SUSDirectedPoint
				newWithPosition: (from absoluteOffset: (positions at: index))
				inDirection: (directions at: index)]).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/25/2024 10:40'
}
SUSCrossIntersection >> createDrawing [
	| drawing |
	drawing := SUSCrossIntersectionDrawing newFrom: from to: to position.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].
	
	self extent: drawing extent; 
		position: drawing position.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 11:42'
}
SUSCrossIntersection >> driving: aCar [

	(standingCars includes: aCar) ifTrue: [
		standingCars remove: aCar]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 10:20'
}
SUSCrossIntersection >> getOppositeLanesFrom: aLane [
	| tmp |
	tmp := ((lanes indexOf: aLane) - 1 / 3) floor * 3 + 7 \\ 12.
	^ lanes copyFrom: tmp to: (tmp + 2).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 10:22'
}
SUSCrossIntersection >> getRightTurnLanesFrom: aLane [ 
	| tmp |
	tmp := ((lanes indexOf: aLane) - 1 / 3) floor * 3 + 4 \\ 12.
	^ lanes copyFrom: tmp to: (tmp + 2)
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 16:04'
}
SUSCrossIntersection >> giveRightOfWay [
	Time millisecondClock - lastRightOfWayTime > 1000
		ifTrue: [standingCars asOrderedCollection atRandom rightOfWayTime: 2000.
				 standingCars removeAll.
			lastRightOfWayTime := Time millisecondClock]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 11:47'
}
SUSCrossIntersection >> initialize [

	standingCars := Set new.
	lastRightOfWayTime := 0.
	super initialize.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 16:03'
}
SUSCrossIntersection >> standing: aCar [ 
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
