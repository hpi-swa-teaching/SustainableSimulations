Class {
	#name : #SUSStraightRoad,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'length',
		'speedLimit'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 5/27/2024 23:45'
}
SUSStraightRoad class >> newOnSimulation: aSimulation withLength: aNumber [
	^ self newOnSimulation: aSimulation withLength: aNumber withSpeedLimit: aSimulation defaultSpeedLimit
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 5/27/2024 23:51'
}
SUSStraightRoad class >> newOnSimulation: aSimulation withLength: aNumber withSpeedLimit: anotherNumber [
	^ self new simulation: aSimulation;
		length: aNumber;
		speedLimit: anotherNumber;
		postInitialization;
		yourself
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 12:06'
}
SUSStraightRoad >> checkRotation: aConnectionPoint [ 
	| cp1 cp2 acp1 acp2 |
	aConnectionPoint direction = aConnectionPoint adjacentConnectionPoint direction
		ifTrue: [cp1 := self connectionPoints at: 1.
			cp2 := self connectionPoints at: 2.
			acp1 := cp1 adjacentConnectionPoint.
			acp2 := cp2 adjacentConnectionPoint.
			cp1 adjacentConnectionPoint: acp2.
			cp2 adjacentConnectionPoint: acp1.
			acp1
				ifNotNil: [acp1 adjacentConnectionPoint: cp2].
			acp2
				ifNotNil: [acp2 adjacentConnectionPoint: cp1].
			^ true]
		ifFalse: [^ false]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 09:59'
}
SUSStraightRoad >> createConnectionPoints [
	| previousConnectionPoint nextConnectionPoint |
	previousConnectionPoint := (SUSConnectionPoint newForRoad: self withDirection: (-1@0))
		center: (self extent * (0@0.5));
		index: 1;
		yourself.
	nextConnectionPoint := (SUSConnectionPoint newForRoad: self withDirection: (1@0))
		center: (self extent * (1@0.5));
		index: 2;
		yourself.
	^ {previousConnectionPoint . nextConnectionPoint}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:46'
}
SUSStraightRoad >> createDrawing [
	| drawing |
	drawing := SUSDrawing newNormalRoadWithLength: self length.
	self extent: drawing extent.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:42'
}
SUSStraightRoad >> length [
	^ length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:42'
}
SUSStraightRoad >> length: anObject [
	length := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:43'
}
SUSStraightRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:43'
}
SUSStraightRoad >> speedLimit: anObject [
	speedLimit := anObject
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 07:54'
}
SUSStraightRoad >> swap: anIndex [ 
	anIndex == 1
		ifTrue: [^ 2].
	anIndex == 2
		ifTrue: [^ 1].
	^ 0
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 12:07'
}
SUSStraightRoad >> updateConnectionFrom: anIndex WithList: updatedRoads [ 
	| connectionPoint1 connectionPoint2 newPoint1 newPoint2 updatePoint |
	(updatedRoads includes: self)
		ifFalse: ["sets new position"
			connectionPoint1 := self connectionPoints at: anIndex.
			connectionPoint2 := self connectionPoints
						at: (self swap: anIndex).
			newPoint1 := connectionPoint1 adjacentConnectionPoint road center + (connectionPoint1 adjacentConnectionPoint direction * connectionPoint1 adjacentConnectionPoint road length / 2).
			newPoint2 := newPoint1 + (connectionPoint1 adjacentConnectionPoint direction * self length).
			self center: newPoint1 + (newPoint2 - newPoint1 / 2).
			"updates Connection"
			(self checkRotation: connectionPoint1)
				ifTrue: [updatePoint := connectionPoint1]
				ifFalse: [updatePoint := connectionPoint2].
			updatePoint adjacentConnectionPoint
				ifNotNil: [updatePoint adjacentConnectionPoint road updateConnectionFrom: updatePoint adjacentConnectionPoint index WithList: (updatedRoads add: self;
							 yourself)].
			self disableConnectionPoints]
]
