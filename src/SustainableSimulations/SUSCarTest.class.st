Class {
	#name : #SUSCarTest,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 01:46'
}
SUSCarTest >> testApplyAccelaration [
	| car |

	car := SUSCar new.
	car speed: 10.
	car speedGoal: 20.
	car acceleration: 5.
	car deltaTime: 1000. "DeltaTime in Millisekunden"

	car applyAcceleration.

	self assert: (car speed = (10 + (5 * 0.001 * 1000) min: 20)).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 01:55'
}
SUSCarTest >> testGetNextCar [
	|car1 car2 lane|
	
	car1 := SUSCar new.
	car2 := SUSCar new.
	
	lane := SUSLane new.
	lane addCar: car1.
	lane addCar: car2.
	
	self assert: (car1 getNextCar) = car2.
	
]
