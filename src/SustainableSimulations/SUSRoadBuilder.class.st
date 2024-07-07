Class {
	#name : #SUSRoadBuilder,
	#superclass : #Object,
	#instVars : [
		'selectedRoadType',
		'simulation',
		'from',
		'to',
		'invalid'
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
	#'squeak_changestamp' : 'PM 6/18/2024 19:16'
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
		ifFalse: [degrees = 0
				ifTrue: [self selectedRoadType: #StraightRoad]
				ifFalse: [invalid := true]]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 02:17'
}
SUSRoadBuilder >> askForDegrees [
	| degrees |
	[degrees := (UIManager default request: 'Please enter rotation degrees (0 < x < 180)' initialAnswer: 90) asNumber]
		on: NumberParserError
		do: [:e | degrees := -1].
	(degrees < 0 or: degrees > 179)
		ifTrue: [^ -1]
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
	#'squeak_changestamp' : 'Len 7/7/2024 19:06'
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
	#'squeak_changestamp' : 'PM 6/27/2024 10:07'
}
SUSRoadBuilder >> buildRoad [
	selectedRoadType = #StraightRoad
		ifTrue: [^ self buildStraightRoad ].
	selectedRoadType = #CurvyRoad
		ifTrue: [^ self buildCurvyRoad ].
	selectedRoadType = #CrossIntersection
		ifTrue: [^ self buildCrossIntersection ].
	selectedRoadType = #TIntersection
		ifTrue: [^ self buildTIntersection ].
	selectedRoadType = #Tunnel
		ifTrue: [^ self buildTunnel ].
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
	#'squeak_changestamp' : 'PM 7/3/2024 00:08'
}
SUSRoadBuilder >> buildTIntersection [
	self canBuildTIntersection
		ifFalse: [^ nil].
	^ SUSTIntersection
		newOnSimulation: simulation
		from: from
		to: to
		noExitAt: (from asDirectedPoint directionOf: self toPoint)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/20/2024 19:13'
}
SUSRoadBuilder >> buildTunnel [
	self canBuildTunnel
		ifFalse: [^ nil].
	^ SUSTunnel
		newOnSimulation: simulation
		from: from
		to: to
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 18:53'
}
SUSRoadBuilder >> canBuildCrossIntersection [
	^ invalid not
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 18:58'
}
SUSRoadBuilder >> canBuildCurvyRoad [
	| directedPoint midpoint |
	self flag: #Todo. "calculate min road length"
	invalid ifTrue: [^ false ].
	directedPoint := from asDirectedPoint.
	midpoint := directedPoint calculateIntersectionPoint: self toDirectedPoint.
	^ (directedPoint isBehind: self toPoint) > 0
		and: (directedPoint isAbove: self toPoint) ~= 0
		and: (directedPoint isBehind: midpoint) > 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/18/2024 18:53'
}
SUSRoadBuilder >> canBuildStraightRoad [
	^ ((from asDirectedPoint isBehind: self toPoint) > 0)
		and: (from asDirectedPoint linearDist: self toPoint) >= self minRoadLength
		and: invalid not
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/2/2024 23:44'
}
SUSRoadBuilder >> canBuildTIntersection [
	^ (from asDirectedPoint directionOf: self toPoint)
		~= #Bottom and: invalid not
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/20/2024 19:10'
}
SUSRoadBuilder >> canBuildTunnel [
	^ invalid not
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
	#'squeak_changestamp' : 'PM 6/18/2024 18:52'
}
SUSRoadBuilder >> initialize [
	selectedRoadType := #StraightRoad.
	invalid := false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/27/2024 10:06'
}
SUSRoadBuilder >> isValid [
	selectedRoadType = #StraightRoad
		ifTrue: [^ self canBuildStraightRoad].
	selectedRoadType = #CurvyRoad
		ifTrue: [^ self canBuildCurvyRoad].
	selectedRoadType = #CrossIntersection
		ifTrue: [^ self canBuildCrossIntersection].
	selectedRoadType = #TIntersection
		ifTrue: [^ self canBuildTIntersection].
	selectedRoadType = #Tunnel
		ifTrue: [^ self canBuildTunnel].
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
