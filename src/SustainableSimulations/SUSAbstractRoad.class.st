Class {
	#name : #SUSAbstractRoad,
	#superclass : #Morph,
	#instVars : [
		'connectionPoints',
		'simulation',
		'lastClickedAtConnectionPoint',
		'adjacentRoads',
		'isFixed',
		'lanes'
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
	#'squeak_changestamp' : 'PM 6/12/2024 23:41'
}
SUSAbstractRoad >> addConnectionPointsWith: aConnectionPoint [
	| others | 
	others := self otherConnectionPointPositionsThan: aConnectionPoint.
	others do: [ :each | simulation addMorphInLayer: each ].
	connectionPoints := OrderedCollection new.
	aConnectionPoint connectRoad: self.
	connectionPoints add: aConnectionPoint.
	connectionPoints addAll: others
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/13/2024 00:47'
}
SUSAbstractRoad >> addDrawingFrom: aConnectionPoint to: aPoint [
	self addMorph: (self createDrawingFrom: aConnectionPoint to: aPoint)
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 09:02'
}
SUSAbstractRoad >> clickedAtConnectionPoint: aConnectionPoint [
	self unselect.
	self sticky: true.
	lastClickedAtConnectionPoint == aConnectionPoint
		ifTrue: [ lastClickedAtConnectionPoint := nil ]
		ifFalse: [ lastClickedAtConnectionPoint := aConnectionPoint ].
	
	simulation notifyClickedAt: self.
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 5/28/2024 01:24'
}
SUSAbstractRoad >> connectWith: aRoad [
	aRoad position: (lastClickedAtConnectionPoint position + aRoad deltaPositionToConnectionPoint).
	self connectionDoneWith: aRoad.
	aRoad connectionDoneWith: self
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 5/28/2024 02:04'
}
SUSAbstractRoad >> connectionDoneWith: aRoad [
	| index |
	index := connectionPoints indexOf: lastClickedAtConnectionPoint.
	adjacentRoads at: index put: aRoad.
	
	isFixed := true.
	
	self removeMorph: lastClickedAtConnectionPoint;
		unselect
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 13:24'
}
SUSAbstractRoad >> connectionPoints [
	^ connectionPoints
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 13:24'
}
SUSAbstractRoad >> connectionPoints: anObject [
	connectionPoints := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/13/2024 00:43'
}
SUSAbstractRoad >> createDrawingFrom: aConnectionPoint to: aPoint [
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
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 02:45'
}
SUSAbstractRoad >> deltaPositionToConnectionPoint [
	^ self position - (connectionPoints at: 1) center
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:56'
}
SUSAbstractRoad >> from: aDirectedPoint to: aPoint [
	"initialize this road from aDirectedPoint to aPoint"
	self subclassResponsibility
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
	#'squeak_changestamp' : 'PM 6/13/2024 00:43'
}
SUSAbstractRoad >> initializeFrom: aConnectionPoint to: aPoint [
	self from: aConnectionPoint asDirectedPoint to: aPoint;
		addDrawingFrom: aConnectionPoint to: aPoint;
		addConnectionPointsWith: aConnectionPoint.
	
	adjacentRoads := Array new: connectionPoints size.
	self simulation addRoad: self
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
	#'squeak_changestamp' : 'PM 6/12/2024 22:50'
}
SUSAbstractRoad >> otherConnectionPointPositionsThan: aConnectionPoint [
	"Create SUSConnectionPoints for this road and return them as list"
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
	#'squeak_changestamp' : 'Len 6/17/2024 21:42'
}
SUSAbstractRoad >> updateLanes: aRoad [
	lanes do: [:each | 
		|pos1|
		pos1 := each getPositionWithTValue: 1.
		aRoad lanes do: [:anotherEach |
			((pos1 dist: (anotherEach getPositionWithTValue: 0))<10)
				ifTrue: [each addNextLane: anotherEach]]]
		
		
	
]
