Class {
	#name : #SUSConnectionPointTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/20/2024 16:43'
}
SUSConnectionPointTests >> testAsDirectedPoint [

	| connectionPoint directedPoint |

	connectionPoint := SUSConnectionPoint new.
	connectionPoint center: 100@100.
	connectionPoint direction: 1@1.

	directedPoint := connectionPoint asDirectedPoint.

	self assert: directedPoint position = connectionPoint center.
	self assert: directedPoint direction = connectionPoint direction.
]
