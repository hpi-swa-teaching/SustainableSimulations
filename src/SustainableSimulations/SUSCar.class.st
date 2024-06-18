Class {
	#name : #SUSCar,
	#superclass : #SUSVehicle,
	#instVars : [
		'driver',
		'fuelLevel',
		'timeRoadStart',
		'blockedOldLane',
		'oldLane',
		'lastL'
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
	#'squeak_changestamp' : 'GoChriNo 6/17/2024 12:12'
}
SUSCar >> applyAcceleration [
	self speed < speedGoal
		ifTrue: [self speed: self speed + (self acceleration * 0.001 * self deltaTime).
			self speed > self speedGoal
				ifTrue: [self speed: self speedGoal]]
		ifFalse: [self speed: self speed - (self deacceleration * 0.001 * self deltaTime).
			self speed < self speedGoal
				ifTrue: [self speed: self speedGoal]]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'PM 6/18/2024 10:33'
}
SUSCar >> applyBehavior [
	self deltaTime: Time millisecondClock - self lastTime;
		lastTime: Time millisecondClock;
		applyAcceleration;
		applyMovement
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/17/2024 12:41'
}
SUSCar >> applyCautiousness [
	| nextCar dist diffSpeed |
	nextCar := self getNextCar.
	nextCar == self
		ifTrue: [self lane nextLanes isEmpty
				ifTrue: [dist := self owner center
								dist: (self lane getPositionWithTValue: 1).
					dist <= (self speed squared / (self deacceleration * 2) * 1000 / 360 + 10 + (0.5 * self speed))
						ifTrue: [self speedGoal: 0]
						ifFalse: [self speedGoal: self maxSpeed]]
				ifFalse: [self speedGoal: self maxSpeed]]
		ifFalse: [(self isOnOwnLane: nextCar)
				ifTrue: [dist := nextCar lastPoint - self lastPoint * self lane length]
				ifFalse: [dist := 1 - self lastPoint * self lane length + (nextCar lastPoint * nextCar lane length)].
			diffSpeed := self speed - nextCar speed.
			dist <= (diffSpeed squared / (self deacceleration * 2) * 1000 / 360 + 50 + (0.5 * self speed))
				ifTrue: [self speedGoal: nextCar speed]
				ifFalse: [self speedGoal: self maxSpeed]]
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/17/2024 12:18'
}
SUSCar >> applyMovement [
	| t rotation |
	t := lane nextTprev: lastPoint advanceByLength: (self deltaTime * (self speed / 360)).
	t >= 1
		ifTrue: [self changeLane.
			t := lastPoint].
	self applyCautiousness.
	self owner
		center: (self lane getPositionWithTValue: t).
	rotation := lane getRotationWithTValue: t.
	rotation first = 1
		ifTrue: [self rotationDegrees: rotation second].
	self lastPoint: t
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 21:52'
}
SUSCar >> calculateNewT [
	| difTime t maxT |
	difTime := (Time millisecondClock) - lastPoint second.
	lastL := (difTime * (speed / 360)).
	t := lane nextTprev: lastPoint first advanceByLength: lastL.
	maxT := self calculateNewMaxT.
	
	t > maxT 
		ifTrue: [t := maxT].
	t > lane blockedT
		ifTrue: [t := lane blockedT].
	
	self updateLaneConnectionsWithT: t.
	^ {t. (Time millisecondClock)}
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/14/2024 15:19'
}
SUSCar >> changeLane [
	lane nextLanes isEmpty
		ifFalse: [
			| random |
			random := Random new.
			lane removeCar: self.
			blockedOldLane := true.
			oldLane := lane.
			"lane := lane nextLanes first."
			lane := (lane nextLanes at: (random nextInt: (lane nextLanes size))).
			lane addCar: self.
			lastPoint := 0.]
		ifTrue: [lastPoint := 1.]
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
	#category : #accessing,
	#'squeak_changestamp' : 'ek 5/19/2024 16:45'
}
SUSCar >> driver [
		
	^ driver
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ek 5/19/2024 16:39'
}
SUSCar >> driver: aString [
		
	driver := aString.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ek 5/19/2024 16:46'
}
SUSCar >> fuelLevel [
	
	^ fuelLevel
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ek 5/19/2024 16:38'
}
SUSCar >> fuelLevel: aNumber [
	
	fuelLevel := aNumber.
	
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/16/2024 11:14'
}
SUSCar >> getNextCar [
	| nextCar |
	nextCar := self lane getPreviousCarOnLane: self.
	nextCar = self
		ifTrue: [self lane nextLanes
				do: [:each | each cars isEmpty
						ifFalse: [^ each cars last]].
			^ self].
	^ nextCar
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/18/2024 11:32'
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
	
	self extent: 30@15;
		color: Color red;
		addFlexShellIfNecessary
]

{
	#category : #behavior,
	#'squeak_changestamp' : 'GoChriNo 6/16/2024 11:14'
}
SUSCar >> isOnOwnLane: aVehicle [ 
	^ self lane == aVehicle lane
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/10/2024 23:31'
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
