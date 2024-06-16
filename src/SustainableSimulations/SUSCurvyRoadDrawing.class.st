Class {
	#name : #SUSCurvyRoadDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 20:54'
}
SUSCurvyRoadDrawing class >> newFrom: aDirectedPoint to: aPoint [
	| cornersA cornersB corners min max from to |
	cornersA := ({2 negated@0 . 2@0} * SUSDrawing normalLaneWidth) collect: [:each | aDirectedPoint absoluteOffset: each].
	cornersB := ({2 negated@0 . 2@0} * SUSDrawing normalLaneWidth) collect: [:each | aPoint absoluteOffset: each].
	corners := cornersA, cornersB.
	min := corners min.
	max := corners max.
	from := SUSDirectedPoint newWithPosition: (aDirectedPoint position - min) inDirection: aDirectedPoint direction.
	to := SUSDirectedPoint newWithPosition: (aPoint position - min) inDirection: aPoint direction.
	^ self new addDetailFrom: from to: to;
		addPathsFrom: from to: to;
		extent: max - min;
		position: min;
		yourself.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 20:53'
}
SUSCurvyRoadDrawing >> addDetailFrom: aDirectedPoint to: anotherDirectedPoint [ 
	| pointA pointB pointC pointD pointE pointF |
	pointA := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth negated@ 0.
	pointC := anotherDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth negated@ 0.
	pointB := aDirectedPoint calculateIntersectionPoint: anotherDirectedPoint.
	pointD := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth @ 0.
	pointF := anotherDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth @ 0.
	pointE := (SUSDirectedPoint newWithPosition: pointD inDirection: aDirectedPoint direction)
				calculateIntersectionPoint: (SUSDirectedPoint newWithPosition: pointF inDirection: anotherDirectedPoint direction).
	self color: Color transparent.
	self addMorphInLayer: ((MixedCurveMorph
			vertices: {pointA. pointB. pointC. pointF. pointE. pointD}
			color: SUSDrawing colorRoad
			borderWidth: 4
			borderColor: SUSDrawing colorRoad) morphicLayerNumber: self baseLayer;
			toggleSmoothing;
			clickVertex: 1 event: nil fromHandle: nil;
			clickVertex: 3 event: nil fromHandle: nil;
			clickVertex: 4 event: nil fromHandle: nil;
			clickVertex: 6 event: nil fromHandle: nil;
			 yourself)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/15/2024 20:40'
}
SUSCurvyRoadDrawing >> addPathsFrom: aDirectedPoint to: anotherDirectedPoint [
	| pointA pointB pointC pointD pointE pointF |
	pointA := aDirectedPoint absoluteOffset: 0.5 * SUSDrawing normalLaneWidth @ 0.
	pointC := anotherDirectedPoint absoluteOffset: 0.5 * SUSDrawing normalLaneWidth @ 0.
	pointB := (SUSDirectedPoint newWithPosition: pointA inDirection: aDirectedPoint direction)
				calculateIntersectionPoint: (SUSDirectedPoint newWithPosition: pointC inDirection: anotherDirectedPoint direction).
	pointD := aDirectedPoint absoluteOffset: 0.5 * SUSDrawing normalLaneWidth negated @ 0.
	pointF := anotherDirectedPoint absoluteOffset: 0.5 * SUSDrawing normalLaneWidth negated @ 0.
	pointE := (SUSDirectedPoint newWithPosition: pointD inDirection: aDirectedPoint direction)
				calculateIntersectionPoint: (SUSDirectedPoint newWithPosition: pointF inDirection: anotherDirectedPoint direction).
	self addPathWithVertices: { pointA . pointB . pointC } ;
		addPathWithVertices: { pointD . pointE . pointF }
]
