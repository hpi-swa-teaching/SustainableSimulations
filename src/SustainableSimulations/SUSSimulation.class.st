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
	#category : #initialization,
	#'squeak_changestamp' : 'Len 6/1/2024 20:05'
}
SUSSimulation >> initialize [
	super initialize.
	
	roadToConnect := nil.
	
	self color: Color gray.
	
	cars := OrderedCollection new.
	roads := OrderedCollection new.
	simulationSpeed := 1.
	
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
	#'squeak_changestamp' : 'Len 6/9/2024 23:51'
}
SUSSimulation >> step [

	cars do: [:car | 
		car move2].
	"self checkDistance."
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
