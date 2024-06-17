Class {
	#name : #SUSCrossIntersectionDrawing,
	#superclass : #SUSDrawing,
	#instVars : [
		'curveA'
	],
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 15:38'
}
SUSCrossIntersectionDrawing class >> newFrom: aDirectedPoint to: aPoint [
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 19:48'
}
SUSCrossIntersectionDrawing >> addBaseFrom: aDirectedPoint [ 
	| vertices |
	"vertices := {2 negated @ 0. 2 negated @ 4. 2 @ 4. 2 @ 0} * SUSDrawing normalLaneWidth."
	vertices := {2 negated @ 1. 2 negated @ 3. 1 negated @ 3. 1 negated @ 4. 1 @ 4. 1 @ 3. 2 @ 3. 2 @ 1. 1 @ 1. 1 @ 0. 1 negated @ 0. 1 negated @ 1.} * SUSDrawing normalLaneWidth.
	self addMorphInLayer: ((PolygonMorph
			vertices: (vertices
					collect: [:aPoint | aDirectedPoint absoluteOffset: aPoint])
			color: SUSDrawing colorRoad
			borderWidth: 4
			borderColor: SUSDrawing colorRoad) morphicLayerNumber: self baseLayer;
			 yourself)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 15:06'
}
SUSCrossIntersectionDrawing >> addCrossInterMarksFrom: aDirectedPoint [
	self addMarkFrom: (aDirectedPoint absoluteOffset: 0@0) to: (aDirectedPoint absoluteOffset: 0@0.6 * SUSDrawing normalLaneWidth);
		addMarkFrom: (aDirectedPoint absoluteOffset: 0@3.4 * SUSDrawing normalLaneWidth) to: (aDirectedPoint absoluteOffset: 0@4 * SUSDrawing normalLaneWidth);
		addMarkFrom: (aDirectedPoint absoluteOffset: 2 negated@2 * SUSDrawing normalLaneWidth) to: (aDirectedPoint absoluteOffset: 1.4 negated@2 * SUSDrawing normalLaneWidth);
		addMarkFrom: (aDirectedPoint absoluteOffset: 1.4@2 * SUSDrawing normalLaneWidth) to: (aDirectedPoint absoluteOffset: 2@2 * SUSDrawing normalLaneWidth);
		addMidMarkFrom: (aDirectedPoint absoluteOffset: 1.4 negated@1 * SUSDrawing normalLaneWidth) to: (aDirectedPoint absoluteOffset: 1.4 negated@2 * SUSDrawing normalLaneWidth);
		addMidMarkFrom: (aDirectedPoint absoluteOffset: 1.4@3 * SUSDrawing normalLaneWidth) to: (aDirectedPoint absoluteOffset: 1.4@2 * SUSDrawing normalLaneWidth).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 14:58'
}
SUSCrossIntersectionDrawing >> addCurveFrom: aDirectedPoint withVertices: vertices [
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/17/2024 10:21'
}
SUSCrossIntersectionDrawing >> addCurvesFrom: aDirectedPoint [
	self addCurveFrom: aDirectedPoint withVertices: {1 negated@0. 1 negated@0.7. 1.3 negated@1. 2 negated@1. 1.3 negated@1. 1 negated@0.7};
		addCurveFrom: aDirectedPoint withVertices: {2 negated@3 . 1.3 negated@3 . 1 negated @ 3.3 . 1 negated @ 4 . 1 negated @ 3.3 . 1.3 negated@3};
		addCurveFrom: aDirectedPoint withVertices: {1@0. 1@0.7. 1.3@1. 2@1. 1.3@1. 1@0.7};
		addCurveFrom: aDirectedPoint withVertices: {2@3 . 1.3@3 . 1 @ 3.3 . 1 @ 4 . 1 @ 3.3 . 1.3@3}.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/17/2024 10:22'
}
SUSCrossIntersectionDrawing >> addDetailFrom: aDirectedPoint to: aPoint [
	self color: Color transparent;
		addBaseFrom: aDirectedPoint;
		addCurvesFrom: aDirectedPoint
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 14:27'
}
SUSCrossIntersectionDrawing >> addMidMarkFrom: aPoint to: anotherPoint [ 
	self addMorphInLayer: ((LineMorph
			from: aPoint
			to: anotherPoint
			color: SUSDrawing colorMark
			width: SUSDrawing markWidth * 2) morphicLayerNumber: self detailLayer;
			 yourself)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 15:08'
}
SUSCrossIntersectionDrawing >> addPathFrom: aDirectedPoint withVertices: aCollection [
	self addPathWithVertices: (aCollection * SUSDrawing normalLaneWidth collect: [:aPoint | aDirectedPoint absoluteOffset: aPoint ])
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/17/2024 10:23'
}
SUSCrossIntersectionDrawing >> addPathsFrom: aDirectedPoint to: aPoint [
	| factor |
	factor := SUSDrawing normalLaneWidth.
	"From left"
	self addPathFrom: aDirectedPoint withVertices: { 0.5@0 . 0.5@2.5 . 2 negated@2.5 }; "Left"
		addPathFrom: aDirectedPoint withVertices: { 0.5@0 . 0.5@2 . 0.5@4 }; "Straight"
		addPathFrom: aDirectedPoint withVertices: { 0.5@0 . 0.5@1.5 . 2@1.5 }. "Right"
	
	"From bottom"
	self addPathFrom: aDirectedPoint withVertices: { 2@2.5 . 0.5@2.5 . 0.5@4 }; "Left"
		addPathFrom: aDirectedPoint withVertices: { 2@2.5 . 0@2.5 . 2 negated@2.5 }; "Straight"
		addPathFrom: aDirectedPoint withVertices: { 2@2.5 . 0.5 negated@2.5 . 0.5 negated@0 }. "Right"
	
	"From right"
	self addPathFrom: aDirectedPoint withVertices: { 0.5 negated@4 . 0.5 negated@1.5 . 2@1.5 }; "Left"
		addPathFrom: aDirectedPoint withVertices: { 0.5 negated@4 . 0.5 negated@2 . 0.5 negated@0 }; "Straight"
		addPathFrom: aDirectedPoint withVertices: { 0.5 negated@4 . 0.5 negated@2.5 . 2 negated@2.5 }. "Right"
	
	"From top"
	self addPathFrom: aDirectedPoint withVertices: { 2 negated@1.5 . 0.5@1.5 . 0.5@4 }; "Left"
		addPathFrom: aDirectedPoint withVertices: { 2 negated@1.5 . 0@1.5 . 2@1.5 }; "Straight"
		addPathFrom: aDirectedPoint withVertices: { 2 negated@1.5 . 0.5 negated@1.5 . 0.5 negated@0 } "Right"
	
]
