"
A SUSCurvyRoadDrawing is the drawing object of the curve Road.

"
Class {
	#name : #SUSCurvyRoadDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI',
	#'squeak_changestamp' : 'Len 7/10/2024 21:20'
}

{
	#category : #'class variables',
	#'squeak_changestamp' : 'Len 6/16/2024 19:55'
}
SUSCurvyRoadDrawing class >> curveResolution [
	^ 20
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'Len 7/10/2024 21:16'
}
SUSCurvyRoadDrawing class >> newFrom: aDirectedPoint to: aPoint [ 
	| cornersA cornersB corners min max from to |
	cornersA := {2 negated @ 0. 2 @ 0} * SUSDrawing normalLaneWidth
				collect: [:each | aDirectedPoint absoluteOffset: each].
	cornersB := {2 negated @ 0. 2 @ 0} * SUSDrawing normalLaneWidth
				collect: [:each | aPoint absoluteOffset: each].
	corners := cornersA , cornersB.
	min := corners min.
	max := corners max.
	from := SUSDirectedPoint newWithPosition: aDirectedPoint position - min inDirection: aDirectedPoint direction.
	to := SUSDirectedPoint newWithPosition: aPoint position - min inDirection: aPoint direction.
	^ self new addDetailFrom: from to: to;
		 addPathsFrom: from to: to;
		 extent: max - min;
		 position: min;
		 yourself
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:17'
}
SUSCurvyRoadDrawing >> addDetailFrom: aDirectedPoint to: anotherDirectedPoint [ 
	| vertices |
	vertices := self generateVerticesFrom: aDirectedPoint to: anotherDirectedPoint.
	self color: Color transparent;
		 drawRoadWithVertices: vertices;
		 drawMarkWithVertices: vertices first withMarkWidth: SUSDrawing markWidth;
		 drawMarkWithVertices: vertices second withMarkWidth: SUSDrawing markWidth * 0.75;
		 drawMarkWithVertices: vertices third withMarkWidth: SUSDrawing markWidth
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 7/12/2024 19:09'
}
SUSCurvyRoadDrawing >> addPathsFrom: aDirectedPoint to: anotherDirectedPoint [ 
	| pointA pointB pointC pointD pointE pointF |
	pointA := aDirectedPoint absoluteOffset: 0.5 * SUSDrawing normalLaneWidth @ 0.
	pointD := aDirectedPoint absoluteOffset: 0.5 * SUSDrawing normalLaneWidth negated @ 0.
	pointC := anotherDirectedPoint absoluteOffset: 0.5 * SUSDrawing normalLaneWidth @ 0.
	pointF := anotherDirectedPoint absoluteOffset: 0.5 * SUSDrawing normalLaneWidth negated @ 0.
	pointB := (SUSDirectedPoint newWithPosition: pointA inDirection: aDirectedPoint direction)
				calculateIntersectionPoint: (SUSDirectedPoint newWithPosition: pointC inDirection: anotherDirectedPoint direction).
	pointE := (SUSDirectedPoint newWithPosition: pointD inDirection: aDirectedPoint direction)
				calculateIntersectionPoint: (SUSDirectedPoint newWithPosition: pointF inDirection: anotherDirectedPoint direction).
	self addPathWithVertices: {pointA. pointB. pointC};
		 addPathWithVertices: {pointF. pointE. pointD}
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'Len 7/10/2024 21:18'
}
SUSCurvyRoadDrawing >> calculateBezierVerticesFrom: aDirectedPoint to: anotherDirectedPoint withOffset: aNumber [ 
	| pointA pointB pointC |
	pointA := aDirectedPoint absoluteOffset: aNumber @ 0.
	pointC := anotherDirectedPoint absoluteOffset: aNumber @ 0.
	pointB := (SUSDirectedPoint newWithPosition: pointA inDirection: aDirectedPoint direction)
				calculateIntersectionPoint: (SUSDirectedPoint newWithPosition: pointC inDirection: anotherDirectedPoint direction).
	^ {pointA. pointB. pointC}
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'Len 7/10/2024 21:19'
}
SUSCurvyRoadDrawing >> calculateVerticesWithL: laneLeft M: laneMid R: laneRight [
	| factor t verticesLeft verticesRight verticesMid|
	verticesLeft := OrderedCollection new.
	verticesRight := OrderedCollection new.
	verticesMid := OrderedCollection new.
	factor := laneMid length / (laneMid length / SUSCurvyRoadDrawing curveResolution).
	t := 0.
	0 to: laneMid length by: factor do: [:length | 
		verticesLeft addLast: (laneLeft getPosition3VerticesWithTValue: t).
		verticesMid addLast: (laneMid getPosition3VerticesWithTValue: t).
		verticesRight addLast: (laneRight getPosition3VerticesWithTValue: t).
		t := laneMid nextTprev: t advanceByLength: factor].
	verticesLeft addLast: (laneLeft getPosition3VerticesWithTValue: 1).
	verticesMid addLast: (laneMid getPosition3VerticesWithTValue: 1).
	verticesRight addLast: (laneRight getPosition3VerticesWithTValue: 1).
	^ {verticesLeft. verticesMid. verticesRight}
	

]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:17'
}
SUSCurvyRoadDrawing >> drawMarkWithVertices: vertices withMarkWidth: width [ 
	| markVertices |
	markVertices := OrderedCollection new.
	markVertices addAll: vertices.
	markVertices addAll: vertices reverse.
	self addMorphInLayer: ((LineMorph
			vertices: markVertices
			color: Color transparent
			borderWidth: width
			borderColor: SUSDrawing colorMark) beSmoothCurve; morphicLayerNumber: self detailLayer; yourself)
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:18'
}
SUSCurvyRoadDrawing >> drawRoadWithVertices: vertices [ 
	| roadVertices morph |
	roadVertices := OrderedCollection new.
	roadVertices addAll: vertices first.
	roadVertices addAll: vertices third reverse.
	morph := (MixedCurveMorph
				vertices: roadVertices
				color: SUSDrawing colorRoad
				borderWidth: 4
				borderColor: SUSDrawing colorRoad) morphicLayerNumber: self baseLayer;
				 toggleSmoothing;
				 yourself.
	1 to: roadVertices size do: 
			[:index | morph
				clickVertex: index
				event: nil
				fromHandle: nil].
	self addMorphInLayer: morph
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'Len 7/10/2024 21:20'
}
SUSCurvyRoadDrawing >> generateLaneWithVertices: vertices [ 
	^ SUSLane
		newLaneWithPath: (CurveMorph
				vertices: vertices
				color: (Color transparent)
				borderWidth: 2
				borderColor: SUSDrawing colorPath)
]

{
	#category : #calculation,
	#'squeak_changestamp' : 'Len 7/10/2024 21:20'
}
SUSCurvyRoadDrawing >> generateVerticesFrom: aDirectedPoint to: anotherDirectedPoint [ 
	| laneLeft laneMid laneRight|
	laneLeft := self generateLaneWithVertices: (self calculateBezierVerticesFrom: aDirectedPoint to: anotherDirectedPoint withOffset: SUSDrawing normalLaneWidth negated).
	laneMid := self generateLaneWithVertices: (self calculateBezierVerticesFrom: aDirectedPoint to: anotherDirectedPoint withOffset: 0).
	laneRight := self generateLaneWithVertices: (self calculateBezierVerticesFrom: aDirectedPoint to: anotherDirectedPoint withOffset: SUSDrawing normalLaneWidth).
	^ self calculateVerticesWithL: laneLeft M: laneMid R: laneRight
	

]
