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
		'roadFactory'
	],
	#category : #'SustainableSimulations-Core'
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
	#'squeak_changestamp' : 'PM 6/12/2024 23:39'
}
SUSSimulation >> addStartingPoint [
	self addMorph: (SUSConnectionPoint newStartingPointForSimulation: self at: self startingPointPosition)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:19'
}
SUSSimulation >> clickedConnectionPoint: anObject [
	clickedConnectionPoint ifNotNil: [ clickedConnectionPoint unselect ].
	clickedConnectionPoint := anObject.
	clickedConnectionPoint ifNotNil: [ clickedConnectionPoint select ].
	^ clickedConnectionPoint
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 6/15/2024 20:21'
}
SUSSimulation >> clickedWorld: anEvent [
	clickedConnectionPoint
		ifNotNil: [(self tryToBuildRoadTo: anEvent position)
				ifTrue: [self clickedConnectionPoint: nil]]
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
	#'squeak_changestamp' : 'PM 6/12/2024 22:24'
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
	roadFactory := SUSRoadFactory newForSimulation: self.
	
	self addStartingPoint.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 19:20'
}
SUSSimulation >> mouseDown: anEvent [ 
	super mouseDown: anEvent.
	self submorphs
		detect: [:each | each containsPoint: anEvent position]
		ifNone: [self clickedWorld: anEvent]
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 19:20'
}
SUSSimulation >> notifyClickedAt: aConnectionPoint [ 
	clickedConnectionPoint
		ifNil: [self clickedConnectionPoint: aConnectionPoint]
		ifNotNil: [aConnectionPoint == clickedConnectionPoint
				ifTrue: [self clickedConnectionPoint: nil]
				ifFalse: [self clickedConnectionPoint: aConnectionPoint]]
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
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:57'
}
SUSSimulation >> selectedSpawnType [
	^ roadFactory selectedRoadType
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:57'
}
SUSSimulation >> selectedSpawnType: aSymbol [
	roadFactory selectedRoadType: aSymbol
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 6/12/2024 20:00'
}
SUSSimulation >> startingPointPosition [
	^ 200@300
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/16/2024 11:13'
}
SUSSimulation >> step [
	cars
		do: [:car | car applyBehavior]
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

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/15/2024 20:23'
}
SUSSimulation >> tryToBuildRoadTo: aPoint [ 
	| canBuildRoad wasStartingPoint |
	wasStartingPoint := clickedConnectionPoint isStartingPoint.
	wasStartingPoint
		ifTrue: [clickedConnectionPoint direction: aPoint - clickedConnectionPoint center].
	canBuildRoad := roadFactory canBuildRoadFrom: clickedConnectionPoint to: aPoint.
	canBuildRoad
		ifTrue: [self
				addMorph: (roadFactory buildRoadFrom: clickedConnectionPoint to: aPoint)].
	wasStartingPoint
		ifTrue: [canBuildRoad
				ifTrue: [clickedConnectionPoint direction: (clickedConnectionPoint center - aPoint)]
				ifFalse: [clickedConnectionPoint direction: 0 @ 0]].
	^ canBuildRoad
]
