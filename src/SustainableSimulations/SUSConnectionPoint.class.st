Class {
	#name : #SUSConnectionPoint,
	#superclass : #CircleMorph,
	#instVars : [
		'direction',
		'road',
		'simulation',
		'isStartingPoint',
		'adjacentConnectionPoint'
	],
	#category : #SustainableSimulations
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 09:32'
}
SUSConnectionPoint class >> newAsStartingPointForSimulation: aSimulation withDirection: aPoint [
	^ self new road: aSimulation;
		direction: aPoint;
		isStartingPoint: true;
		isFixed;
		yourself
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 6/11/2024 01:06'
}
SUSConnectionPoint class >> newAtPosition: aPoint withDirection: anotherPoint [
	^ self new position: aPoint;
		direction: anotherPoint;
		isStartingPoint: false;
		yourself
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 08:59'
}
SUSConnectionPoint class >> newForRoad: aRoad withDirection: aPoint [
	^ self new road: aRoad;
		direction: aPoint;
		isStartingPoint: false;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 09:17'
}
SUSConnectionPoint >> adjacentConnectionPoint [
	^ adjacentConnectionPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 09:17'
}
SUSConnectionPoint >> adjacentConnectionPoint: anObject [
	adjacentConnectionPoint := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 01:15'
}
SUSConnectionPoint >> askForDegrees [
	^ (UIManager default request: 'Please enter rotation degrees (+ = Clockwise, - = Counterclockwise)' initialAnswer: 90) asNumber
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:00'
}
SUSConnectionPoint >> center [
	self road
		ifNotNil: [self road isFlexed
				ifTrue: [^ self rotatedCenter]].
	^ super center
]

{
	#category : #connection,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 19:21'
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
	#'squeak_changestamp' : 'PM 6/11/2024 01:24'
}
SUSConnectionPoint >> connectCurvyRoadFromMousePos: mousePos [ 
	| simulation newDirection connectionPointB newRoad |
	self isStartingPoint
		ifTrue: [simulation := self road]
		ifFalse: [simulation := self road simulation].
	newDirection := self direction rotateBy: self askForDegrees about: 0@0.
	connectionPointB := SUSConnectionPoint newAtPosition: mousePos withDirection: newDirection.
	newRoad := SUSCurvyRoad newOnSimulation: simulation from: self to: connectionPointB withSpeedLimit: 50.
	newRoad position: self center.
			newRoad sticky: true.
			simulation addMorph: newRoad.
	^ true
]

{
	#category : #connection,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 19:29'
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
	#'squeak_changestamp' : 'PM 5/27/2024 23:00'
}
SUSConnectionPoint >> direction [
	^ direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:00'
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
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 09:22'
}
SUSConnectionPoint >> handleMouseDown: anEvent [ 
	| simulation |
	self color: Color red.
	self isStartingPoint
		ifTrue: [simulation := self road]
		ifFalse: [simulation := self road simulation].
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
	#'squeak_changestamp' : 'PM 5/28/2024 00:48'
}
SUSConnectionPoint >> initialize [
	super initialize.
	
	self color: Color green
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 09:33'
}
SUSConnectionPoint >> isFixed [

	^ true.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 08:58'
}
SUSConnectionPoint >> isStartingPoint [
	^ isStartingPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 08:58'
}
SUSConnectionPoint >> isStartingPoint: anObject [
	isStartingPoint := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:00'
}
SUSConnectionPoint >> road [
	^ road
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:00'
}
SUSConnectionPoint >> road: anObject [
	road := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 21:13'
}
SUSConnectionPoint >> rotatedCenter [
	| dir rotation |
	dir := self extent / 2.
	rotation := self road rotationDegrees / 360 * 2 * 3.1415926.
	^ self positionInWorld + (dir x * rotation cos + (dir y * rotation sin negated) @ (dir x * rotation sin + (dir y * rotation cos)))
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
