Class {
	#name : #SUSCrossIntersection,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'length'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 5/30/2024 10:37'
}
SUSCrossIntersection class >> newOnSimulation: aSimulation [
	^ self new simulation: aSimulation;
		postInitialization;
		length: (SUSDrawing normalLaneWidth * 4);
		yourself
]

{
	#category : #connection,
	#'squeak_changestamp' : 'GoChriNo 5/30/2024 10:41'
}
SUSCrossIntersection >> checkRotation: aConnectionPoint [ 
	| cp1 cp2 acp1 acp2 |
	aConnectionPoint direction = aConnectionPoint adjacentConnectionPoint direction
		ifTrue: [cp1 := self connectionPoints at: 1.
			cp2 := self connectionPoints at: 3.
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
	#'squeak_changestamp' : 'PM 5/28/2024 01:44'
}
SUSCrossIntersection >> createConnectionPoints [
	| positions directions |
	positions := {0 @ 0.5. 0.5 @ 0. 1 @ 0.5. 0.5 @ 1}.
	directions := {-1 @ 0. 0 @ 1. 1 @ 0. 0 @ -1}.
	^ (1 to: 4)
		collect: [:index | (SUSConnectionPoint
				newForRoad: self
				withDirection: (directions at: index))
				center: (self extent * positions at: index);
				 yourself]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:31'
}
SUSCrossIntersection >> createDrawing [
	| drawing |
	drawing := SUSDrawing newCrossIntersetion.
	self extent: drawing extent.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/30/2024 10:35'
}
SUSCrossIntersection >> length [
	^ length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/30/2024 10:35'
}
SUSCrossIntersection >> length: anObject [
	length := anObject
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 5/30/2024 10:39'
}
SUSCrossIntersection >> swap: anIndex [

	anIndex = 1 ifTrue: [
		^ 3].
	anIndex = 2 ifTrue: [
		^ 4].
	anIndex = 3 ifTrue: [
		^ 1].
	anIndex = 4 ifTrue: [
		^ 2].
	^0
]

{
	#category : #connection,
	#'squeak_changestamp' : 'GoChriNo 5/30/2024 10:38'
}
SUSCrossIntersection >> updateConnectionFrom: anIndex WithList: updatedRoads [ 
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
