Class {
	#name : #SUSCar,
	#superclass : #SUSVehicle,
	#instVars : [
		'driver',
		'fuelLevel',
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
	#'squeak_changestamp' : 'GoChriNo 6/17/2024 12:12'
}
SUSCar class >> newOnRoad: aRoad withSpeed: aNumber [
	^ self new 
		simulation: aRoad simulation;
		maxSpeed: aNumber;
		placeCarOnRoad: aRoad;
		yourself
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/22/2024 09:26'
}
SUSCar >> addRouteEntryAt: anIndex FromPrevLane: aLane [ 
	route size < anIndex
		ifTrue: [route
				addLast: (Random new nextInt: aLane nextLanes size)]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'MK 6/23/2024 01:40'
}
SUSCar >> applyAcceleration [
	speed < speedGoal
		ifTrue: [speed := (speed + (acceleration * 0.001 * deltaTime) min: speedGoal)]
		ifFalse: [speed := (speed - (deacceleration * 0.001 * deltaTime) max:  speedGoal)]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 11:39'
}
SUSCar >> applyBehavior [
	deltaTime := Time millisecondClock - lastTime.
	lastTime := Time millisecondClock.
	rightOfWayTime := (rightOfWayTime - deltaTime) max: 0.
	self applyAcceleration; 
		applyMovement
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 12:58'
}
SUSCar >> applyCautiousness: t [ 
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
				ifTrue: [speedGoal := (nextCar speed min: maxSpeed)
								min: lane road speedLimit.
					^ self].
			currentLane nextLanes isEmpty
				ifTrue: [speedGoal := 0.
					^ self].
			self addRouteEntryAt: i FromPrevLane: currentLane.
			currentLane := currentLane nextLanes
						at: (route at: i).	
			(self checkForIntersection: currentLane FromDist: dist FromIndex: i) ifTrue: [^ self].
			currentLane cars isEmpty
				ifTrue: [dist := dist + currentLane length]
				ifFalse: [nextCar := currentLane cars last.
					nextCar == self
						ifTrue: [nextCar := currentLane getPreviousCarOnLane: nextCar].
					nextCar == self
						ifTrue: [nextCar == self
								ifTrue: [dist := dist + currentLane length]]
						ifFalse: [dist := dist
										+ (currentLane getLengthToT: nextCar lastPoint).
							maxDist := (self calculateBrakingDistanceFromSpeedGoal: nextCar speed) + 100]]]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/22/2024 09:45'
}
SUSCar >> applyMovement [
	| t rotation |
	t := lane nextTprev: lastPoint advanceByLength: deltaTime * (speed / 360).
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
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 09:28'
}
SUSCar >> calculateBrakingDistanceFromSpeedGoal: aSpeed [ 
	^ (speed - aSpeed) squared / (deacceleration * 2) * 1000 / 360 + (0.5 * speed)
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/19/2024 22:16'
}
SUSCar >> changeLane [
	lane nextLanes isEmpty
		ifFalse: [
			lane removeCar: self.
			blockedOldLane := true.
			oldLane := lane.
			self addRouteEntryAt: 1 FromPrevLane: lane.
			lane := lane nextLanes at: (route at: 1).
			lane addCar: self.
			route removeFirst.
			lastPoint := 0.]
		ifTrue: [lastPoint := 1.]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/27/2024 14:12'
}
SUSCar >> checkForIntersection: aLane FromDist: aDistance FromIndex: anIndex [ 
	(aLane road isBlockedFrom: aLane)
		ifFalse: [aLane road driving: self.
			^ false].
	rightOfWayTime > 0
		ifTrue: [aLane road driving: self.
			^ false].
	aDistance <= ((self calculateBrakingDistanceFromSpeedGoal: 0)
				+ 10)
		ifFalse: [aLane road driving: self.
			^ false].
	speedGoal := 0.
	speed = 0
		ifTrue: [aLane road standing: self].
	^ true
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 09:32'
}
SUSCar >> checkForSpeedLimit: aDistance [
	| nextLane |
	lane nextLanes isEmpty ifFalse: [
		self addRouteEntryAt: 1 FromPrevLane: lane.
			nextLane := lane nextLanes
						at: (route at: 1).
			aDistance
					<= ((self calculateBrakingDistanceFromSpeedGoal: nextLane road speedLimit) + 50)
				ifTrue: [speedGoal := (nextLane road speedLimit min: lane road speedLimit) min: maxSpeed]]

	
]

{
	#category : #visualization,
	#'squeak_changestamp' : 'MK 5/19/2024 13:00'
}
SUSCar >> drawFrontMarkerOn: aCanvas [
    | frontMarkerBounds |
    frontMarkerBounds := (self bounds origin x + self width - 10 @ self bounds origin y extent: 10 @ self height).
    aCanvas fillRectangle: frontMarkerBounds color: Color yellow.
    aCanvas frameRectangle: frontMarkerBounds width: 2 color: Color black.
]

{
	#category : #visualization,
	#'squeak_changestamp' : 'MK 5/19/2024 13:00'
}
SUSCar >> drawOn: aCanvas [
    super drawOn: aCanvas.
    self drawFrontMarkerOn: aCanvas.
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/22/2024 09:21'
}
SUSCar >> getNextCar [
	| nextCar |
	nextCar := lane getPreviousCarOnLane: self.
	nextCar == self
		ifTrue: [lane nextLanes
				do: [:each | each cars isEmpty
						ifFalse: [^ each cars last]].
			^ self].
	^ nextCar
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 11:38'
}
SUSCar >> initialize [
	super initialize.
	
	timeRoadStart := Time millisecondClock.
	lastTime := Time millisecondClock.
	speed := 0.
	maxSpeed := 50.
	speedGoal := 50.
	acceleration := 50.
	deacceleration := 100.
	length := 1.
	driver := 'Unknown'.
	fuelLevel := 100.
	isAccelerating := true.
	lastPoint := 0.
	blockedOldLane := false.
	route := OrderedCollection new.
	rightOfWayTime := 0.
	
	self extent: 30@15;
		color: Color red;
		addFlexShellIfNecessary
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 6/22/2024 09:21'
}
SUSCar >> isOnOwnLane: aVehicle [ 
	^ lane == aVehicle lane
]

{
	#category : #utility,
	#'squeak_changestamp' : 'Len 6/20/2024 20:21'
}
SUSCar >> placeCarOnRoad: aRoad [

	simulation addCar: self.
	lane := aRoad lanes first.
	lane addCar: self.
	
	self center: (lane getPositionWithTValue: 0)
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 6/9/2024 23:58'
}
SUSCar >> postInitialization [
	"TMP Method to spawn a simple car"
	simulation addCar: self.
	lane := simulation roads first lanes first.
	lane addCar: self.
	
	self center: (lane getPositionWithTValue: 0)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 11:40'
}
SUSCar >> rightOfWayTime [
	^ rightOfWayTime
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/26/2024 11:40'
}
SUSCar >> rightOfWayTime: anObject [
	rightOfWayTime := anObject
]
