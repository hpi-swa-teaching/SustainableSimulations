Class {
	#name : #SUSCarTest,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/11/2024 11:14'
}
SUSCarTest >> testApplyAccelaration [
	| car |

	car := SUSCar new.
	car currentSpeed: 10.
	car speedGoal: 20.
	car acceleration: 5.
	car deltaTime: 1000. "DeltaTime in Millisekunden"

	car applyAcceleration.

	self assert: (car currentSpeed = (10 + (5 * 0.001 * 1000) min: 20)).
]
