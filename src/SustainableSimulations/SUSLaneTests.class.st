"
Tests for methods of SUSLane
"
Class {
	#name : #SUSLaneTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests',
	#'squeak_changestamp' : 'MK 7/12/2024 11:25'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 17:35'
}
SUSLaneTests >> testCalculateLength [
	| lane path |
	path := LineMorph new.
	"initialisiert mit 0@0 bis
	50@50 "
	lane := SUSLane newLaneWithPath: path.
	lane calculateLength.
	self
		assert: (lane length > 70 and: lane length < 71)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:18'
}
SUSLaneTests >> testGetLengthToT [
	| lane path t |
	path := LineMorph new.
	"initialisiert mit 0@0 bis
	50@50 "
	lane := SUSLane newLaneWithPath: path.
	lane calculateLength.
	t := 0.5.
	self assert: t * lane length
			= (lane getLengthToT: 0.5)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:19'
}
SUSLaneTests >> testGetPreviousCarOnLane [
	| car1 car2 lane |
	car1 := SUSCar new.
	car2 := SUSCar new.
	lane := SUSLane new.
	lane addVehicle: car1;
		addVehicle: car2.
	self assert: (lane getPreviousCarOnLane: car2)
			= car1
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 21:18'
}
SUSLaneTests >> testRotationWith2Vertices [
	| lane path |
	path := LineMorph
				from: 0 @ 0
				to: 50 @ 50
				color: Color black
				width: 0.
	lane := SUSLane newLaneWithPath: path.
	self assert: (lane getRotationWithTValue: 0) = {1. 45};
		 assert: (lane getRotationWithTValue: 0.5) = {1. 45};
	 	 assert: (lane getRotationWithTValue: 1) = {1. 45}
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/12/2024 21:20'
}
SUSLaneTests >> testTPositionWith2Vertices [
	| lane path |
	path := LineMorph
				from: 0 @ 0
				to: 100 @ 100
				color: Color black
				width: 0.
	lane := SUSLane newLaneWithPath: path.
	self assert: ((lane getPositionWithTValue: 0.5)
				closeTo: 50 @ 50);
             assert: ((lane getPositionWithTValue: 0.3)
				closeTo: 30 @ 30)
]
