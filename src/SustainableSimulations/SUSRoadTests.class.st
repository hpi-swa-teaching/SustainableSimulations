"
Tests for methods of different roads including SUSAbstractRoad
"
Class {
	#name : #SUSRoadTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests',
	#'squeak_changestamp' : 'PM 7/12/2024 20:48'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:50'
}
SUSRoadTests >> testCreation [
	| road simulation P1 |
	simulation := SUSSimulation new.
	P1 := SUSConnectionPoint
				newForSimulation: simulation
				at: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	self assert: simulation roads isEmpty.
	road := SUSStraightRoad
				newOnSimulation: simulation
				from: P1
				to: (SUSDirectedPoint newWithPosition: 100 @ 10 inDirection: 1 @ 0).
	self assert: (simulation roads includes: road)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 21:10'
}
SUSRoadTests >> testRoadConnection [
	| simulation p1 p2 p3 road1 road2 |
	simulation := SUSSimulation new.
	p1 := simulation getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	p2 := simulation getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 110 @ 10 inDirection: 1 @ 0).
	p3 := simulation getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 310 @ 10 inDirection: 1 @ 0).
	self assert: p1 isStartingPoint.
	road1 := SUSStraightRoad
				newOnSimulation: simulation
				from: p1
				to: p2.
	road2 := SUSStraightRoad
				newOnSimulation: simulation
				from: p2
				to: p3.
	self assert: p1 isStartingPoint not;
		assert: (road1 lanes first nextLanes includes: road2 lanes first);
		assert: (road2 lanes first previousLanes includes: road1 lanes first);
		assert: (road2 lanes second nextLanes includes: road1 lanes second);
		assert: (road1 lanes second previousLanes includes: road2 lanes second)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:49'
}
SUSRoadTests >> testSpawnCar [
	| road simulation P1 |
	simulation := SUSSimulation new.
	P1 := SUSConnectionPoint
				newForSimulation: simulation
				at: (SUSDirectedPoint newWithPosition: 1 @ 10 inDirection: 1 @ 0).
	road := SUSStraightRoad
				newOnSimulation: simulation
				from: P1
				to: (SUSDirectedPoint newWithPosition: 100 @ 10 inDirection: 1 @ 0).
	self assert: road isEmpty;
		assert: simulation vehicles isEmpty;
		assert: road lanes first vehicles isEmpty.
	road spawnCarWithMaxSpeed: road speedLimit * 2.
	self assert: simulation vehicles notEmpty;
		 assert: road isEmpty not;
		 assert: road lanes first vehicles size == 1
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:59'
}
SUSRoadTests >> testTunnelDespawn [
	| simulation tunnel from car |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	tunnel := SUSTunnel
				newOnSimulation: simulation
				from: from
				to: (SUSDirectedPoint newWithPosition: 20 @ 10 inDirection: 1 @ 0).
	self assert: simulation vehicles isEmpty;
		 assert: tunnel isEmpty.
	car := SUSCar newOnRoad: tunnel withMaxSpeed: 0.
	tunnel lanes first removeVehicle: car.
	tunnel lanes second addVehicle: car.
	self assert: simulation vehicles isEmpty;
		 assert: tunnel isEmpty
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:55'
}
SUSRoadTests >> testTunnelSpawn [
	| simulation tunnel from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	tunnel := SUSTunnel
				newOnSimulation: simulation
				from: from
				to: (SUSDirectedPoint newWithPosition: 20 @ 10 inDirection: 1@0).
	self assert: simulation vehicles isEmpty;
		 assert: tunnel isEmpty.
	tunnel spawnCarFromTunnel.
	self assert: simulation vehicles size == 1;
		 assert: tunnel isEmpty not
]
