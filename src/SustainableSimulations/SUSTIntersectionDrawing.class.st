Class {
	#name : #SUSTIntersectionDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 15:38'
}
SUSTIntersectionDrawing class >> newFrom: aDirectedPoint to: aPoint [
	| corners min max from to |
	corners := ({2 negated@0 . 2 negated@4 . 2@4 . 2@0} * SUSDrawing normalLaneWidth) collect: [:each | aDirectedPoint absoluteOffset: each].
	min := corners min.
	max := corners max.
	from := SUSDirectedPoint newWithPosition: (aDirectedPoint position - min) inDirection: aDirectedPoint direction.
	to := aPoint - min.
	^ self new addDetailFrom: from to: to;
		addPathsFrom: from to: to;
		extent: max - min;
		position: min;
		yourself.
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/25/2024 10:24'
}
SUSTIntersectionDrawing >> addBaseFrom: aDirectedPoint [ 
	| vertices |
	vertices := {2 negated @ 1. 2 negated @ 3. 1 negated @ 3. 1 negated @ 4. 1 @ 4. 1 @ 0. 1 negated @ 0. 1 negated @ 1.} * SUSDrawing normalLaneWidth.
	self addMorphInLayer: ((PolygonMorph
			vertices: (vertices
					collect: [:aPoint | aDirectedPoint absoluteOffset: aPoint])
			color: SUSDrawing colorRoad
			borderWidth: 4
			borderColor: SUSDrawing colorRoad) morphicLayerNumber: self baseLayer;
			 yourself)
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/15/2024 14:58'
}
SUSTIntersectionDrawing >> addCurveFrom: aDirectedPoint withVertices: vertices [
	self addMorphInLayer: ((LineMorph
			vertices: (vertices * SUSDrawing normalLaneWidth
					collect: [:aPoint | aDirectedPoint absoluteOffset: aPoint])
			color: Color transparent
			borderWidth: SUSDrawing markWidth
			borderColor: SUSDrawing colorMark) beSmoothCurve; 
			morphicLayerNumber: self detailLayer;
			yourself).
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/25/2024 10:29'
}
SUSTIntersectionDrawing >> addCurvesFrom: aDirectedPoint [
	self addCurveFrom: aDirectedPoint withVertices: {1 negated@0. 1 negated@0.7. 1.3 negated@1. 2 negated@1. 1.3 negated@1. 1 negated@0.7};
		addCurveFrom: aDirectedPoint withVertices: {2 negated@3 . 1.3 negated@3 . 1 negated @ 3.3 . 1 negated @ 4 . 1 negated @ 3.3 . 1.3 negated@3}
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/25/2024 10:36'
}
SUSTIntersectionDrawing >> addDetailFrom: aDirectedPoint to: aPoint [
	self color: Color transparent;
		addBaseFrom: aDirectedPoint;
		addCurvesFrom: aDirectedPoint;
		addMarkFrom: (aDirectedPoint absoluteOffset: 1@4 * SUSDrawing normalLaneWidth) to: (aDirectedPoint absoluteOffset: 1@0 * SUSDrawing normalLaneWidth)
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/15/2024 15:08'
}
SUSTIntersectionDrawing >> addPathFrom: aDirectedPoint withVertices: aCollection [
	self addPathWithVertices: (aCollection * SUSDrawing normalLaneWidth collect: [:aPoint | aDirectedPoint absoluteOffset: aPoint ])
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/25/2024 10:39'
}
SUSTIntersectionDrawing >> addPathsFrom: aDirectedPoint to: aPoint [
	"From left"
	self addPathFrom: aDirectedPoint withVertices: { 0.5@0 . 0.5@2.5 . 2 negated@2.5 }; "Left"
		addPathFrom: aDirectedPoint withVertices: { 0.5@0 . 0.5@2 . 0.5@4 }. "Straight"
	
	"From right"
	self addPathFrom: aDirectedPoint withVertices: { 0.5 negated@4 . 0.5 negated@2 . 0.5 negated@0 }; "Straight"
		addPathFrom: aDirectedPoint withVertices: { 0.5 negated@4 . 0.5 negated@2.5 . 2 negated@2.5 }. "Right"
	
	"From top"
	self addPathFrom: aDirectedPoint withVertices: { 2 negated@1.5 . 0.5@1.5 . 0.5@4 }; "Left"
		addPathFrom: aDirectedPoint withVertices: { 2 negated@1.5 . 0.5 negated@1.5 . 0.5 negated@0 } "Right"
	
]
