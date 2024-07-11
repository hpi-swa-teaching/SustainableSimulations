Class {
	#name : #SUSVehicle,
	#superclass : #RectangleMorph,
	#instVars : [
		'maxSpeed',
		'acceleration',
		'deacceleration',
		'speedGoal',
		'length',
		'simulation',
		'lane',
		'lastPoint',
		'lastTime',
		'deltaTime',
		'isAccelerating',
		'spawnRoad',
		'currentRoute',
		'currentSpeed',
		'timeRoadStart',
		'blockedOldLane',
		'oldLane',
		'lastL',
		'rightOfWayTime'
	],
	#category : #'SustainableSimulations-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/11/2024 11:43'
}
SUSVehicle class >> newOnRoad: aRoad withSpeed: aNumber [ 
	^ self new simulation: aRoad simulation;
		 maxSpeed: aNumber;
		 placeOnRoad: aRoad;
		 spawnRoad: aRoad;
		 yourself
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
	#'squeak_changestamp' : 'PM 7/11/2024 11:12'
}
SUSVehicle >> applyAcceleration [
	currentSpeed < speedGoal
		ifTrue: [currentSpeed := currentSpeed + (acceleration * 0.001 * deltaTime) min: speedGoal]
		ifFalse: [currentSpeed := currentSpeed - (deacceleration * 0.001 * deltaTime) max: speedGoal]
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
	#'squeak_changestamp' : 'PM 7/11/2024 11:39'
}
SUSVehicle >> applyCautiousness: t [ 
	| dist nextCar maxDist i currentLane |
	maxDist := (self calculateBrakingDistanceFromSpeedGoal: 0) + 100.
	dist := 0.
	i := 0.
	nextCar := lane getPreviousCarOnLane: self.
	currentLane := lane.
	speedGoal := maxSpeed min: lane road speedLimit.
	nextCar == self
		ifTrue: [dist := lane length
						- (lane getLengthToT: t)]
		ifFalse: [dist := (nextCar lane getLengthToT: nextCar lastPoint)
						- (lane getLengthToT: t)].
	self checkForSpeedLimit: dist.
	[dist <= maxDist]
		whileTrue: [i := i + 1.
			nextCar ~= self
				ifTrue: [speedGoal := (nextCar currentSpeed min: maxSpeed)
								min: lane road speedLimit.
					^ self].
			currentLane nextLanes isEmpty
				ifTrue: [speedGoal := 0.
					^ self].
			self addRouteEntryAt: i FromPrevLane: currentLane.
			currentLane := currentLane nextLanes
						at: (currentRoute at: i).	
			(self checkForIntersection: currentLane FromDist: dist FromIndex: i) ifTrue: [^ self].
			currentLane vehicles isEmpty
				ifTrue: [dist := dist + currentLane length]
				ifFalse: [nextCar := currentLane vehicles last.
					nextCar == self
						ifTrue: [nextCar := currentLane getPreviousCarOnLane: nextCar].
					nextCar == self
						ifTrue: [nextCar == self
								ifTrue: [dist := dist + currentLane length]]
						ifFalse: [dist := dist
										+ (currentLane getLengthToT: nextCar lastPoint).
							maxDist := (self calculateBrakingDistanceFromSpeedGoal: nextCar currentSpeed) + 100]]]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 11:39'
}
SUSVehicle >> applyMovement [
	| t rotation |
	t := lane nextTprev: lastPoint advanceByLength: deltaTime * (currentSpeed / 360).
	t >= 1
		ifTrue: [self changeLane.
			t := lastPoint].
	self applyCautiousness: t.
	self owner
		center: (lane getPositionWithTValue: t).
	rotation := lane getRotationWithTValue: t.
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
	#'squeak_changestamp' : 'PM 7/11/2024 11:39'
}
SUSVehicle >> changeLane [
	lane nextLanes isEmpty
		ifFalse: [
			lane removeVehicle: self.
			blockedOldLane := true.
			oldLane := lane.
			self addRouteEntryAt: 1 FromPrevLane: lane.
			lane := lane nextLanes at: (currentRoute at: 1).
			lane addVehicle: self.
			currentRoute removeFirst.
			lastPoint := 0.]
		ifTrue: [lastPoint := 1.]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 11:38'
}
SUSVehicle >> checkForIntersection: aLane FromDist: aDistance FromIndex: anIndex [ 
	(aLane road isBlockedFrom: aLane)
		ifFalse: [aLane road driving: self.
			^ false].
	rightOfWayTime > 0
		ifTrue: [aLane road driving: self.
			^ false].
	aDistance <= ((self calculateBrakingDistanceFromSpeedGoal: 0)
				+ 40)
		ifFalse: [aLane road driving: self.
			^ false].
	speedGoal := 0.
	currentSpeed = 0
		ifTrue: [aLane road standing: self].
	^ true
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 11:38'
}
SUSVehicle >> checkForSpeedLimit: aDistance [ 
	| nextLane |
	lane nextLanes isEmpty
		ifFalse: [self addRouteEntryAt: 1 FromPrevLane: lane.
			nextLane := lane nextLanes
						at: (currentRoute at: 1).
			aDistance <= ((self calculateBrakingDistanceFromSpeedGoal: nextLane road speedLimit)
						+ 50)
				ifTrue: [speedGoal := (nextLane road speedLimit min: lane road speedLimit)
								min: maxSpeed]]
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
	#category : #'submorphs - add/remove',
	#'squeak_changestamp' : 'PM 7/11/2024 11:05'
}
SUSVehicle >> delete [
	"Do nothing!"
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
	#'squeak_changestamp' : 'PM 7/11/2024 11:19'
}
SUSVehicle >> initialize [
	super initialize.
	maxSpeed := 100.
	acceleration := 1.
	length := 1.
	timeRoadStart := Time millisecondClock.
	lastTime := Time millisecondClock.
	currentSpeed := 0.
	maxSpeed := 50.
	speedGoal := 50.
	acceleration := 50.
	deacceleration := 100.
	length := 1.
	isAccelerating := true.
	lastPoint := 0.
	blockedOldLane := false.
	currentRoute := OrderedCollection new.
	rightOfWayTime := 0.
	self morphicLayerNumber: 15
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 11:02'
}
SUSVehicle >> lane [
	 ^ lane
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:08'
}
SUSVehicle >> lane: anObject [
	lane := anObject
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
	#category : #simulation,
	#'squeak_changestamp' : 'PM 7/11/2024 11:43'
}
SUSVehicle >> placeOnRoad: aRoad [ 
	simulation addVehicleIfNotExists: self.
	lane := aRoad lanes first.
	lane addVehicle: self.
	self
		center: (lane getPositionWithTValue: 0)
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
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:51'
}
SUSVehicle >> speedGoal: anObject [
	speedGoal := anObject
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 11:20'
}
SUSVehicle >> turnsLeftAt: aRoad [ 
	| index currentLane |
	index := 1.
	currentLane := lane.
	lane road == aRoad
		ifFalse: [[index <= currentRoute size]
				whileTrue: [currentLane := currentLane nextLanes
								at: (currentRoute at: index).
					currentLane road == aRoad
						ifTrue: [(currentRoute at: index)
									= 1
								ifTrue: [^ true]].
					index := index + 1]].
	^ false
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 7/11/2024 11:21'
}
SUSVehicle >> turnsRightAt: aRoad [ 
	| index currentLane |
	index := 1.
	currentLane := lane.
	lane road == aRoad
		ifFalse: [[index <= currentRoute size]
				whileTrue: [currentLane := currentLane nextLanes
								at: (currentRoute at: index).
					currentLane road == aRoad
						ifTrue: [(currentRoute at: index)
									= (currentLane previousLanes at: 1) nextLanes size
								ifTrue: [^ true]].
					index := index + 1]].
	^ false
]
