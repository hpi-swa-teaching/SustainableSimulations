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
	#category : #SustainableSimulations
}

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 5/28/2024 00:03'
}
SUSAbstractRoad >> addConnectionPoints [
	connectionPoints := self createConnectionPoints.
	connectionPoints do: [ :each | self addMorph: each ]
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 5/28/2024 00:04'
}
SUSAbstractRoad >> addDrawing [
	self addMorph: (self createDrawing)
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
	#'squeak_changestamp' : 'PM 5/27/2024 23:05'
}
SUSAbstractRoad >> createConnectionPoints [
	"Create SUSConnectionPoints for this road and return them as list"
	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 00:03'
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
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:15'
}
SUSAbstractRoad >> deltaPositionToConnectionPoint [
	^ self position - lastClickedAtConnectionPoint position
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
	#'squeak_changestamp' : 'MK 5/28/2024 19:16'
}
SUSAbstractRoad >> initialize [
	super initialize.
	
	isFixed := false.
	lanes := OrderedCollection new.
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
	#category : #initialization,
	#'squeak_changestamp' : 'Len 6/1/2024 20:25'
}
SUSAbstractRoad >> postInitialization [
	self addDrawing;
		addConnectionPoints.
	adjacentRoads := Array new: connectionPoints size.
	simulation addRoad: self
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
	#category : #drawing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:03'
}
SUSAbstractRoad >> unselect [
	lastClickedAtConnectionPoint ifNotNil: [lastClickedAtConnectionPoint unselect ]
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'MK 6/10/2024 21:11'
}
SUSAbstractRoad >> updateLanes: aRoad [
	lanes do: [:each | 
		|pos1|
		pos1 := each getPositionWithTValue: 1.
		aRoad lanes do: [:anotherEach |
			((pos1 dist: (anotherEach getPositionWithTValue: 0))<5)
				ifTrue: [each addNextLane: anotherEach]]]
		
		
	
]
