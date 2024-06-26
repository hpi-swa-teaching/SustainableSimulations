Class {
	#name : #SUSLaneTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/22/2024 23:59'
}
SUSLaneTests >> testCalculateLength [
	| lane path |
	
	path := LineMorph new. "initialisiert mit 0@0 bis 50@50"
	lane := SUSLane newLaneWithPath: path.
	lane calculateLength.

	self assert: (lane length > 70 and: lane length < 71).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 00:05'
}
SUSLaneTests >> testGetLengthToT [
	|lane path t|
	
	path := LineMorph new. "initialisiert mit 0@0 bis 50@50"
	lane := SUSLane newLaneWithPath: path.
	lane calculateLength.
	
	t := 0.5.
	
	self assert: t* lane length = (lane getLengthToT: 0.5)

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 00:10'
}
SUSLaneTests >> testGetNextCarOnLane [
	|car1 car2 lane|
	
	car1 := SUSCar new.
	car2 := SUSCar new.
	
	lane := SUSLane new.
	lane addCar: car1.
	lane addCar: car2.
	
	self assert: (lane getNextCarOnLane: car1) = car2.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 00:12'
}
SUSLaneTests >> testGetPreviousCarOnLane [
	|car1 car2 lane|
	
	car1 := SUSCar new.
	car2 := SUSCar new.
	
	lane := SUSLane new.
	lane addCar: car1.
	lane addCar: car2.
	
	self assert: (lane getPreviousCarOnLane: car2) = car1.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 00:20'
}
SUSLaneTests >> testGetRotation2VerticesWithTValue [
	|lane path rotation expectedRotation|
	
	path := LineMorph new.
	lane := SUSLane newLaneWithPath: path.
	
	rotation := lane getRotation2VerticesWithTValue: 0.
	expectedRotation := {1. ((50 - 0) / (50 - 0)) arcTan radiansToDegrees}.
	
	self assert: (rotation = expectedRotation).
]
