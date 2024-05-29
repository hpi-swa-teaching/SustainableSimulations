Class {
	#name : #SUSAbstractRoad,
	#superclass : #Morph,
	#instVars : [
		'connectionPoints',
		'simulation',
		'lastClickedAtConnectionPoint',
		'isFixed',
		'transformationMorph'
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
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 12:08'
}
SUSAbstractRoad >> connectWith: aRoad [ 
	self unselect.
	aRoad unselect.
	self lastClickedAtConnectionPoint visible: false.
	self
		connectWith: aRoad
		FromConnectionPoint: self lastClickedAtConnectionPoint
		ToConnectionPoint: aRoad lastClickedAtConnectionPoint.
	self lastClickedAtConnectionPoint: nil.
	aRoad lastClickedAtConnectionPoint: nil
]

{
	#category : #connection,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 12:08'
}
SUSAbstractRoad >> connectWith: aRoad FromConnectionPoint: aConnectionPoint ToConnectionPoint: otherConnectionPoint [ 
	aConnectionPoint adjacentConnectionPoint: otherConnectionPoint.
	otherConnectionPoint adjacentConnectionPoint: aConnectionPoint.
	aRoad
		updateConnectionFrom: (aRoad connectionPoints indexOf: otherConnectionPoint)
		WithList: (Set new add: self;
				 yourself)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 07:44'
}
SUSAbstractRoad >> connectionPoints [
	^ connectionPoints
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 07:44'
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
	#'squeak_changestamp' : 'PM 5/28/2024 01:15'
}
SUSAbstractRoad >> deltaPositionToConnectionPoint [
	^ self position - lastClickedAtConnectionPoint position
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 12:08'
}
SUSAbstractRoad >> disableConnectionPoints [
	self connectionPoints
		do: [:each | each adjacentConnectionPoint
				ifNil: [each visible: true]
				ifNotNil: [each visible: false]]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 08:47'
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
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 08:00'
}
SUSAbstractRoad >> lastClickedAtConnectionPoint [
	^ lastClickedAtConnectionPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 08:00'
}
SUSAbstractRoad >> lastClickedAtConnectionPoint: anObject [
	lastClickedAtConnectionPoint := anObject
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 08:50'
}
SUSAbstractRoad >> postInitialization [
	self addDrawing;
		addConnectionPoints;
		addFlexShell.
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
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 08:16'
}
SUSAbstractRoad >> transformationMorph [
	^ transformationMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 08:16'
}
SUSAbstractRoad >> transformationMorph: anObject [
	transformationMorph := anObject
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 10:39'
}
SUSAbstractRoad >> unselect [
	lastClickedAtConnectionPoint ifNotNil: [lastClickedAtConnectionPoint unselect ]
]

{
	#category : #connection,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 07:50'
}
SUSAbstractRoad >> updateConnectionFrom: anIndex WithList: updatedRoads [

	self subclassResponsibility
]
