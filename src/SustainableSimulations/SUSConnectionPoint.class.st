Class {
	#name : #SUSConnectionPoint,
	#superclass : #CircleMorph,
	#instVars : [
		'direction',
		'firstRoad',
		'secondRoad',
		'simulation',
		'isStartingPoint',
		'adjacentConnectionPoint'
	],
	#category : #'SustainableSimulations-Core'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 6/12/2024 23:41'
}
SUSConnectionPoint class >> newForRoad: aRoad at: aDirectedPoint [
	^ self new simulation: aRoad simulation;
		connectRoad: aRoad;
		center: aDirectedPoint position;
		direction: aDirectedPoint direction;
		yourself
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 6/12/2024 23:39'
}
SUSConnectionPoint class >> newStartingPointForSimulation: aSimulation at: aPoint [
	^ self new simulation: aSimulation;
		center: aPoint;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 09:17'
}
SUSConnectionPoint >> adjacentConnectionPoint: anObject [
	adjacentConnectionPoint := anObject
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 22:28'
}
SUSConnectionPoint >> asDirectedPoint [
	^ SUSDirectedPoint newWithPosition: self center inDirection: self direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:39'
}
SUSConnectionPoint >> askForDegrees [
	^ (UIManager default request: 'Please enter rotation degrees (0 < x < 180)' initialAnswer: 90) asNumber
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 6/11/2024 02:52'
}
SUSConnectionPoint >> connectCrossIntersectionFromMousePos: mousePos [
	| simulation connectingIndex newRoad |
	self isStartingPoint
		ifTrue: [simulation := self road]
		ifFalse: [simulation := self road simulation].
	connectingIndex := 1.
	self direction y = -1
		ifTrue: [connectingIndex := 4].
	self direction x = -1
		ifTrue: [connectingIndex := 3].
	self direction y = 1
		ifTrue: [connectingIndex := 2].
	adjacentConnectionPoint
		ifNil: [newRoad := SUSCrossIntersection newOnSimulation: simulation.
			newRoad center: self center + (self direction * 0.999999999999 * (SUSDrawing normalLaneWidth * 2)).
			newRoad sticky: true.
			simulation addMorph: newRoad.
			self isStartingPoint
				ifTrue: [(newRoad connectionPoints at: connectingIndex)
						direction: self direction negated]
				ifFalse: [self road updateLanes: newRoad.
					self
						connectWithConnectionPoint: (newRoad connectionPoints at: connectingIndex).
					newRoad
						removeMorph: (newRoad connectionPoints at: connectingIndex)].
			self road removeMorph: self].
	^ true
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 6/11/2024 05:39'
}
SUSConnectionPoint >> connectCurvyRoadFromMousePos: mousePos [ 
	| simulation connectingIndex newRoad newDirection point degrees |
	degrees := self askForDegrees.
	((degrees ~= 0) and: (degrees < 180) and: degrees > -180)
		ifFalse: [^ false].
	newDirection := 1@0 rotateBy: degrees degreesToRadians about: 0@0.
	self isStartingPoint
		ifTrue: [simulation := self road]
		ifFalse: [simulation := self road simulation].
	connectingIndex := 2.
	self direction x >= 0
		ifTrue: [connectingIndex := 1.
			(self direction x = 0 and: self direction y <= 0)
				ifTrue: [connectingIndex := 2]].
	adjacentConnectionPoint
		ifNil: [
			point := mousePos - self center.
			newRoad := SUSCurvyRoad newOnSimulation: simulation to: point withDegrees: degrees withSpeedLimit: 50.
			newRoad position: self center + newRoad deltaPositionToConnectionPoint.
			newRoad sticky: true.
			simulation addMorph: newRoad.
			self isStartingPoint
				ifTrue: [(newRoad connectionPoints at: connectingIndex)
						direction: self direction negated]
				ifFalse: [self road updateLanes: newRoad.
					self
						connectWithConnectionPoint: (newRoad connectionPoints at: connectingIndex).
					newRoad
						removeMorph: (newRoad connectionPoints at: connectingIndex)].
			self road removeMorph: self].
	^ true
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/13/2024 00:17'
}
SUSConnectionPoint >> connectRoad: aRoad [ 
	isStartingPoint
		ifTrue: [firstRoad := aRoad]
		ifFalse: [secondRoad := aRoad.
			firstRoad updateLanes: secondRoad.
			simulation removeMorph: self].
	isStartingPoint := false
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 6/11/2024 02:52'
}
SUSConnectionPoint >> connectStraightRoadFromMousePos: mousePos [ 
	| simulation connectingIndex newRoad length degrees |
	length := self getLengthFromMousePos: mousePos.
	length <= 50
		ifTrue: [^ false].
	self isStartingPoint
		ifTrue: [simulation := self road]
		ifFalse: [simulation := self road simulation].
	connectingIndex := 2.
	self direction x >= 0
		ifTrue: [connectingIndex := 1.
			(self direction x = 0 and: self direction y <= 0)
				ifTrue: [connectingIndex := 2]].
	adjacentConnectionPoint
		ifNil: [newRoad := SUSStraightRoad
						newOnSimulation: simulation
						withLength: length
						withSpeedLimit: 50.
			newRoad center: self center + (self direction * 0.999999999999 * (length / 2)).
			newRoad sticky: true.
			simulation addMorph: newRoad.
			degrees := self direction degrees.
			degrees > 270
				ifFalse: [degrees > 90
						ifTrue: [degrees := degrees - 180]].
			newRoad rotationDegrees: degrees.
			(newRoad connectionPoints at: connectingIndex \\ 2 + 1)
				direction: self direction.
			self isStartingPoint
				ifTrue: [(newRoad connectionPoints at: connectingIndex)
						direction: self direction negated]
				ifFalse: [self road updateLanes: newRoad.
					self
						connectWithConnectionPoint: (newRoad connectionPoints at: connectingIndex).
					newRoad
						removeMorph: (newRoad connectionPoints at: connectingIndex)].
			self road removeMorph: self].
	^ true
]

{
	#category : #connection,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 13:17'
}
SUSConnectionPoint >> connectWithConnectionPoint: aConenctionPoint [

	self adjacentConnectionPoint: aConenctionPoint.
	aConenctionPoint adjacentConnectionPoint: self.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:28'
}
SUSConnectionPoint >> direction [
	^ direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:28'
}
SUSConnectionPoint >> direction: anObject [
	direction := anObject
]

{
	#category : #connection,
	#'squeak_changestamp' : 'GoChriNo 6/6/2024 09:20'
}
SUSConnectionPoint >> getLengthFromMousePos: mousePos [ 
	| x |
	x := mousePos - self center.
	"rotation for startingpoint?
	self isStartingPoint
		ifTrue: [self direction: x normalized.
			^ 0 @ 0 dist: x]
		ifFalse: ["^ self direction dotProduct: x normalized
					* (0 @ 0 dist: x)"]"
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 23:32'
}
SUSConnectionPoint >> handleMouseDown: anEvent [
	simulation notifyClickedAt: self
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 5/27/2024 23:02'
}
SUSConnectionPoint >> handlesMouseDown: anEvent [
	^ true
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 23:41'
}
SUSConnectionPoint >> initialize [
	super initialize.
	
	isStartingPoint := true.
	direction := 0@0.
	
	self color: Color green;
		sticky: true;
		morphicLayerNumber: 20
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 23:52'
}
SUSConnectionPoint >> isStartingPoint [
	^ isStartingPoint
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:16'
}
SUSConnectionPoint >> select [
	self color: Color red
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 08:56'
}
SUSConnectionPoint >> simulation [
	^ simulation
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 08:56'
}
SUSConnectionPoint >> simulation: anObject [
	simulation := anObject
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 5/28/2024 00:48'
}
SUSConnectionPoint >> unselect [
	self color: Color green
]
