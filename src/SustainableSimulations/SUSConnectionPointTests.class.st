Class {
	#name : #SUSConnectionPointTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/11/2024 15:45'
}
SUSConnectionPointTests >> testAsDirectedPoint [
	| connectionPoint directedPoint |
	connectionPoint := SUSConnectionPoint new.
	connectionPoint center: 100 @ 100.
	connectionPoint direction: 1 @ 1.
	directedPoint := connectionPoint asDirectedPoint.
	self assert: directedPoint position = connectionPoint center;
		 assert: directedPoint direction = connectionPoint direction
]
