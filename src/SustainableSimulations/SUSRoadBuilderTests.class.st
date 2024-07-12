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
	#'squeak_changestamp' : 'MK 7/12/2024 16:24'
}
SUSRoadBuilderTests >> testTryToBuildRoad [
	| simulation connectionPoint directedPoint |
	simulation := SUSSimulation new.
	simulation initialize.
	directedPoint := SUSDirectedPoint newWithPosition: 10 @ 10 inDirection: 100 @ 100.
	connectionPoint := SUSConnectionPoint newForSimulation: simulation at: directedPoint.
	simulation activeConnectionPoint: connectionPoint;
		 selectedSpawnType: #StraightRoad.
	self assert: (simulation tryToBuildRoadTo: 50 @ 50)
			= true
]
