"
Tests for methods of SUSRoadBuilder
"
Class {
	#name : #SUSRoadBuilderTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests',
	#'squeak_changestamp' : 'MK 7/12/2024 11:25'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:34'
}
SUSRoadBuilderTests >> testBackwardsCurvyRoad [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: (SUSDirectedPoint newWithPosition: 0 @ 10 inDirection: 0 @ 1)
				as: #CurvyRoad.
	self assert: builder isValid not;
		 assert: builder statusCurvyRoad == 2;
		 assert: builder status == 2
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:30'
}
SUSRoadBuilderTests >> testBackwardsStraightRoad [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: 0 @ 0
				as: #StraightRoad.
	self assert: builder isValid not;
		 assert: builder statusStraightRoad == 2;
		 assert: builder status == 2
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:33'
}
SUSRoadBuilderTests >> testInvalidMidpointCurvyRoad [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: (SUSDirectedPoint newWithPosition: 15 @ 30 inDirection: 1 @ 1)
				as: #CurvyRoad.
	self assert: builder isValid not;
		 assert: builder statusCurvyRoad == 5;
		 assert: builder status == 5
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:36'
}
SUSRoadBuilderTests >> testInvalidTIntersection [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: 0@5
				as: #TIntersection.
	self assert: builder isValid not;
		 assert: builder statusTIntersection == 2;
		 assert: builder status == 2
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:35'
}
SUSRoadBuilderTests >> testStraightCurvyRoad [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: (SUSDirectedPoint newWithPosition: 20 @ 10 inDirection: 1 @ 1)
				as: #CurvyRoad.
	self assert: builder isValid not;
		 assert: builder statusCurvyRoad == 4;
		 assert: builder status == 4
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:30'
}
SUSRoadBuilderTests >> testTooShortStraightRoad [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: 11 @ 10
				as: #StraightRoad.
	self assert: builder isValid not;
		 assert: builder statusStraightRoad == 3;
		 assert: builder status == 3
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 21:06'
}
SUSRoadBuilderTests >> testTryToBuildRoad [
	| simulation connectionPoint directedPoint |
	simulation := SUSSimulation new.
	directedPoint := SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 0 @ 0.
	connectionPoint := simulation getOrCreateConnectionPointAt: directedPoint.
	self assert: simulation roads isEmpty.
	simulation activeConnectionPoint: connectionPoint;
		 selectedSpawnType: #StraightRoad.
	self assert: (simulation tryToBuildRoadTo: 100 @ 100);
		 assert: simulation roads isEmpty not
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:37'
}
SUSRoadBuilderTests >> testValidCrossIntersection [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: 20@20
				as: #CrossIntersection.
	self assert: builder isValid;
		 assert: builder statusCrossIntersection == 0;
		 assert: builder status == 0
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:30'
}
SUSRoadBuilderTests >> testValidCurvyRoad [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: (SUSDirectedPoint newWithPosition: 100 @ 100 inDirection: 0 @ 1)
				as: #CurvyRoad.
	self assert: builder isValid;
		 assert: builder statusCurvyRoad == 0;
		 assert: builder status == 0
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:30'
}
SUSRoadBuilderTests >> testValidStraightRoad [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: 100 @ 100
				as: #StraightRoad.
	self assert: builder isValid;
		 assert: builder statusStraightRoad == 0;
		 assert: builder status == 0
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:36'
}
SUSRoadBuilderTests >> testValidTIntersection [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: 20@20
				as: #TIntersection.
	self assert: builder isValid;
		 assert: builder statusTIntersection == 0;
		 assert: builder status == 0
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 20:37'
}
SUSRoadBuilderTests >> testValidTunnel [
	| simulation builder from |
	simulation := SUSSimulation new.
	from := simulation
				getOrCreateConnectionPointAt: (SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 1 @ 0).
	builder := SUSRoadBuilder
				newForSimulation: simulation
				from: from
				to: 20@20
				as: #Tunnel.
	self assert: builder isValid;
		 assert: builder statusTunnel == 0;
		 assert: builder status == 0
]
