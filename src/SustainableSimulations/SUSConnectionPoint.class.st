Class {
	#name : #SUSConnectionPoint,
	#superclass : #CircleMorph,
	#instVars : [
		'direction',
		'road',
		'isExit',
		'isEntry',
		'adjacentConnectionPoint',
		'index'
	],
	#category : #SustainableSimulations
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 5/27/2024 23:08'
}
SUSConnectionPoint class >> newForRoad: aRoad withDirection: aPoint [
	^ self newForRoad: aRoad withDirection: aPoint isEntry: true isExit: true
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 5/27/2024 23:08'
}
SUSConnectionPoint class >> newForRoad: aRoad withDirection: aPoint isEntry: aBoolean isExit: anotherBoolean [
	^ self new road: aRoad;
		direction: aPoint;
		isEntry: aBoolean;
		isExit: anotherBoolean;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 07:43'
}
SUSConnectionPoint >> adjacentConnectionPoint [
	^ adjacentConnectionPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 07:43'
}
SUSConnectionPoint >> adjacentConnectionPoint: anObject [
	adjacentConnectionPoint := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:00'
}
SUSConnectionPoint >> direction [
	^ direction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:00'
}
SUSConnectionPoint >> direction: anObject [
	direction := anObject
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 5/28/2024 00:48'
}
SUSConnectionPoint >> handleMouseDown: anEvent [
	self color: Color red.
	self road clickedAtConnectionPoint: self
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 5/27/2024 23:02'
}
SUSConnectionPoint >> handlesMouseDown: anEvent [
	^ true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 09:59'
}
SUSConnectionPoint >> index [
	^ index
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/29/2024 09:59'
}
SUSConnectionPoint >> index: anObject [
	index := anObject
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 5/28/2024 00:48'
}
SUSConnectionPoint >> initialize [
	super initialize.
	
	self color: Color green
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:07'
}
SUSConnectionPoint >> isEntry [
	^ isEntry
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:07'
}
SUSConnectionPoint >> isEntry: anObject [
	isEntry := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:07'
}
SUSConnectionPoint >> isExit [
	^ isExit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:07'
}
SUSConnectionPoint >> isExit: anObject [
	isExit := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:00'
}
SUSConnectionPoint >> road [
	^ road
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/27/2024 23:00'
}
SUSConnectionPoint >> road: anObject [
	road := anObject
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 5/28/2024 00:48'
}
SUSConnectionPoint >> unselect [
	self color: Color green
]
