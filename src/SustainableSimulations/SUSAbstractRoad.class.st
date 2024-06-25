Class {
	#name : #SUSAbstractRoad,
	#superclass : #Morph,
	#instVars : [
		'simulation',
		'adjacentRoads',
		'lanes',
		'connectionPoints',
		'from',
		'to',
		'speedLimit'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/20/2024 19:58'
}
SUSAbstractRoad class >> newOnSimulation: aSimulation from: aConnectionPoint to: aPoint [
	^ self new simulation: aSimulation;
		initializeFrom: aConnectionPoint to: aPoint;
		postInitialize;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 15:35'
}
SUSAbstractRoad >> addConnectionPoints [
	connectionPoints := self connectionPointPositions
				collect: [:each | simulation getOrCreateConnectionPointAt: each].
	connectionPoints
		do: [:each | each connectRoad: self]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 15:29'
}
SUSAbstractRoad >> connectionPointPositions [
	^ { from . to }
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 14:54'
}
SUSAbstractRoad >> createDrawing [
	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:24'
}
SUSAbstractRoad >> createLaneWithPath: aLineMorph [
	
	lanes add: (SUSLane newLaneWithPath: aLineMorph OnRoad: self)
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'MK 6/10/2024 22:32'
}
SUSAbstractRoad >> handlesMouseDown: anEvent [
 	^true
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:26'
}
SUSAbstractRoad >> initialize [
	super initialize.
	
	lanes := OrderedCollection new.
	speedLimit := 50.
	
	self color: Color transparent;
		sticky: true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 15:32'
}
SUSAbstractRoad >> initializeFrom: aConnectionPoint to: aPoint [ 
	from := aConnectionPoint asDirectedPoint.
	aPoint basicType == #SUSConnectionPoint
		ifTrue: [to := aPoint asDirectedPoint]
		ifFalse: [to := aPoint].
	self addMorph: self createDrawing;
		addConnectionPoints.
	adjacentRoads := Array new: connectionPoints size.
	simulation addRoad: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:34'
}
SUSAbstractRoad >> lanes [
	^ lanes
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:57'
}
SUSAbstractRoad >> mouseDown: anEvent [
	(simulation selectedSpawnType = #SpawnCar) 
		ifTrue: [ self spawnCar ]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 19:58'
}
SUSAbstractRoad >> postInitialize [
	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:15'
}
SUSAbstractRoad >> simulation [
	^ simulation
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:15'
}
SUSAbstractRoad >> simulation: anObject [
	simulation := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 18:56'
}
SUSAbstractRoad >> spawnCar [
	[simulation
		addMorphInLayer: (SUSCar newOnRoad: self withSpeed: (UIManager default request: 'Please enter car speed' initialAnswer: 50) asNumber)]
		on: NumberParserError
		do: []
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:26'
}
SUSAbstractRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:26'
}
SUSAbstractRoad >> speedLimit: anObject [
	speedLimit := anObject
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/22/2024 22:07'
}
SUSAbstractRoad >> updateLanes: aRoad [ 
	lanes
		do: [:each | 
			| pos1 |
			pos1 := each getPositionWithTValue: 1.
			aRoad lanes
				do: [:anotherEach | (pos1
							dist: (anotherEach getPositionWithTValue: 0))
							< 20
						ifTrue: [each addNextLane: anotherEach]]]
]
