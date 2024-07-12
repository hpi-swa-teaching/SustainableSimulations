"
Tests for methods of SUSConnectionPoint
"
Class {
	#name : #SUSConnectionPointTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests',
	#'squeak_changestamp' : 'MK 7/12/2024 11:24'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:00'
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
