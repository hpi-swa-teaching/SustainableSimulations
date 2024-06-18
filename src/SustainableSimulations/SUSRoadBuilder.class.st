Class {
	#name : #SUSRoadBuilder,
	#superclass : #Object,
	#instVars : [
		'selectedRoadType',
		'simulation',
		'from',
		'to'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 13:42'
}
SUSRoadBuilder class >> newForSimulation: aSimulation from: aPoint to: anotherPoint as: aSymbol [
	^ self new simulation: aSimulation;
		from: aPoint;
		to: anotherPoint;
		selectedRoadType: aSymbol;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 14:16'
}
SUSRoadBuilder >> addDirectionToTo [
	selectedRoadType == #CurvyRoad
		ifTrue: [self addUserDirectionToTo]
		ifFalse: [self addFromDirectionToTo]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 14:15'
}
SUSRoadBuilder >> addFromDirectionToTo [
	to := SUSDirectedPoint newWithPosition: to inDirection: from direction
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 14:14'
}
SUSRoadBuilder >> addUserDirectionToTo [
	| degrees direction isUp |
	degrees := self askForDegrees.
	degrees > 0
		ifTrue: [isUp := (from asDirectedPoint isAbove: to) > 0.
			isUp ifTrue: [degrees := 180 - degrees].
			direction := from direction rotateBy: degrees degreesToRadians about: 0 @ 0.
			isUp ifTrue: [direction := direction negated].
			to := SUSDirectedPoint newWithPosition: to inDirection: direction]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 14:11'
}
SUSRoadBuilder >> askForDegrees [
	| degrees |
	[degrees := (UIManager default request: 'Please enter rotation degrees (0 < x < 180)' initialAnswer: 90) asNumber]
		on: NumberParserError
		do: [:e | degrees := 0].
	(degrees < 1 or: degrees > 179)
		ifTrue: [^ 0]
		ifFalse: [^ degrees]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 14:41'
}
SUSRoadBuilder >> buildCrossIntersection [
	self canBuildCrossIntersection
		ifFalse: [^ nil].
	^ SUSCrossIntersection
		newOnSimulation: simulation
		from: from
		to: to
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 14:41'
}
SUSRoadBuilder >> buildCurvyRoad [
	self canBuildCurvyRoad
		ifFalse: [^ nil].
	^ SUSCurvyRoad
		newOnSimulation: simulation
		from: from
		to: to
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 14:38'
}
SUSRoadBuilder >> buildRoad [
	selectedRoadType = #StraightRoad
		ifTrue: [^ self buildStraightRoad ].
	selectedRoadType = #CurvyRoad
		ifTrue: [^ self buildCurvyRoad ].
	selectedRoadType = #CrossIntersection
		ifTrue: [^ self buildCrossIntersection ].
	^ false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 14:41'
}
SUSRoadBuilder >> buildStraightRoad [
	self canBuildStraightRoad
		ifFalse: [^ nil].
	^ SUSStraightRoad
		newOnSimulation: simulation
		from: from
		to: to
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 13:46'
}
SUSRoadBuilder >> canBuildCrossIntersection [
	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 14:20'
}
SUSRoadBuilder >> canBuildCurvyRoad [
	| directedPoint midpoint |
	self flag: #Todo. "calculate min road length"
	directedPoint := from asDirectedPoint.
	midpoint := directedPoint calculateIntersectionPoint: self toDirectedPoint.
	^ (directedPoint isBehind: self toPoint) > 0
		and: (directedPoint isAbove: self toPoint) ~= 0
		and: (directedPoint isBehind: midpoint) > 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 13:55'
}
SUSRoadBuilder >> canBuildStraightRoad [
	^ ((from asDirectedPoint isBehind: self toPoint) > 0)
		and: (from asDirectedPoint linearDist: self toPoint)
				>= self minRoadLength
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 13:39'
}
SUSRoadBuilder >> from: anObject [
	from := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 19:44'
}
SUSRoadBuilder >> initialize [
	selectedRoadType := #StraightRoad
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 13:47'
}
SUSRoadBuilder >> isValid [
	selectedRoadType = #StraightRoad
		ifTrue: [^ self canBuildStraightRoad].
	selectedRoadType = #CurvyRoad
		ifTrue: [^ self canBuildCurvyRoad].
	selectedRoadType = #CrossIntersection
		ifTrue: [^ self canBuildCrossIntersection].
	^ false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 19:45'
}
SUSRoadBuilder >> minRoadLength [
	^ 50
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:53'
}
SUSRoadBuilder >> selectedRoadType [
	^ selectedRoadType
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 14:16'
}
SUSRoadBuilder >> selectedRoadType: anObject [ 
	selectedRoadType := anObject.
	to basicType == #Point
		ifTrue: [anObject == #StraightRoad
				ifTrue: [to := from asDirectedPoint projectionOf: to].
			self addDirectionToTo]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:24'
}
SUSRoadBuilder >> simulation: anObject [
	simulation := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 13:41'
}
SUSRoadBuilder >> to: anObject [
	to := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 13:58'
}
SUSRoadBuilder >> toDirectedPoint [
	to basicType = #SUSDirectedPoint
		ifTrue: [^ to].
	to basicType = #SUSConnectionPoint
		ifTrue: [^ to asDirectedPoint].
	^ nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 13:58'
}
SUSRoadBuilder >> toPoint [
	to basicType = #SUSDirectedPoint
		ifTrue: [^ to position].
	to basicType = #SUSConnectionPoint
		ifTrue: [^ to center].
	^ nil
]
