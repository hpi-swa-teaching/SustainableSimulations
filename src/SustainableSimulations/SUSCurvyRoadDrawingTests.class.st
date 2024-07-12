"
Tests for methods of SUSCurvyRoadDrawing
"
Class {
	#name : #SUSCurvyRoadDrawingTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests',
	#'squeak_changestamp' : 'MK 7/12/2024 11:24'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'MK 7/12/2024 16:01'
}
SUSCurvyRoadDrawingTests >> testCalculateBezierVerticesFrom [
	| drawing vertices directedPoint directedPoint2 |
	directedPoint := SUSDirectedPoint newWithPosition: 6 @ 10 inDirection: 10 @ 10.
	directedPoint2 := SUSDirectedPoint newWithPosition: 16 @ 5 inDirection: 20 @ 10.
	drawing := SUSCurvyRoadDrawing newFrom: directedPoint to: directedPoint2.
	vertices := drawing
				calculateBezierVerticesFrom: directedPoint
				to: directedPoint2
				withOffset: 42.
	self assert: vertices = {-24 @ 40. -39 @ 25. -3 @ 43}
]

{
	#category : #testing,
	#'squeak_changestamp' : 'PM 7/11/2024 15:44'
}
SUSCurvyRoadDrawingTests >> testGenerateVertices [
	| drawing vertices directedPoint directedPoint2 expectedVertices |
	directedPoint := SUSDirectedPoint newWithPosition: 6 @ 10 inDirection: 10 @ 10.
	directedPoint2 := SUSDirectedPoint newWithPosition: 16 @ 5 inDirection: 20 @ 10.
	drawing := SUSCurvyRoadDrawing newFrom: directedPoint to: directedPoint2.
	vertices := drawing generateVerticesFrom: directedPoint to: directedPoint2.
	Transcript showln: vertices.
	expectedVertices := {{41 @ -25. 28.28311690796322 @ -39.21688309203678. 38 @ -40}. {6 @ 10. -1.8921356237309506 @ 0.23286437626904977. 16 @ 5}. {-29 @ 45. -32.067388155425114 @ 39.682611844574886. -6 @ 50}}.
	self assert: vertices first asArray = expectedVertices first;
		 assert: vertices second asArray = expectedVertices second;
		 assert: vertices third asArray = expectedVertices third
]
