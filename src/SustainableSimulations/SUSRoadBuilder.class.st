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
	#'squeak_changestamp' : 'PM 7/10/2024 12:50'
}
SUSRoadBuilder >> buildCrossIntersection [
	self statusCrossIntersection == 0
		ifFalse: [^ nil].
	^ SUSCrossIntersection
		newOnSimulation: simulation
		from: from
		to: to
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 12:50'
}
SUSRoadBuilder >> buildCurvyRoad [
	self statusCurvyRoad == 0
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
	#'squeak_changestamp' : 'PM 7/10/2024 13:01'
}
SUSRoadBuilder >> buildStraightRoad [
	self statusStraightRoad == 0
		ifFalse: [^ nil].
	^ SUSStraightRoad
		newOnSimulation: simulation
		from: from
		to: to
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 13:02'
}
SUSRoadBuilder >> buildTIntersection [
	self statusTIntersection == 0
		ifFalse: [^ nil].
	^ SUSTIntersection
		newOnSimulation: simulation
		from: from
		to: to
		noExitAt: (from asDirectedPoint directionOf: self toPoint)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 13:02'
}
SUSRoadBuilder >> buildTunnel [
	self statusTunnel == 0
		ifFalse: [^ nil].
	^ SUSTunnel
		newOnSimulation: simulation
		from: from
		to: to
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 12:56'
}
SUSRoadBuilder >> errorMessage [
	self status <= 0
		ifTrue: [^ 'No error']
		ifFalse: [^ self errorMessages at: self status]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 13:00'
}
SUSRoadBuilder >> errorMessages [
	^ {'Invalid Road'.
	'You cannot build a road in wrong direction'.
	'The road is too short'.
	'You cannot build a straight curvy road. Please select the straight road'.
	'This curve is not possible'}
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
	#'squeak_changestamp' : 'PM 7/10/2024 12:52'
}
SUSRoadBuilder >> isValid [
	^ self status == 0
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 12:52'
}
SUSRoadBuilder >> status [
	selectedRoadType = #StraightRoad
		ifTrue: [^ self statusStraightRoad].
	selectedRoadType = #CurvyRoad
		ifTrue: [^ self statusCurvyRoad].
	selectedRoadType = #CrossIntersection
		ifTrue: [^ self statusCrossIntersection].
	selectedRoadType = #TIntersection
		ifTrue: [^ self statusTIntersection].
	selectedRoadType = #Tunnel
		ifTrue: [^ self statusTunnel].
	^ 1
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 12:48'
}
SUSRoadBuilder >> statusCrossIntersection [
	invalid
		ifTrue: [^ 1].
	^ 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 12:50'
}
SUSRoadBuilder >> statusCurvyRoad [
	| directedPoint midpoint |
	invalid
		ifTrue: [^ 1].
	directedPoint := from asDirectedPoint.
	midpoint := directedPoint calculateIntersectionPoint: self toDirectedPoint.
	(directedPoint isBehind: self toPoint) <= 0
		ifTrue: [^ 2].
	(directedPoint isAbove: self toPoint) == 0
		ifTrue: [^ 4].
	(directedPoint isBehind: midpoint) <= 0
		ifTrue: [^ 5].
	^ 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 13:02'
}
SUSRoadBuilder >> statusStraightRoad [
	(from asDirectedPoint isBehind: self toPoint)
			<= 0
		ifTrue: [^ 2].
	(from asDirectedPoint linearDist: self toPoint)
			< self minRoadLength
		ifTrue: [^ 3].
	invalid
		ifTrue: [^ 1].
	^ 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 12:48'
}
SUSRoadBuilder >> statusTIntersection [
	(from asDirectedPoint directionOf: self toPoint)
			== #Bottom
		ifTrue: [^ 2].
	invalid
		ifTrue: [^ 1].
	^ 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 12:47'
}
SUSRoadBuilder >> statusTunnel [
	invalid
		ifTrue: [^ 1].
	^ 0
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
