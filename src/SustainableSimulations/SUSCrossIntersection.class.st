Class {
	#name : #SUSCrossIntersection,
	#superclass : #SUSAbstractRoad,
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/13/2024 00:52'
}
SUSCrossIntersection >> createDrawingFrom: aConnectionPoint to: aPoint [
	| drawing |
	drawing := SUSCrossIntersectionDrawing newWithDegrees: aConnectionPoint direction degrees.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].
	
	self extent: drawing extent.
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
	#'squeak_changestamp' : 'PM 6/13/2024 00:56'
}
SUSCrossIntersection >> otherConnectionPointPositionsThan: aConnectionPoint [
	| positions directions |
	positions := {0.5 @ 0. 1 @ 0.5. 0.5 @ 1}.
	directions := {90 . 180. 270 } collect: [:each | aConnectionPoint direction rotateBy: each degreesToRadians about: 0@0 ].
	^ (1 to: 4)
		collect: [:index | (SUSConnectionPoint
				newForRoad: self
				withDirection: (directions at: index))
				center: (self extent * positions at: index);
				 yourself]
]
