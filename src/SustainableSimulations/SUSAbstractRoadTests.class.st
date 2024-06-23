Class {
	#name : #SUSAbstractRoadTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 00:59'
}
SUSAbstractRoadTests >> testInitializeFromTo [
	|P1 P2 simulation road|
	
	simulation := SUSSimulation new.
	P1 := SUSConnectionPoint newForSimulation: simulation at: (SUSDirectedPoint newWithPosition: 1@1 inDirection: 1@1).
	P2 := SUSConnectionPoint newForSimulation: simulation at: (SUSDirectedPoint newWithPosition: 2@2 inDirection: 1@1).
	P2 := P2 asDirectedPoint.

	road := SUSStraightRoad newOnSimulation: simulation from: P1 to: P2.
	
	self assert: (simulation roads includes: road).
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 01:24'
}
SUSAbstractRoadTests >> testSpawnCar [
	| road simulation P1 P2|
	
	simulation := SUSSimulation new.
	
	P1 := SUSConnectionPoint newForSimulation: simulation at: (SUSDirectedPoint newWithPosition: 1@1 inDirection: 1@1).
	P2 := SUSConnectionPoint newForSimulation: simulation at: (SUSDirectedPoint newWithPosition: 2@2 inDirection: 1@1).
	P2 := P2 asDirectedPoint.

	road := SUSStraightRoad newOnSimulation: simulation from: P1 to: P2.
	
	road spawnCar.
	
	self assert: (simulation cars notEmpty).
]
