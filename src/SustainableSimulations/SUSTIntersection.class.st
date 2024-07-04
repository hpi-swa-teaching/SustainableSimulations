Class {
	#name : #SUSTIntersection,
	#superclass : #SUSIntersection,
	#instVars : [
		'noExitAt'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/3/2024 00:07'
}
SUSTIntersection class >> newOnSimulation: aSimulation from: aConnectionPoint to: aPoint noExitAt: aDirection [
	^ self new simulation: aSimulation;
		noExitAt: aDirection;
		initializeFrom: aConnectionPoint to: aPoint;
		postInitialize;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/3/2024 00:07'
}
SUSTIntersection >> connectionPointPositions [
	| positions directions |
	positions := (self positions at: noExitAt) * SUSDrawing normalLaneWidth.
	directions := (self directions at: noExitAt)
				collect: [:each | from direction rotateBy: each degreesToRadians about: 0 @ 0].
	^ {from}, ((1 to: 2)
		collect: [:index | SUSDirectedPoint
				newWithPosition: (from absoluteOffset: (positions at: index))
				inDirection: (directions at: index)]).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSTIntersection >> createDrawing [
	^ SUSTIntersectionDrawing newFrom: self drawingPoint to: to position
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:38'
}
SUSTIntersection >> createStrategy [
	^ (SUSTIntersectionRightOfWayStrategy newFromRoad: self)
]

{
	#category : #utility,
	#'squeak_changestamp' : 'PM 7/3/2024 00:20'
}
SUSTIntersection >> directions [
	^ {#Left -> {90. 0}. #Top -> {90. 270}. #Right -> {0. 270}} asDictionary
]

{
	#category : #utility,
	#'squeak_changestamp' : 'PM 7/3/2024 00:21'
}
SUSTIntersection >> drawingPoint [
	| drawingPoint |
	drawingPoint := self connectionPointPositions at: self drawingPointIndex copy.
	noExitAt ~= #Top
		ifTrue: [drawingPoint direction: drawingPoint direction negated].
	^ drawingPoint
]

{
	#category : #utility,
	#'squeak_changestamp' : 'PM 7/3/2024 00:20'
}
SUSTIntersection >> drawingPointIndex [
	^ self drawingPointIndices at: noExitAt
]

{
	#category : #utility,
	#'squeak_changestamp' : 'PM 7/3/2024 00:20'
}
SUSTIntersection >> drawingPointIndices [
	^ {#Left -> 2. #Top -> 1. #Right -> 3} asDictionary
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:40'
}
SUSTIntersection >> isBlockedFrom: aLane [ 
	^ (strategy isBlockedFrom: aLane)
]

{
	#category : #utility,
	#'squeak_changestamp' : 'PM 7/3/2024 00:08'
}
SUSTIntersection >> noExitAt: aDirection [
	noExitAt := aDirection
]

{
	#category : #utility,
	#'squeak_changestamp' : 'PM 7/3/2024 00:20'
}
SUSTIntersection >> positions [
	^ {#Left -> {2 negated @ 2. 0 @ 4}. #Top -> {2 negated @ 2. 2 @ 2}. #Right -> {0 @ 4. 2 @ 2}} asDictionary
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 13:41'
}
SUSTIntersection >> shouldGiveRightOfWay [

	longStandingCars size >= 3
		ifTrue: [^ true].
	^ false.
]
