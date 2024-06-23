Class {
	#name : #SUSSimulation,
	#superclass : #PasteUpMorph,
	#instVars : [
		'roadToConnect',
		'cars',
		'killedCars',
		'tunnels',
		'simulationSpeed',
		'roads',
		'bezierCurve',
		'clickHandler',
		'clickedConnectionPoint',
		'running',
		'timePaused',
		'selectedSpawnType'
	],
	#category : #'SustainableSimulations-Core'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 14:32'
}
SUSSimulation >> activeConnectionPoint: anObject [
	clickedConnectionPoint ifNotNil: [ clickedConnectionPoint unselect ].
	clickedConnectionPoint := anObject.
	clickedConnectionPoint ifNotNil: [ clickedConnectionPoint select ].
	^ clickedConnectionPoint
]

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
	#'squeak_changestamp' : 'Len 6/20/2024 19:55'
}
SUSSimulation >> addTunnel: aTunnel [
	tunnels addLast: aTunnel
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'GoChriNo 6/22/2024 09:51'
}
SUSSimulation >> buildConnectingRoadTo: aConnectionPoint [ 
	| builder valid |
	aConnectionPoint flipDirection.
	builder := SUSRoadBuilder
				newForSimulation: self
				from: clickedConnectionPoint
				to: aConnectionPoint
				as: selectedSpawnType.
	valid := builder isValid.
	valid
		ifTrue: [self addMorph: builder buildRoad]
		ifFalse: [aConnectionPoint flipDirection].
	^ valid
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 20:27'
}
SUSSimulation >> cars [
	^ cars
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 6/18/2024 14:32'
}
SUSSimulation >> clickedWorld: anEvent [
	clickedConnectionPoint
		ifNotNil: [(self tryToBuildRoadTo: anEvent position)
				ifTrue: [self activeConnectionPoint: nil]]
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/18/2024 15:37'
}
SUSSimulation >> createConnectionPointAt: aDirectedPoint [
	| connectionPoint |
	connectionPoint := SUSConnectionPoint newForSimulation: self at: aDirectedPoint.
	self addMorphInLayer: connectionPoint.
	^ connectionPoint
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/18/2024 15:36'
}
SUSSimulation >> getOrCreateConnectionPointAt: aDirectedPoint [ 
	self submorphs
		detect: [:each | each basicType == #SUSConnectionPoint
				and: (each containsPoint: aDirectedPoint position)]
		ifFound: [:aConnectionPoint | ^ aConnectionPoint]
		ifNone: [^ self createConnectionPointAt: aDirectedPoint ]
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
	#'squeak_changestamp' : 'Len 6/20/2024 20:31'
}
SUSSimulation >> initialize [
	super initialize.
	
	roadToConnect := nil.
	cars := OrderedCollection new.
	killedCars := OrderedCollection new.
	roads := OrderedCollection new.
	tunnels := OrderedCollection new.
	simulationSpeed := 1.
	running := true. 
	timePaused := 0.
	
	self color: Color gray;
		addStartingPoint
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
	#'squeak_changestamp' : 'PM 6/18/2024 16:05'
}
SUSSimulation >> notifyClickedAt: aConnectionPoint [ 
	clickedConnectionPoint
		ifNil: [self activeConnectionPoint: aConnectionPoint]
		ifNotNil: [aConnectionPoint == clickedConnectionPoint
				ifTrue: [self activeConnectionPoint: nil]
				ifFalse: [self buildConnectingRoadTo: aConnectionPoint].
			self activeConnectionPoint: nil]
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
	#'squeak_changestamp' : 'Len 6/20/2024 20:31'
}
SUSSimulation >> removeCar: aCar [
	cars remove: aCar.
	killedCars add: aCar.
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
	#'squeak_changestamp' : 'PM 6/18/2024 13:38'
}
SUSSimulation >> selectedSpawnType [
	^ selectedSpawnType
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 13:38'
}
SUSSimulation >> selectedSpawnType: aSymbol [
	selectedSpawnType := aSymbol
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
	#'squeak_changestamp' : 'Len 6/23/2024 11:32'
}
SUSSimulation >> step [
	cars
		do: [:car | car applyBehavior].
	killedCars
		do: [:car | car owner abandon].
	tunnels
		do: [:tunnel | tunnel applyBehavior]
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
	#'squeak_changestamp' : 'PM 6/18/2024 14:30'
}
SUSSimulation >> tryToBuildRoadTo: aPoint [ 
	| builder wasStartingPoint valid |
	wasStartingPoint := clickedConnectionPoint isStartingPoint.
	wasStartingPoint
		ifTrue: [clickedConnectionPoint direction: aPoint - clickedConnectionPoint center].
	builder := SUSRoadBuilder
				newForSimulation: self
				from: clickedConnectionPoint
				to: aPoint
				as: selectedSpawnType.
	valid := builder isValid.
	valid ifTrue: [self addMorph: builder buildRoad].
	wasStartingPoint
		ifTrue: [valid
				ifTrue: [clickedConnectionPoint direction: clickedConnectionPoint center - aPoint]
				ifFalse: [clickedConnectionPoint direction: 0 @ 0]].
	^ valid
]
