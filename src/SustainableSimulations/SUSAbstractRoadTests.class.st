"
Tests for methods of SUSAbstractRoad and of all classes that inherit from SUSCurve
"
Class {
	#name : #SUSAbstractRoadTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests',
	#'squeak_changestamp' : 'MK 7/12/2024 13:37'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:00'
}
SUSAbstractRoadTests >> testInitializeFromTo [
	| road simulation P1 P2 |
	simulation := SUSSimulation new.
	P1 := SUSConnectionPoint
				newForSimulation: simulation
				at: (SUSDirectedPoint newWithPosition: 1 @ 1 inDirection: 1 @ 1).
	P2 := SUSConnectionPoint
				newForSimulation: simulation
				at: (SUSDirectedPoint newWithPosition: 2 @ 2 inDirection: 1 @ 1).
	P2 := P2 asDirectedPoint.
	road := SUSStraightRoad
				newOnSimulation: simulation
				from: P1
				to: P2.
	self
		assert: (simulation roads includes: road)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 12:14'
}
SUSAbstractRoadTests >> testIsEmpty [
	| road simulation P1 P2 |
	simulation := SUSSimulation new.
	P1 := SUSConnectionPoint
				newForSimulation: simulation
				at: (SUSDirectedPoint newWithPosition: 1 @ 1 inDirection: 1 @ 1).
	P2 := SUSConnectionPoint
				newForSimulation: simulation
				at: (SUSDirectedPoint newWithPosition: 2 @ 2 inDirection: 1 @ 1).
	P2 := P2 asDirectedPoint.
	road := SUSStraightRoad
				newOnSimulation: simulation
				from: P1
				to: P2.
	self assert: road isEmpty
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/11/2024 15:48'
}
SUSAbstractRoadTests >> testSpawnCar [
	| road simulation P1 P2 |
	simulation := SUSSimulation new.
	P1 := SUSConnectionPoint
				newForSimulation: simulation
				at: (SUSDirectedPoint newWithPosition: 1 @ 1 inDirection: 1 @ 1).
	P2 := SUSConnectionPoint
				newForSimulation: simulation
				at: (SUSDirectedPoint newWithPosition: 2 @ 2 inDirection: 1 @ 1).
	P2 := P2 asDirectedPoint.
	road := SUSStraightRoad
				newOnSimulation: simulation
				from: P1
				to: P2.
	road spawnCarWithMaxSpeed: 50.
	self assert: simulation vehicles notEmpty
]
