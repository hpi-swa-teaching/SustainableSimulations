"
A SUSVehicle represents a moving entity on the road network.

Instance Variables
	acceleration:		Number
	currentLane:		SUSLane
	currentRoute:		OrderedCollection{Number}
	currentSpeed:		Number
	deacceleration:	Number
	deltaTime:			Number
	lastPoint:			Point
	lastTime:			Number
	maxSpeed:		Number
	rightOfWayTime:	Number
	simulation:			SUSSimulation
	spawnRoad:		SUSAbstractRoad
	targetSpeed:		Number

acceleration
	- The rate with which the vehicle accelerates.

currentLane
	- The lane the vehicle is currently diving on.

currentRoute
	- The indices of the next lanes the vehicle wants to drive on.

currentSpeed
	- The speed the vehicle is currently driving.

deacceleration
	- The rate with which the vehicle deaccelerates.

deltaTime
	- Delta time since last step.

lastPoint
	- The latest location of the car. Used for start/pause/stop.

lastTime
	- Last step clock time in millis.

maxSpeed
	- Maximal speed the vehicle is allowed to drive.

rightOfWayTime
	- The time in which a vehicle does not need to adhere to the right of way rulings. Used to resolve stuck vehicles on an intersection (e.g. the intersection grants a car rightOfWayTime to resolve the situation).

simulation
	- The Simulation which this road belongs to.

spawnRoad
	- The road on which the car has spawned.

targetSpeed
	- The target speed of the vehicle to follow cautiousness.

"
Class {
	#name : #SUSVehicle,
	#superclass : #RectangleMorph,
	#instVars : [
		'maxSpeed',
		'acceleration',
		'deacceleration',
		'simulation',
		'lastPoint',
		'lastTime',
		'deltaTime',
		'spawnRoad',
		'currentRoute',
		'currentSpeed',
		'rightOfWayTime',
		'targetSpeed',
		'currentLane'
	],
	#category : #'SustainableSimulations-Core',
	#'squeak_changestamp' : 'PM 7/12/2024 19:44'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 7/11/2024 11:50'
}
SUSVehicle class >> newOnRoad: aRoad withMaxSpeed: aNumber [ 
	^ self new simulation: aRoad simulation;
		 maxSpeed: aNumber;
		 placeOnRoad: aRoad;
		 spawnRoad: aRoad;
		 yourself
]

{
	#category : #acceleration,
	#'squeak_changestamp' : 'PM 7/11/2024 14:14'
}
SUSVehicle >> accelerate [
	currentSpeed := currentSpeed + (acceleration * 0.001 * deltaTime) min: targetSpeed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:04'
}
SUSVehicle >> acceleration: aNumber [ 
	acceleration := aNumber
]

{
	#category : #routing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:10'
}
SUSVehicle >> addRouteEntryAt: anIndex FromPrevLane: aLane [ 
	currentRoute size < anIndex
		ifTrue: [currentRoute
				addLast: (Random new nextInt: aLane nextLanes size)]
]

{
	#category : #acceleration,
	#'squeak_changestamp' : 'PM 7/11/2024 14:14'
}
SUSVehicle >> applyAcceleration [
	currentSpeed < targetSpeed
		ifTrue: [self accelerate]
		ifFalse: [self deaccelerate]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 11:16'
}
SUSVehicle >> applyBehavior [
	deltaTime := Time millisecondClock - lastTime.
	lastTime := Time millisecondClock.
	rightOfWayTime := rightOfWayTime - deltaTime max: 0.
	self applyAcceleration; applyMovement
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 15:33'
}
SUSVehicle >> applyCautiousness: t [ 
	| dist nextVehicle lookaheadDistance i nextLane |
	lookaheadDistance := self lookaheadDistanceWithTargetSpeed: 0.
	i := 0.
	nextVehicle := self nextVehicle.
	nextLane := currentLane.
	targetSpeed := maxSpeed min: currentLane road speedLimit.
	dist := self lookaheadDistanceOnLaneFrom: t.
	self checkForSpeedLimitAtDistance: dist.
	[dist <= lookaheadDistance]
		whileTrue: [i := i + 1.
			nextVehicle ~= self
				ifTrue: [^ self updateTargetSpeedWithVehicle: nextVehicle].
			nextLane nextLanes
				ifEmpty: [^ targetSpeed := 0].
			self addRouteEntryAt: i FromPrevLane: nextLane.
			nextLane := nextLane nextLanes at: (currentRoute at: i).
			(self checkForIntersection: nextLane fromDist: dist fromIndex: i)
				ifTrue: [^ self].
			nextVehicle := self nextVehicleAfter: nextVehicle onLane: nextLane.
			dist := dist + (self lookaheadDistanceAdditionToVehicle: nextVehicle onLane: nextLane).
			nextVehicle ~= self
				ifTrue: [lookaheadDistance := self lookaheadDistanceWithTargetSpeed: nextVehicle currentSpeed]]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:26'
}
SUSVehicle >> applyMovement [
	| t rotation |
	t := currentLane nextTprev: lastPoint advanceByLength: deltaTime * (currentSpeed / 360).
	t >= 1
		ifTrue: [self changeLane.
			t := lastPoint].
	self applyCautiousness: t.
	self owner
		center: (currentLane getPositionWithTValue: t).
	rotation := currentLane getRotationWithTValue: t.
	rotation first = 1
		ifTrue: [self rotationDegrees: rotation second].
	lastPoint := t
]

{
	#category : #acceleration,
	#'squeak_changestamp' : 'PM 7/11/2024 11:40'
}
SUSVehicle >> calculateBrakingDistanceFromSpeedGoal: aSpeed [ 
	^ (currentSpeed - aSpeed) squared / (deacceleration * 2) * 1000 / 360 + (0.5 * currentSpeed)
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:26'
}
SUSVehicle >> changeLane [
	currentLane nextLanes isEmpty
		ifTrue: [lastPoint := 1]
		ifFalse: [self changeToNextLane]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/12/2024 19:25'
}
SUSVehicle >> changeToNextLane [
	currentLane removeVehicle: self.
	self addRouteEntryAt: 1 FromPrevLane: currentLane.
	currentLane := currentLane nextLanes at: currentRoute first.
	currentLane addVehicle: self.
	currentRoute removeFirst.
	lastPoint := 0
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 19:43'
}
SUSVehicle >> checkForIntersection: aLane fromDist: aDistance fromIndex: anIndex [ 
	(aLane road isBlockedFrom: aLane)
		ifFalse: [aLane road isVehicleDriving: self.
			^ false].
	rightOfWayTime > 0
		ifTrue: [aLane road isVehicleDriving: self.
			^ false].
	aDistance <= ((self calculateBrakingDistanceFromSpeedGoal: 0)
				+ self safetyDistance)
		ifFalse: [aLane road isVehicleDriving: self.
			^ false].
	targetSpeed := 0.
	currentSpeed == 0
		ifTrue: [aLane road isStanding: self].
	^ true
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/12/2024 19:14'
}
SUSVehicle >> checkForSpeedLimitAtDistance: aNumber [ 
	currentLane nextLanes isEmpty
		ifFalse: [self addRouteEntryAt: 1 FromPrevLane: currentLane.
			self
				checkForSpeedLimitAtDistance: aNumber
				onLane: (currentLane nextLanes at: currentRoute first)]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:26'
}
SUSVehicle >> checkForSpeedLimitAtDistance: aNumber onLane: aLane [
	aNumber <= ((self calculateBrakingDistanceFromSpeedGoal: aLane road speedLimit)
				+ self safetyDistance)
		ifTrue: [targetSpeed := (aLane road speedLimit min: currentLane road speedLimit) min: maxSpeed]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:14'
}
SUSVehicle >> currentSpeed [
	^ currentSpeed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:14'
}
SUSVehicle >> currentSpeed: aNumber [
	currentSpeed := aNumber
]

{
	#category : #acceleration,
	#'squeak_changestamp' : 'PM 7/11/2024 14:14'
}
SUSVehicle >> deaccelerate [
	currentSpeed := currentSpeed - (deacceleration * 0.001 * deltaTime) max: targetSpeed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:00'
}
SUSVehicle >> deltaTime: anObject [
	deltaTime := anObject
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/12/2024 19:26'
}
SUSVehicle >> initialize [
	super initialize.
	lastTime := Time millisecondClock.
	lastPoint := 0.
	currentRoute := OrderedCollection new.
	rightOfWayTime := 0.
	self initializeSpeeds; morphicLayerNumber: 15
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 7/12/2024 19:23'
}
SUSVehicle >> initializeSpeeds [
	acceleration := 50.
	deacceleration := 100.
	currentSpeed := 0.
	maxSpeed := 50.
	targetSpeed := 50
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 14:26'
}
SUSVehicle >> lane [
	 ^ currentLane
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 14:26'
}
SUSVehicle >> lane: anObject [
	currentLane := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/10/2024 00:05'
}
SUSVehicle >> lastPoint [
	^ lastPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 14:36'
}
SUSVehicle >> lastTime: anObject [
	lastTime := anObject
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:48'
}
SUSVehicle >> lookaheadDistanceAdditionToVehicle: aVehicle onLane: aLane [
	aVehicle == self
		ifTrue: [^ aLane length]
		ifFalse: [^ aVehicle lane getLengthToT: aVehicle lastPoint].
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:48'
}
SUSVehicle >> lookaheadDistanceOnLaneFrom: t [ 
	^ (self lookaheadDistanceAdditionToVehicle: self nextVehicle onLane: currentLane)
		- (currentLane getLengthToT: t)
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:20'
}
SUSVehicle >> lookaheadDistanceWithTargetSpeed: aNumber [
	^ 2 * self safetyDistance + (self calculateBrakingDistanceFromSpeedGoal: aNumber)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:14'
}
SUSVehicle >> maxSpeed [
	^ maxSpeed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:14'
}
SUSVehicle >> maxSpeed: aNumber [
	maxSpeed := aNumber
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 14:27'
}
SUSVehicle >> nextVehicle [
	^ currentLane getPreviousCarOnLane: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 14:41'
}
SUSVehicle >> nextVehicleAfter: aVehicle onLane: aLane [ 
	| nextVehicle |
	nextVehicle := aVehicle.
	aLane vehicles
		ifNotEmpty: [nextVehicle := aLane vehicles last.
			nextVehicle == self
				ifTrue: [nextVehicle := aLane getPreviousCarOnLane: nextVehicle]].
	^ nextVehicle
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 7/11/2024 14:26'
}
SUSVehicle >> placeOnRoad: aRoad [ 
	simulation addVehicleIfNotExists: self.
	currentLane := aRoad lanes first.
	currentLane addVehicle: self.
	self
		center: (currentLane getPositionWithTValue: 0)
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 7/11/2024 11:29'
}
SUSVehicle >> remove [
	simulation removeVehicle: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:18'
}
SUSVehicle >> rightOfWayTime: aNumber [ 
	rightOfWayTime := aNumber
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:02'
}
SUSVehicle >> safetyDistance [
	^ 50
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:32'
}
SUSVehicle >> simulation [
	^ simulation
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:29'
}
SUSVehicle >> simulation: aSimulation [
	simulation := aSimulation
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:15'
}
SUSVehicle >> spawnRoad [
	^ spawnRoad
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 7/8/2024 23:07'
}
SUSVehicle >> spawnRoad: aRoad [
	spawnRoad := aRoad
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 14:14'
}
SUSVehicle >> speedGoal: anObject [
	targetSpeed := anObject
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:26'
}
SUSVehicle >> turnsAt: aRoad whenIndexIs: aClosure [
	| index nextLane |
	index := 1.
	nextLane := currentLane.
	currentLane road == aRoad
		ifTrue: [^ false].
	[index <= currentRoute size]
		whileTrue: [nextLane := nextLane nextLanes
						at: (currentRoute at: index).
			(nextLane road == aRoad and: (currentRoute at: index)
						= (aClosure cull: nextLane))
				ifTrue: [^ true].
			index := index + 1].
	^ false
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 12:17'
}
SUSVehicle >> turnsLeftAt: aRoad [ 
	^ self
		turnsAt: aRoad
		whenIndexIs: [1]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/12/2024 19:14'
}
SUSVehicle >> turnsRightAt: aRoad [ 
	^ self
		turnsAt: aRoad
		whenIndexIs: [:aLane | aLane previousLanes first nextLanes size]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 14:33'
}
SUSVehicle >> updateTargetSpeedWithVehicle: aVehicle [ 
	targetSpeed := (aVehicle currentSpeed min: maxSpeed)
				min: currentLane road speedLimit
]
