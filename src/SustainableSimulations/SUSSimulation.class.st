Class {
	#name : #SUSSimulation,
	#superclass : #PasteUpMorph,
	#instVars : [
		'roadToConnect',
		'cars',
		'simulationSpeed',
		'roads',
		'bezierCurve',
		'running',
		'timePaused'
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 6/9/2024 23:52'
}
SUSSimulation >> adjustTimes [
	| curTime delta |
	curTime := Time millisecondClock.
	delta := curTime - timePaused.
	"cars do: [:car | car adjustTimeBy: delta]."
	timePaused := 0.
	Transcript show: 'Times adjusted by: ', delta asString, String cr; flush.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ek 6/9/2024 21:29'
}
SUSSimulation >> cars [
	^ cars
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
	#'squeak_changestamp' : 'ek 6/9/2024 23:33'
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
	
	"self demoRoadWithCar."
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 5/28/2024 01:05'
}
SUSSimulation >> notifyClickedAt: aRoad [ 
	roadToConnect ifNil: [roadToConnect := aRoad]
		ifNotNil: [self connectSavedRoadWith: aRoad]
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'ek 6/9/2024 23:29'
}
SUSSimulation >> pauseSimulation [
	running ifTrue: [
		super stopStepping.
		timePaused := Time millisecondClock.
		running := false .
		Transcript show: 'Simulation paused', String cr; flush.
	].
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'ek 6/9/2024 23:29'
}
SUSSimulation >> playSimulation [
	running ifFalse: [
		timePaused > 0 ifTrue: [self adjustTimes].
		super startStepping.
		running := true .
		Transcript show: 'Simulation started', String cr; flush.
	].
	
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
	#'squeak_changestamp' : 'ek 6/9/2024 18:55'
}
SUSSimulation >> running [
	^ running
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ek 6/9/2024 19:46'
}
SUSSimulation >> running: aBoolean [
	running := aBoolean.
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
	#'squeak_changestamp' : 'ek 6/9/2024 21:41'
}
SUSSimulation >> stopSimulation [
	"Transcript show: 'Stop Simulation'"
]
