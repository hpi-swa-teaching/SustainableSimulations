Class {
	#name : #SUSAbstractRoadTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/11/2024 15:48'
}
SUSAbstractRoadTests >> testInitializeFromTo [
	| P1 P2 simulation road |
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
