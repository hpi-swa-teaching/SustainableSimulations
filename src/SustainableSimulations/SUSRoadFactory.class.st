Class {
	#name : #SUSRoadFactory,
	#superclass : #Object,
	#instVars : [
		'selectedRoadType',
		'simulation'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 22:24'
}
SUSRoadFactory class >> newForSimulation: aSimulation [
	^ self new simulation: aSimulation;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 19:49'
}
SUSRoadFactory >> askForDegrees [
	^ (UIManager default request: 'Please enter rotation degrees (0 < x < 180)' initialAnswer: 90) asNumber
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 13:07'
}
SUSRoadFactory >> buildCrossIntersectionFrom: aDirectedPoint to: aPoint [ 
	(self canBuildCrossIntersectionFrom: aDirectedPoint to: aPoint)
		ifFalse: [^ nil].
	^ SUSCrossIntersection
		newOnSimulation: simulation
		from: aDirectedPoint
		to: aPoint
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/17/2024 10:18'
}
SUSRoadFactory >> buildCurvyRoadFrom: aDirectedPoint to: aPoint [ 
	| degrees direction isUp|
	(self canBuildCurvyRoadFrom: aDirectedPoint to: aPoint)
		ifFalse: [^ nil].
	degrees := self askForDegrees.
	isUp := (aDirectedPoint asDirectedPoint isAbove: aPoint) > 0.
	isUp ifTrue: [degrees := 180 - degrees].
	direction := aDirectedPoint direction rotateBy: degrees degreesToRadians about: 0 @ 0.
	isUp ifTrue: [direction := direction negated].
	^ SUSCurvyRoad
		newOnSimulation: simulation
		from: aDirectedPoint
		to: (SUSDirectedPoint
				newWithPosition: aPoint
				inDirection: direction)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/13/2024 00:38'
}
SUSRoadFactory >> buildRoadFrom: aConnectionPoint to: aPoint [ 
	selectedRoadType = #StraightRoad
		ifTrue: [^ self buildStraightRoadFrom: aConnectionPoint to: aPoint].
	selectedRoadType = #CurvyRoad
		ifTrue: [^ self buildCurvyRoadFrom: aConnectionPoint to: aPoint].
	selectedRoadType = #CrossIntersection
		ifTrue: [^ self buildCrossIntersectionFrom: aConnectionPoint to: aPoint].
	^ false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 23:50'
}
SUSRoadFactory >> buildStraightRoadFrom: aConnectionPoint to: aPoint [ 
	(self canBuildStraightRoadFrom: aConnectionPoint to: aPoint)
		ifFalse: [^ nil].
	^ SUSStraightRoad
		newOnSimulation: simulation
		from: aConnectionPoint
		to: (aConnectionPoint asDirectedPoint projectionOf: aPoint)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 23:48'
}
SUSRoadFactory >> canBuildCrossIntersectionFrom: aConnectionPoint to: aPoint [
	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/17/2024 20:04'
}
SUSRoadFactory >> canBuildCurvyRoadFrom: aConnectionPoint to: aPoint [
	| directedPoint |
	self flag: #Todo. "calculate min road length; disallow illegal turns, needs aPoint to be a DirectedPoint"
	directedPoint := aConnectionPoint asDirectedPoint.
	^ ((directedPoint isBehind: aPoint) > 0) and: ((directedPoint isAbove: aPoint) ~= 0)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/13/2024 00:38'
}
SUSRoadFactory >> canBuildRoadFrom: aConnectionPoint to: aPoint [ 
	selectedRoadType = #StraightRoad
		ifTrue: [^ self canBuildStraightRoadFrom: aConnectionPoint to: aPoint].
	selectedRoadType = #CurvyRoad
		ifTrue: [^ self canBuildCurvyRoadFrom: aConnectionPoint to: aPoint].
	selectedRoadType = #CrossIntersection
		ifTrue: [^ self canBuildCrossIntersectionFrom: aConnectionPoint to: aPoint].
	^ false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/17/2024 10:32'
}
SUSRoadFactory >> canBuildStraightRoadFrom: aConnectionPoint to: aPoint [ 
	^ ((aConnectionPoint asDirectedPoint isBehind: aPoint) > 0)
		and: (aConnectionPoint asDirectedPoint linearDist: aPoint)
				>= self minRoadLength
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 19:44'
}
SUSRoadFactory >> initialize [
	selectedRoadType := #StraightRoad
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 19:45'
}
SUSRoadFactory >> minRoadLength [
	^ 50
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:53'
}
SUSRoadFactory >> selectedRoadType [
	^ selectedRoadType
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:53'
}
SUSRoadFactory >> selectedRoadType: anObject [
	selectedRoadType := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:24'
}
SUSRoadFactory >> simulation: anObject [
	simulation := anObject
]
