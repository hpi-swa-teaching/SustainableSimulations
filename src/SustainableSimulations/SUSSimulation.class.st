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
		'buildMode'
	],
	#category : #SustainableSimulations
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
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:31'
}
SUSSimulation >> buildRoad [
	self buildMode = 'straightroad'
		ifTrue: [^ self clickedConnectionPoint connectStraightRoadFromMousePos: Sensor cursorPoint].
	self buildMode = 'crossintersection'
		ifTrue: [^ self clickedConnectionPoint connectCrossIntersectionFromMousePos: Sensor cursorPoint].
		^ false.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:22'
}
SUSSimulation >> buildRoadWithMousePos: mousePos [

	(self buildMode = 'straightroad') ifTrue: [
		self clickedConnectionPoint connectStraightRoadFromMousePos: mousePos].
	(self buildMode = 'intersection') ifTrue: [
		self clickedConnectionPoint connectCrossIntersectionFromMousePos: mousePos
		]
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/4/2024 01:08'
}
SUSSimulation >> checkDistance [

	|previousCar|
	previousCar := nil.
	
	cars do: [:car |
            previousCar ifNotNil: [
                ((previousCar position - car position) x < 50) ifTrue: [
                    car speed: previousCar speed;
				timeSpeedChange: Time millisecondClock]].
            previousCar := car. ].

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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/28/2024 18:25'
}
SUSSimulation >> demoRoadWithCar [
	|car road|
	
	road := SUSDrawing newNormalRoadWithLength: 1000.
	car := SUSCar new.
	road openInWorld;
		position: 100@100.
	
	bezierCurve := SUSBezierCurve new.
	bezierCurve addControlPoint: (road position x)@(road position y + (2* road extent y / 3));
		addControlPoint: (road position x + 1000)@(road position y + (2* road extent y / 3)).
	
	car openInWorld;
		position: bezierCurve controlPoints first.
	
	cars add: car.
	roads add: road.

]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:21'
}
SUSSimulation >> initialize [
	super initialize.
	
	roadToConnect := nil.
	
	self color: Color gray.
	
	cars := OrderedCollection new.
	roads := OrderedCollection new.
	simulationSpeed := 1.
	
	self addClickHandler.
	self addStartingPoint.
	self buildMode: 'straightroad'
	
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
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:29'
}
SUSSimulation >> notifyClickedAtMousePos [
	| t |
	self clickedConnectionPoint
		ifNotNil: [t := (self buildRoad). t ifTrue: [
			self clickedConnectionPoint: nil]]
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 5/28/2024 02:08'
}
SUSSimulation >> pauseSimulation [
	Transcript show: 'Pause Simulation'
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 5/28/2024 02:08'
}
SUSSimulation >> playSimulation [
	Transcript show: 'Play Simulation'
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
	#'squeak_changestamp' : 'MK 6/4/2024 00:05'
}
SUSSimulation >> step [

	cars do: [:car | 
		car move].
	self checkDistance.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/4/2024 01:15'
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
