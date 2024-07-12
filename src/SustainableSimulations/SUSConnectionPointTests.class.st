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
	#'squeak_changestamp' : 'PM 7/12/2024 21:28'
}
SUSConnectionPointTests >> testAsDirectedPoint [
	| connectionPoint directedPoint |
	connectionPoint := SUSConnectionPoint new center: 100 @ 100;
				 direction: 1 @ 1;
				 yourself.
	directedPoint := connectionPoint asDirectedPoint.
	self assert: directedPoint position = connectionPoint center;
		 assert: directedPoint direction = connectionPoint direction
]
