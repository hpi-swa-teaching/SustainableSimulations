"
A SUSSimulation is a traffic simulation with different roads, cars and connection points.

Instance Variables
	vehicles					OrderedCollection{SUSVehicle}
	clickedConnectionPoint:	SUSConnectionPoint|nil
	removedVehicles			OrderedCollection{SUSVehicle}
	roads:						OrderedCollection{SUSAbstractRoad}
	running:					Boolean
	selectedSpawnType:		Symbol
	stopped:					Boolean
	timePaused:				Number
	tunnels:					OrderedCollection{SUSTunnel}

vehicles
	- All the vehicles which are active on the simulation

clickedConnectionPoint
	- The active connection point, can be nil!

removedVehicles
	- All vehicles that got removed

roads
	- All Roads of the simulation

running
	- Whether the simulation is currently running

selectedSpawnType
	- The selected type of element to spawn. #SpawnCar to spawn a car, otherwise the short names of the Roads, e.g. #CurvyRoad or #TIntersection

stopped
	- Whether the simulation is currently stopped

timePaused
	- The time on which the simulation got paused

tunnels
	- All tunnels in the Simulation. Used to spawn the cars at those locations.
"
Class {
	#name : #SUSSimulation,
	#superclass : #PasteUpMorph,
	#instVars : [
		'tunnels',
		'roads',
		'clickedConnectionPoint',
		'running',
		'timePaused',
		'selectedSpawnType',
		'stopped',
		'vehicles',
		'removedVehicles'
	],
	#category : #'SustainableSimulations-Core',
	#'squeak_changestamp' : 'PM 7/10/2024 16:11'
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
	#'squeak_changestamp' : 'Len 6/1/2024 20:25'
}
SUSSimulation >> addRoad: aRoad [
	roads addLast: aRoad
]

{
	#category : #connection,
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
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:28'
}
SUSSimulation >> addVehicle: aCar [
	vehicles addLast: aCar
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:26'
}
SUSSimulation >> addVehicleIfNotExists: aVehicle [ 
	(vehicles
			anySatisfy: [:each | each == aVehicle])
		ifFalse: [vehicles addLast: aVehicle]
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 7/10/2024 13:54'
}
SUSSimulation >> buildConnectingRoadTo: aConnectionPoint [ 
	aConnectionPoint flipDirection.
	(self buildRoadOrShowErrorTo: aConnectionPoint)
		ifTrue: [^ true].
	aConnectionPoint flipDirection.
	^ false
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 7/10/2024 16:04'
}
SUSSimulation >> buildRoadOrShowErrorTo: aPoint [ 
	| builder valid |
	builder := SUSRoadBuilder
				newForSimulation: self
				from: clickedConnectionPoint
				to: aPoint
				as: selectedSpawnType.
	valid := builder isValid.
	valid
		ifTrue: [self addMorph: builder buildRoad]
		ifFalse: [self showError: builder errorMessage].
	^ valid
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 7/2/2024 23:39'
}
SUSSimulation >> clickedWorld: anEvent [
	clickedConnectionPoint
		ifNotNil: [(self tryToBuildRoadTo: anEvent position)
				ifTrue: [self activeConnectionPoint: nil]]
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 6/18/2024 15:37'
}
SUSSimulation >> createConnectionPointAt: aDirectedPoint [
	| connectionPoint |
	connectionPoint := SUSConnectionPoint newForSimulation: self at: aDirectedPoint.
	self addMorphInLayer: connectionPoint.
	^ connectionPoint
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 7/10/2024 13:50'
}
SUSSimulation >> getOrCreateConnectionPointAt: aDirectedPoint [ 
	self submorphs
		detect: [:each | each basicType == #SUSConnectionPoint
				and: (each containsPoint: aDirectedPoint position)]
		ifFound: [:aConnectionPoint | ^ aConnectionPoint]
		ifNone: [^ self createConnectionPointAt: aDirectedPoint]
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
	#'squeak_changestamp' : 'PM 7/10/2024 16:08'
}
SUSSimulation >> initialize [
	super initialize.
	vehicles := OrderedCollection new.
	removedVehicles := OrderedCollection new.
	roads := OrderedCollection new.
	tunnels := OrderedCollection new.
	running := true.
	stopped := false.
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
	#'squeak_changestamp' : 'PM 7/10/2024 13:51'
}
SUSSimulation >> pauseSimulation [
	running
		ifTrue: [self stopStepping.
			timePaused := Time millisecondClock.
			running := false]
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 7/10/2024 16:07'
}
SUSSimulation >> playSimulation [
	running
		ifFalse: [timePaused > 0
				ifTrue: [vehicles
						do: [:car | car lastTime: Time millisecondClock]].
			self startStepping.
			timePaused := 0.
			running := true.
			stopped := false]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:29'
}
SUSSimulation >> removeVehicle: aCar [ 
	vehicles remove: aCar.
	removedVehicles add: aCar
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
	#category : #'error handling',
	#'squeak_changestamp' : 'PM 7/10/2024 16:05'
}
SUSSimulation >> showError: aString [
	self inform: aString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 20:00'
}
SUSSimulation >> startingPointPosition [
	^ 200@300
]

{
	#category : #'stepping and presenter',
	#'squeak_changestamp' : 'PM 7/10/2024 16:08'
}
SUSSimulation >> step [
	vehicles
		do: [:car | car applyBehavior].
	removedVehicles
		do: [:car | car owner abandon].
	tunnels
		do: [:tunnel | tunnel applyBehavior].
	stopped
		ifTrue: [self pauseSimulation]
]

{
	#category : #'stepping and presenter',
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 15:41'
}
SUSSimulation >> stepTime [
	^ 10
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 7/11/2024 11:50'
}
SUSSimulation >> stopSimulation [
	stopped
		ifFalse: [vehicles copy
				do: [:each | each spawnRoad = 0
						ifTrue: [each remove]
						ifFalse: [self
								addMorphInLayer: (SUSCar newOnRoad: each spawnRoad withMaxSpeed: each maxSpeed).
							each remove]]].
	stopped := true
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 7/10/2024 13:56'
}
SUSSimulation >> tryToBuildRoadTo: aPoint [ 
	| wasStartingPoint valid |
	wasStartingPoint := clickedConnectionPoint isStartingPoint.
	wasStartingPoint
		ifTrue: [clickedConnectionPoint direction: aPoint - clickedConnectionPoint center].
	valid := self buildRoadOrShowErrorTo: aPoint.
	wasStartingPoint
		ifTrue: [valid
				ifTrue: [clickedConnectionPoint flipDirection]
				ifFalse: [clickedConnectionPoint direction: 0 @ 0]].
	^ valid
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/10/2024 16:12'
}
SUSSimulation >> vehicles [
	^ vehicles
]
