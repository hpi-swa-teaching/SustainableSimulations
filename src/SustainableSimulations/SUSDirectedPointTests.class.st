Class {
	#name : #SUSDirectedPointTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/15/2024 13:47'
}
SUSDirectedPointTests >> testCalculateIntersectionPoint [
	| line1 line2 intersectionPoint expectedPoint |
	
	line1 := SUSDirectedPoint new.
	line1 position: 0@0.
	line1 direction: 1@1.

    
	line2 := SUSDirectedPoint new.
	line2 position: 0@1.
	line2 direction: 1@(-1).

	expectedPoint := 0.5@0.5.
	intersectionPoint := line1 calculateIntersectionPoint: line2.

	self assert: intersectionPoint = expectedPoint.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/15/2024 14:03'
}
SUSDirectedPointTests >> testLinearDistance [

	| directedPoint point distance expectedDistance |
	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0@0.
	directedPoint direction: 2@2.
	
	point := 2@0.
	expectedDistance := 1.414213562.
	distance := directedPoint linearDist: point.
	
	self assert: (distance - expectedDistance abs < 0.0001)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/15/2024 13:45'
}
SUSDirectedPointTests >> testParallelLines [
	| line1 line2 |
	line1 := SUSDirectedPoint new.
	line1 position: 0@0.
	line1 direction: 1@1.

	line2 := SUSDirectedPoint new.
	line2 position: 1@1.
	line2 direction: 1@1.

	self should: [ line1 calculateIntersectionPoint: line2 ] raise: Error.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/17/2024 09:57'
}
SUSDirectedPointTests >> testPointAbove [
	| directedPoint pointOnLine pointAbove pointBelow |

	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0@0.
	directedPoint direction: 1@0.

	pointOnLine := 2@0.
	self assert: (directedPoint isAbove: pointOnLine) = 0.

	pointAbove := 2@1.
	self assert: (directedPoint isAbove: pointAbove) > 0.
	
	pointBelow := 2@3 negated.
	self assert: (directedPoint isAbove: pointBelow) < 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/17/2024 10:31'
}
SUSDirectedPointTests >> testPointBehind [
	| directedPoint pointBehind pointAhead pointOnLine |

	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0@0.
	directedPoint direction: 1@0.

	pointBehind := 1 negated@2.
	self assert: ((directedPoint isBehind: pointBehind) < 0).

	pointAhead := 3@2.
	self assert: ((directedPoint isBehind: pointAhead) > 0).
	
	pointOnLine := 0@1 negated.
	self assert: ((directedPoint isBehind: pointOnLine) = 0)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/15/2024 13:46'
}
SUSDirectedPointTests >> testProjectionOfPoint [
	| directedPoint point projection expectedProjection |

	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0@0.
	directedPoint direction: 1@1.

	point := 1@0.

	expectedProjection := 0.5@0.5.
	projection := directedPoint projectionOf: point.
	self assert: projection = expectedProjection.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/15/2024 13:46'
}
SUSDirectedPointTests >> testProjectionOfPointWithZeroDirection [
	| directedPoint point projection |

	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0@0.
	directedPoint direction: 0@0.

	point := 1@0.
	projection := directedPoint projectionOf: point.
	self assert: projection = point.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/15/2024 15:03'
}
SUSDirectedPointTests >> testRelativeOffset [
	| directedPoint point result expectedOffset |
	
	directedPoint := SUSDirectedPoint new.
	directedPoint position: 0@0.
	directedPoint direction: 1@0.

	point := 3@4.
	expectedOffset := 4@3.
	result := directedPoint relativeOffset: point.
	
	Transcript show: result; cr; 
		show: expectedOffset; cr.
	self assert: result = expectedOffset.
]
