Class {
	#name : #SUSCarTest,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/11/2024 15:46'
}
SUSCarTest >> testApplyAccelaration [
	| car |
	car := SUSCar new currentSpeed: 10;
				 speedGoal: 20;
				 acceleration: 5;
				 deltaTime: 1000;
				 applyAcceleration;
				 yourself.
	self assert: car currentSpeed
			= (10 + (5 * 0.001 * 1000) min: 20)
]
