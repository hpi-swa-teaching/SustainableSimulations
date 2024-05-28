Class {
	#name : #SUSSimulation,
	#superclass : #PasteUpMorph,
	#instVars : [
		'roadToConnect',
		'cars',
		'simulationSpeed',
		'roads',
		'bezierCurve'
	],
	#category : 'SustainableSimulations'
}

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 5/28/2024 02:05'
}
SUSSimulation >> connectRoad: aRoad with: anotherRoad [
	anotherRoad isFixed
		ifTrue: [ anotherRoad connectWith: aRoad ]
		ifFalse: [ aRoad connectWith: anotherRoad ]
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
	#'squeak_changestamp' : 'MK 5/28/2024 18:21'
}
SUSSimulation >> initialize [
	super initialize.
	
	roadToConnect := nil.
	
	self color: Color gray.
	
	cars := OrderedCollection new.
	roads := OrderedCollection new.
	simulationSpeed := 1.
	
	self demoRoadWithCar.
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 21:59'
}
SUSSimulation >> step [

	cars first moveAlongBezier: bezierCurve.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 22:02'
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
