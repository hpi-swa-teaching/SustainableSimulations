"
Tests for methods of SUSVehicle and SUSCar
"
Class {
	#name : #SUSVehicleTest,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests',
	#'squeak_changestamp' : 'MK 7/12/2024 16:28'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:00'
}
SUSVehicleTest >> testApplyAccelaration [
	| car |
	car := SUSCar new currentSpeed: 10;
				 speedGoal: 20;
				 acceleration: 5;
				 deltaTime: 1000;
				 applyAcceleration;
				 yourself.
	self assert: car currentSpeed = 15
]
