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
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 7/11/2024 18:35'
}
SUSAbstractRoad class >> newOnSimulation: aSimulation from: aConnectionPoint to: aPoint [ 
	^ self new simulation: aSimulation;
		 initializeFrom: aConnectionPoint to: aPoint;
		 postInitialize;
		 yourself
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 6/18/2024 15:35'
}
SUSAbstractRoad >> addConnectionPoints [
	connectionPoints := self connectionPointPositions
				collect: [:each | simulation getOrCreateConnectionPointAt: each].
	connectionPoints
		do: [:each | each connectRoad: self]
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:18'
}
SUSAbstractRoad >> addDrawing [
	| drawing |
	drawing := self createDrawing.
	drawing paths
		do: [:each | self createLaneWithPath: each].
	self extent: drawing extent;
		 position: drawing position;
		 addMorph: drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 20:14'
}
SUSAbstractRoad >> connectionPointPositions [
	^ {from. to}
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/18/2024 14:54'
}
SUSAbstractRoad >> createDrawing [
	self subclassResponsibility
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:32'
}
SUSAbstractRoad >> createLaneWithPath: aLineMorph [ 
	lanes add: (SUSLane newLaneWithPath: aLineMorph OnRoad: self)
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 7/11/2024 18:32'
}
SUSAbstractRoad >> handlesMouseDown: anEvent [
 	^ true
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/11/2024 18:32'
}
SUSAbstractRoad >> initialize [
	super initialize.
	lanes := OrderedCollection new.
	speedLimit := 50.
	self color: Color transparent;
		 sticky: true
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/11/2024 18:32'
}
SUSAbstractRoad >> initializeFrom: aConnectionPoint to: aPoint [ 
	from := aConnectionPoint asDirectedPoint.
	aPoint basicType == #SUSConnectionPoint
		ifTrue: [to := aPoint asDirectedPoint]
		ifFalse: [to := aPoint].
	self addDrawing; addConnectionPoints.
	adjacentRoads := Array new: connectionPoints size.
	simulation addRoad: self
]

{
	#category : #utility,
	#'squeak_changestamp' : 'PM 7/11/2024 18:31'
}
SUSAbstractRoad >> isBlockedFrom: aLane [
	^ false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 18:30'
}
SUSAbstractRoad >> isEmpty [
	^ lanes allSatisfy: [: each | each vehicles isEmpty ]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 14:55'
}
SUSAbstractRoad >> isVehicleDriving: aVehicle [
	^ self

	
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 7/11/2024 20:19'
}
SUSAbstractRoad >> laneConnectionThreshold [
	^ 20
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:34'
}
SUSAbstractRoad >> lanes [
	^ lanes
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'PM 7/10/2024 16:03'
}
SUSAbstractRoad >> mouseDown: anEvent [ 
	simulation selectedSpawnType = #SpawnCar
		ifTrue: [self spawnCar]
		ifFalse: [simulation showError: 'You cannot build a road directly on top of another road']
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/11/2024 17:43'
}
SUSAbstractRoad >> postInitialize [
	^ self
]

{
	#category : #utility,
	#'squeak_changestamp' : 'PM 7/11/2024 15:53'
}
SUSAbstractRoad >> searchVehicleBackwardsFromLane: aLane withMaxDist: aNumber [ 
	| dist currentLane car |
	dist := 0.
	currentLane := aLane.
	[dist <= aNumber and: currentLane previousLanes isEmpty not]
		whileTrue: [currentLane := currentLane previousLanes at: 1.
			dist := dist + currentLane length.
			currentLane vehicles
				ifNotEmpty: [car := currentLane vehicles first.
					dist := dist - (currentLane getLengthToT: car lastPoint).
					dist <= aNumber
						ifTrue: [^ car]]].
	^ nil
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
	#category : #spawning,
	#'squeak_changestamp' : 'PM 7/11/2024 15:47'
}
SUSAbstractRoad >> spawnCar [
	[self spawnCarWithMaxSpeed: (UIManager default request: 'Please enter car speed' initialAnswer: 50) asNumber]
		on: NumberParserError
		do: []
]

{
	#category : #spawning,
	#'squeak_changestamp' : 'PM 7/11/2024 15:47'
}
SUSAbstractRoad >> spawnCarWithMaxSpeed: aNumber [ 
	simulation
		addMorphInLayer: (SUSCar newOnRoad: self withMaxSpeed: aNumber)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:26'
}
SUSAbstractRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 7/11/2024 20:21'
}
SUSAbstractRoad >> updateLanesFromLane: aLane toLane: anotherLane [
	((aLane getPositionWithTValue: 1)
			dist: (anotherLane getPositionWithTValue: 0))
			< self laneConnectionThreshold
		ifTrue: [aLane addNextLane: anotherLane.
			anotherLane addPreviousLane: aLane]
]

{
	#category : #connection,
	#'squeak_changestamp' : 'PM 7/11/2024 20:21'
}
SUSAbstractRoad >> updateLanesToRoad: aRoad [ 
	lanes
		do: [:aLane | aRoad lanes
				do: [:anotherLane | self updateLanesFromLane: aLane toLane: anotherLane]]
]
