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
		'spawnClass'
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
	#category : #simulation,
	#'squeak_changestamp' : 'PM 6/12/2024 19:01'
}
SUSSimulation >> clickedWorld: anEvent [
	Transcript show: 'Hello'
"	clickedConnectionPoint
		ifNotNil: [(self tryToBuildRoadTo: anEvent position)
				ifTrue: [clickedConnectionPoint := nil]]"
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
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 18:42'
}
SUSSimulation >> handlesMouseDown: anEvent [
	^ true
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 18:53'
}
SUSSimulation >> initialize [
	super initialize.
	
	self color: Color gray.
	
	roadToConnect := nil.
	cars := OrderedCollection new.
	roads := OrderedCollection new.
	simulationSpeed := 1.
	running := true. 
	timePaused := 0.
	spawnClass := SUSStraightRoad class.
	
	self addStartingPoint.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 19:04'
}
SUSSimulation >> mouseDown: anEvent [ 
	super mouseDown: anEvent.
	self submorphs
		detect: [:each | each containsPoint: anEvent position]
		ifNone: [self clickedWorld]
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 18:56'
}
SUSSimulation >> notifyClickedAt: aConnectionPoint [

	clickedConnectionPoint ifNil: [
		aConnectionPoint color: Color red.
		clickedConnectionPoint := aConnectionPoint]
	ifNotNil: [
		self clickedConnectionPoint color: Color green. 
		(aConnectionPoint == self clickedConnectionPoint) ifTrue: [clickedConnectionPoint := nil]
		ifFalse: [ clickedConnectionPoint := aConnectionPoint ]].
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
	#'squeak_changestamp' : 'MK 6/10/2024 18:06'
}
SUSSimulation >> playSimulation [
	running ifFalse: [
		(timePaused > 0) ifTrue: [
			cars do: [:car | 
				car lastPointTime: (Time millisecondClock - timePaused).
				(car lastPoint first = 0) ifTrue: [
					car lastPointTime: Time millisecondClock - (car lastPoint second)]]].
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
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 18:53'
}
SUSSimulation >> spawnClass [
	^ spawnClass
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 18:53'
}
SUSSimulation >> spawnClass: aClass [
	spawnClass := aClass
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/10/2024 01:34'
}
SUSSimulation >> step [

	cars do: [:car | 
		car move]
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

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 18:57'
}
SUSSimulation >> tryToBuildRoadTo: aPoint [
	self spawnClass newOnSimulation: self from: clickedConnectionPoint to: aPoint.
	self spawnClass = #StraightRoad
		ifTrue: [^ clickedConnectionPoint connectStraightRoadFromMousePos: Sensor cursorPoint].
	self spawnClass = #CurvyRoad
		ifTrue: [^ clickedConnectionPoint connectCurvyRoadFromMousePos: Sensor cursorPoint].
	self spawnClass = #CrossIntersection
		ifTrue: [^ clickedConnectionPoint connectCrossIntersectionFromMousePos: Sensor cursorPoint].
		^ false.
]
