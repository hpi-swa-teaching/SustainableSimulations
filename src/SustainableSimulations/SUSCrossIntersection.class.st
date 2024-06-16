Class {
	#name : #SUSCrossIntersection,
	#superclass : #SUSAbstractRoad,
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/15/2024 14:09'
}
SUSCrossIntersection >> createDrawingFrom: aConnectionPoint to: aPoint [
	| drawing |
	drawing := SUSCrossIntersectionDrawing newFrom: aConnectionPoint asDirectedPoint to: aPoint.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].
	
	self extent: drawing extent.
	self position: drawing position.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:58'
}
SUSCrossIntersection >> from: aDirectedPoint to: aPoint [
	"Do nothing, as cross intersections have a fixed size"
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/15/2024 15:41'
}
SUSCrossIntersection >> otherConnectionPointPositionsThan: aConnectionPoint [ 
	| positions directions directedPoint |
	directedPoint := aConnectionPoint asDirectedPoint.
	positions := {2 negated @ 2. 0 @ 4. 2 @ 2} * SUSDrawing normalLaneWidth.
	directions := {90. 0. 270}
				collect: [:each | aConnectionPoint direction rotateBy: each degreesToRadians about: 0 @ 0].
	^ ((1 to: 3)
		collect: [:index | SUSDirectedPoint
				newWithPosition: (directedPoint absoluteOffset: (positions at: index))
				inDirection: (directions at: index)])
		collect: [:aDirectedPoint | SUSConnectionPoint newForRoad: self at: aDirectedPoint]
]
