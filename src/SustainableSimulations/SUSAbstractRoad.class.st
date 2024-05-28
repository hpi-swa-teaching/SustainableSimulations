Class {
	#name : #SUSAbstractRoad,
	#superclass : #Morph,
	#instVars : [
		'connectionPoints',
		'simulation',
		'lastClickedAtConnectionPoint',
		'adjacentRoads',
		'isFixed'
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
	#'squeak_changestamp' : 'PM 5/28/2024 01:04'
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
	#'squeak_changestamp' : 'PM 5/28/2024 01:15'
}
SUSAbstractRoad >> deltaPositionToConnectionPoint [
	^ self position - lastClickedAtConnectionPoint position
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 5/28/2024 02:04'
}
SUSAbstractRoad >> initialize [
	super initialize.
	
	isFixed := false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 02:04'
}
SUSAbstractRoad >> isFixed [
	^ isFixed
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 5/28/2024 01:28'
}
SUSAbstractRoad >> postInitialization [
	self addDrawing;
		addConnectionPoints.
	adjacentRoads := Array new: connectionPoints size
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
