"
Tests for methods of SUSDirectedPoint
"
Class {
	#name : #SUSDirectedPointTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests',
	#'squeak_changestamp' : 'MK 7/12/2024 11:24'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:15'
}
SUSDirectedPointTests >> testCalculateIntersectionPoint [
	| line1 line2 |
	line1 := SUSDirectedPoint new.
	line1 position: 0 @ 0;
		 direction: 1 @ 1.
	line2 := SUSDirectedPoint new.
	line2 position: 0 @ 1;
		 direction: 1 @ -1.
	self assert: (line1 calculateIntersectionPoint: line2)
			= (0.5 @ 0.5)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:04'
}
SUSDirectedPointTests >> testIsAbove [
	| directedPoint |
	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0 @ 0;
		 direction: 1 @ 0.
	self assert: (directedPoint isAbove: 1 @ 0)
			= 0.
	self assert: (directedPoint isAbove: 1 @ 1)
			> 0.
	self assert: (directedPoint isAbove: 1 @ -1)
			< 0
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:07'
}
SUSDirectedPointTests >> testLinearDistance [
	| directedPoint |
	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0 @ 0;
		 direction: 2 @ 2.
	self assert: (directedPoint linearDist: 2 @ 0)
			= 2 sqrt
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:11'
}
SUSDirectedPointTests >> testParallelLines [
	| line1 line2 |
	line1 := SUSDirectedPoint new.
	line1 position: 0 @ 0;
		 direction: 1 @ 1.
	line2 := SUSDirectedPoint new.
	line2 position: 1 @ 1;
		 direction: 1 @ 1.
	self 
		should: [line1 calculateIntersectionPoint: line2]
		raise: Error
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:13'
}
SUSDirectedPointTests >> testPointBehind [
	| directedPoint |
	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0 @ 0;
		 direction: 1 @ 0.
	self assert: (directedPoint isBehind: -1 @ 2)
			< 0.
	self assert: (directedPoint isBehind: 3 @ 2)
			> 0.
	self assert: (directedPoint isBehind: 0 @ -1)
			= 0
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:15'
}
SUSDirectedPointTests >> testProjectionOfPoint [
	| directedPoint |
	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0 @ 0;
		 direction: 1 @ 1.
	self assert: (directedPoint projectionOf: 1 @ 0)
			= (0.5 @ 0.5)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:16'
}
SUSDirectedPointTests >> testProjectionOfPointWithZeroDirection [
	| directedPoint |
	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0 @ 0;
		 direction: 0 @ 0.
	self assert: (directedPoint projectionOf: 1 @ 0)
			= (1 @ 0)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:17'
}
SUSDirectedPointTests >> testRelativeOffset [
	| directedPoint result expectedOffset |
	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0 @ 0;
		 direction: 1 @ 0.
	expectedOffset := 4 @ 3.
	result := directedPoint relativeOffset: 3 @ 4.
	Transcript show: result;
		 cr;
		 show: expectedOffset;
		 cr.
	self assert: result = expectedOffset.
]
