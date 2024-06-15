Class {
	#name : #SUSConnectionPoint,
	#superclass : #CircleMorph,
	#instVars : [
		'direction',
		'firstRoad',
		'secondRoad',
		'simulation',
		'isStartingPoint'
	],
	#category : #'SustainableSimulations-Core'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 6/12/2024 23:41'
}
SUSConnectionPoint class >> newForRoad: aRoad at: aDirectedPoint [
	^ self new simulation: aRoad simulation;
		connectRoad: aRoad;
		center: aDirectedPoint position;
		direction: aDirectedPoint direction;
		yourself
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 6/12/2024 23:39'
}
SUSConnectionPoint class >> newStartingPointForSimulation: aSimulation at: aPoint [
	^ self new simulation: aSimulation;
		center: aPoint;
		yourself
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 22:28'
}
SUSConnectionPoint >> asDirectedPoint [
	^ SUSDirectedPoint newWithPosition: self center inDirection: self direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:39'
}
SUSConnectionPoint >> askForDegrees [
	^ (UIManager default request: 'Please enter rotation degrees (0 < x < 180)' initialAnswer: 90) asNumber
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/13/2024 00:17'
}
SUSConnectionPoint >> connectRoad: aRoad [ 
	isStartingPoint
		ifTrue: [firstRoad := aRoad]
		ifFalse: [secondRoad := aRoad.
			firstRoad updateLanes: secondRoad.
			simulation removeMorph: self].
	isStartingPoint := false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:28'
}
SUSConnectionPoint >> direction [
	^ direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 22:28'
}
SUSConnectionPoint >> direction: anObject [
	direction := anObject
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 6/12/2024 23:32'
}
SUSConnectionPoint >> handleMouseDown: anEvent [
	simulation notifyClickedAt: self
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 5/27/2024 23:02'
}
SUSConnectionPoint >> handlesMouseDown: anEvent [
	^ true
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 23:41'
}
SUSConnectionPoint >> initialize [
	super initialize.
	
	isStartingPoint := true.
	direction := 0@0.
	
	self color: Color green;
		sticky: true;
		morphicLayerNumber: 20
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/12/2024 23:52'
}
SUSConnectionPoint >> isStartingPoint [
	^ isStartingPoint
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/12/2024 19:16'
}
SUSConnectionPoint >> select [
	self color: Color red
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 08:56'
}
SUSConnectionPoint >> simulation [
	^ simulation
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 08:56'
}
SUSConnectionPoint >> simulation: anObject [
	simulation := anObject
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 5/28/2024 00:48'
}
SUSConnectionPoint >> unselect [
	self color: Color green
]
