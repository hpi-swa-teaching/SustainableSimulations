"
A SUSTIntersection is an intersection road which looks link a T.

Instance Variables
	noExitAt:		Symbol (#Top, #Left, #Right)

noExitAt
	- In this direction there is no exit. #Bottom is the direction of the (first) connecting SUSConnectionPoint

"
Class {
	#name : #SUSTIntersection,
	#superclass : #SUSAbstractIntersection,
	#instVars : [
		'noExitAt'
	],
	#category : #'SustainableSimulations-Roads',
	#'squeak_changestamp' : 'PM 7/11/2024 20:08'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 7/11/2024 18:40'
}
SUSTIntersection class >> newOnSimulation: aSimulation from: aConnectionPoint to: aPoint noExitAt: aDirection [ 
	^ self new simulation: aSimulation;
		 noExitAt: aDirection;
		 initializeFrom: aConnectionPoint to: aPoint;
		 postInitialize;
		 yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 20:10'
}
SUSTIntersection >> connectionPointPositions [
	| positions directions |
	positions := (self positions at: noExitAt)
				* SUSDrawing normalLaneWidth.
	directions := (self directions at: noExitAt)
				collect: [:each | from direction rotateBy: each degreesToRadians about: 0 @ 0].
	^ {from}
		, ((1 to: 2)
				collect: [:index | SUSDirectedPoint
						newWithPosition: (from
								absoluteOffset: (positions at: index))
						inDirection: (directions at: index)])
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSTIntersection >> createDrawing [
	^ SUSTIntersectionDrawing newFrom: self drawingPoint to: to position
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/11/2024 19:58'
}
SUSTIntersection >> createStrategy [
	^ SUSTIntersectionRightBeforeLeftStrategy newFromRoad: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:20'
}
SUSTIntersection >> directions [
	^ {#Left -> {90. 0}. #Top -> {90. 270}. #Right -> {0. 270}} asDictionary
]

{
	#category : #accessing,
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
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:20'
}
SUSTIntersection >> drawingPointIndex [
	^ self drawingPointIndices at: noExitAt
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:20'
}
SUSTIntersection >> drawingPointIndices [
	^ {#Left -> 2. #Top -> 1. #Right -> 3} asDictionary
]

{
	#category : #'right of way',
	#'squeak_changestamp' : 'PM 7/11/2024 20:10'
}
SUSTIntersection >> isBlockedFrom: aLane [ 
	^ strategy isBlockedFrom: aLane
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:08'
}
SUSTIntersection >> noExitAt: aDirection [
	noExitAt := aDirection
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:20'
}
SUSTIntersection >> positions [
	^ {#Left -> {2 negated @ 2. 0 @ 4}. #Top -> {2 negated @ 2. 2 @ 2}. #Right -> {0 @ 4. 2 @ 2}} asDictionary
]

{
	#category : #'right of way',
	#'squeak_changestamp' : 'PM 7/11/2024 20:09'
}
SUSTIntersection >> shouldGiveRightOfWay [
	^ longStandingVehicles size >= 3
]
