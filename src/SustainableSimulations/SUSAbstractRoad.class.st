Class {
	#name : #SUSAbstractRoad,
	#superclass : #Morph,
	#instVars : [
		'simulation',
		'adjacentRoads',
		'isFixed',
		'lanes',
		'connectionPoints',
		'from',
		'to'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 23:43'
}
SUSAbstractRoad class >> newOnSimulation: aSimulation from: aConnectionPoint to: aPoint [
	^ self new simulation: aSimulation;
		initializeFrom: aConnectionPoint to: aPoint;
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
	#'squeak_changestamp' : 'Len 6/1/2024 21:37'
}
SUSAbstractRoad >> createLaneWithPath: aLineMorph [
	
	lanes add: (SUSLane newLaneWithPath: aLineMorph)
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
	#'squeak_changestamp' : 'PM 6/12/2024 23:06'
}
SUSAbstractRoad >> initialize [
	super initialize.
	
	isFixed := false.
	lanes := OrderedCollection new.
	
	self color: Color transparent.
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
	#'squeak_changestamp' : 'PM 5/28/2024 02:04'
}
SUSAbstractRoad >> isFixed [
	^ isFixed
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
	#'squeak_changestamp' : 'PM 6/13/2024 00:20'
}
SUSAbstractRoad >> spawnCar [
	simulation addMorphInLayer: (SUSCar
		newOnRoad: self
		withSpeed: (UIManager default request: 'Please enter car speed' initialAnswer: 50) asNumber)
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:03'
}
SUSAbstractRoad >> unselect [
	lastClickedAtConnectionPoint ifNotNil: [lastClickedAtConnectionPoint unselect ]
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/18/2024 15:54'
}
SUSAbstractRoad >> updateLanes: aRoad [
	lanes do: [:each | 
		|pos1|
		pos1 := each getPositionWithTValue: 1.
		aRoad lanes do: [:anotherEach |
			((pos1 dist: (anotherEach getPositionWithTValue: 0))<20)
				ifTrue: [each addNextLane: anotherEach]]]
		
		
	
]
