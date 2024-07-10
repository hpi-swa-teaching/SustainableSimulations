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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/20/2024 19:58'
}
SUSAbstractRoad class >> newOnSimulation: aSimulation from: aConnectionPoint to: aPoint [
	^ self new simulation: aSimulation;
		initializeFrom: aConnectionPoint to: aPoint;
		postInitialize;
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
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
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
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:24'
}
SUSAbstractRoad >> createLaneWithPath: aLineMorph [
	
	lanes add: (SUSLane newLaneWithPath: aLineMorph OnRoad: self)
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 12:39'
}
SUSAbstractRoad >> driving: aCar [

	
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
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:26'
}
SUSAbstractRoad >> initialize [
	super initialize.
	
	lanes := OrderedCollection new.
	speedLimit := 50.
	
	self color: Color transparent;
		sticky: true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/3/2024 00:23'
}
SUSAbstractRoad >> initializeFrom: aConnectionPoint to: aPoint [ 
	from := aConnectionPoint asDirectedPoint.
	aPoint basicType == #SUSConnectionPoint
		ifTrue: [to := aPoint asDirectedPoint]
		ifFalse: [to := aPoint].
	self addDrawing;
		addConnectionPoints.
	adjacentRoads := Array new: connectionPoints size.
	simulation addRoad: self
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 11:25'
}
SUSAbstractRoad >> isBlockedFrom: aLane [

	^ false.
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 12:45'
}
SUSAbstractRoad >> isEmpty [

	self lanes do: [:each | each cars ifNotEmpty: [^ false]].
	^ true.
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
	#'squeak_changestamp' : 'PM 7/10/2024 16:03'
}
SUSAbstractRoad >> mouseDown: anEvent [ 
	simulation selectedSpawnType = #SpawnCar
		ifTrue: [self spawnCar]
		ifFalse: [simulation showError: 'You cannot build a road directly on top of another road']
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/27/2024 10:08'
}
SUSAbstractRoad >> postInitialize [
	"Do nothing"
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 12:51'
}
SUSAbstractRoad >> searchForCarBackwardsFromLane: aLane WithMaxDist: maxDist [ 
	| dist car currentLane |
	dist := 0.
	currentLane := aLane.
	car := nil.
	[dist <= maxDist]
		whileTrue: [car
				ifNotNil: [^ car].
			currentLane previousLanes isEmpty ifTrue: [^ nil].
			currentLane := currentLane previousLanes at: 1.
			currentLane cars isEmpty
				ifTrue: [dist := dist + currentLane length]
				ifFalse: [car := currentLane cars first.
					dist := dist + currentLane length
								- (currentLane getLengthToT: car lastPoint)]].
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
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/18/2024 18:56'
}
SUSAbstractRoad >> spawnCar [
	[simulation
		addMorphInLayer: (SUSCar newOnRoad: self withSpeed: (UIManager default request: 'Please enter car speed' initialAnswer: 50) asNumber)]
		on: NumberParserError
		do: []
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:26'
}
SUSAbstractRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/25/2024 10:26'
}
SUSAbstractRoad >> speedLimit: anObject [
	speedLimit := anObject
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 08:22'
}
SUSAbstractRoad >> updateLanes: aRoad [ 
	lanes
		do: [:each | 
			| pos1 |
			pos1 := each getPositionWithTValue: 1.
			aRoad lanes
				do: [:anotherEach | (pos1
							dist: (anotherEach getPositionWithTValue: 0))
							< 20
						ifTrue: [each addNextLane: anotherEach.
							anotherEach addPreviousLane: each]]]
]
