Class {
	#name : #SUSSimulation,
	#superclass : #PasteUpMorph,
	#instVars : [
		'roadToConnect',
		'cars',
		'simulationSpeed',
		'roads',
		'bezierCurve',
		'clickHandler',
		'clickedConnectionPoint',
		'running',
		'timePaused',
		'buildMode'
	],
	#category : 'SustainableSimulations'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:50'
}
SUSSimulation >> addCar: aCar [
	cars addLast: aCar
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:28'
}
SUSSimulation >> addClickHandler [

	| ch |
	ch := SUSClickHandler new 
		position: 0@0;
		extent: (Display width @ Display height);
		color: Color transparent;
		sticky: true;
		simulation: self.
	self addMorph: ch.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:25'
}
SUSSimulation >> addRoad: aRoad [
	roads addLast: aRoad
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 13:36'
}
SUSSimulation >> addStartingPoint [

	| startingPoint |
	startingPoint := (SUSConnectionPoint newAsStartingPointForSimulation: self withDirection: (1@0))
		center: (self position + (300@200));
		sticky: true;
		yourself.
	self addMorph: startingPoint.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:09'
}
SUSSimulation >> buildMode [
	^ buildMode
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:09'
}
SUSSimulation >> buildMode: anObject [
	buildMode := anObject
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/11/2024 01:01'
}
SUSSimulation >> buildRoad [
	self buildMode = #StraightRoad
		ifTrue: [^ self clickedConnectionPoint connectStraightRoadFromMousePos: Sensor cursorPoint].
	self buildMode = #CurvyRoad
		ifTrue: [^ self clickedConnectionPoint connectCurvyRoadFromMousePos: Sensor cursorPoint].
	self buildMode = #CrossIntersection
		ifTrue: [^ self clickedConnectionPoint connectCrossIntersectionFromMousePos: Sensor cursorPoint].
		^ false.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/11/2024 00:54'
}
SUSSimulation >> buildRoadWithMousePos: mousePos [

	(self buildMode = #StraightRoad) ifTrue: [
		self clickedConnectionPoint connectStraightRoadFromMousePos: mousePos].
	(self buildMode = #CrossIntersection) ifTrue: [
		self clickedConnectionPoint connectCrossIntersectionFromMousePos: mousePos
		]
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:13'
}
SUSSimulation >> clickHandler [
	^ clickHandler
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:13'
}
SUSSimulation >> clickHandler: anObject [
	clickHandler := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:29'
}
SUSSimulation >> clickedConnectionPoint [
	^ clickedConnectionPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:29'
}
SUSSimulation >> clickedConnectionPoint: anObject [
	clickedConnectionPoint := anObject
]

{
	#category : #connection,
	#'squeak_changestamp' : 'Len 6/1/2024 21:05'
}
SUSSimulation >> connectRoad: aRoad with: anotherRoad [
	anotherRoad isFixed
		ifTrue: [ anotherRoad connectWith: aRoad ]
		ifFalse: [ aRoad connectWith: anotherRoad ].
	aRoad updateLanes: anotherRoad.
	anotherRoad updateLanes: aRoad.
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 5/28/2024 01:58'
}
SUSSimulation >> connectSavedRoadWith: aRoad [
	roadToConnect == aRoad
		ifFalse: [ self connectRoad: roadToConnect with: aRoad ].
	roadToConnect  := nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:43'
}
SUSSimulation >> defaultSpeedLimit [
	^ 50
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/11/2024 00:55'
}
SUSSimulation >> initialize [
	super initialize.
	
	roadToConnect := nil.
	
	self color: Color gray.
	
	cars := OrderedCollection new.
	roads := OrderedCollection new.
	simulationSpeed := 1.
	running := true. 
	timePaused := 0.
	
	self addClickHandler.
	self addStartingPoint.
	self buildMode: #StraightRoad.
	
	
	"self demoRoadWithCar."
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:33'
}
SUSSimulation >> notifyClickedAt: aConnectionPoint [

	self clickedConnectionPoint ifNil: [
		aConnectionPoint color: Color red.
		self clickedConnectionPoint: aConnectionPoint]
	ifNotNil: [
		self clickedConnectionPoint color: Color green. 
		(aConnectionPoint == self clickedConnectionPoint) ifTrue: [self clickedConnectionPoint: nil]
		ifFalse: [self clickedConnectionPoint: aConnectionPoint]].
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/11/2024 01:01'
}
SUSSimulation >> notifyClickedAtMousePos [
	self clickedConnectionPoint
		ifNotNil: [self buildRoad
				ifTrue: [self clickedConnectionPoint: nil]]
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'MK 6/10/2024 17:19'
}
SUSSimulation >> pauseSimulation [
	running ifTrue: [
		super stopStepping.
		timePaused := Time millisecondClock.
		running := false]
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'GoChriNo 6/15/2024 19:24'
}
SUSSimulation >> playSimulation [
	running ifFalse: [
		(timePaused > 0) ifTrue: [
			cars do: [:car | 
				car lastTime: Time millisecondClock]].
		super startStepping.
		timePaused := 0.
		running := true]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:38'
}
SUSSimulation >> roads [
	^ roads
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:16'
}
SUSSimulation >> step [

	cars do: [:car | 
		car applyBehavior.
		"car move"]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 14:58'
}
SUSSimulation >> stepTime [
	^10
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 5/28/2024 02:08'
}
SUSSimulation >> stopSimulation [
	Transcript show: 'Stop Simulation'
]
