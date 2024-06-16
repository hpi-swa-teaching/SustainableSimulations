Class {
	#name : #SUSCurvyRoadDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 19:55'
}
SUSCurvyRoadDrawing class >> curveResolution [
	^ 20
]

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
	#'squeak_changestamp' : 'Len 6/16/2024 19:31'
}
SUSCurvyRoadDrawing >> addDetailFrom: aDirectedPoint to: anotherDirectedPoint [ 
	| lane |
	self color: Color transparent.
	lane := self generateLaneWithVertices: (self calculateBezierVerticesFrom: aDirectedPoint to: anotherDirectedPoint withOffset: 0).
	self drawRoadWithLane: lane
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 18:35'
}
SUSCurvyRoadDrawing >> addDetailFromOld: aDirectedPoint to: anotherDirectedPoint [ 
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
	#'squeak_changestamp' : 'Len 6/16/2024 19:22'
}
SUSCurvyRoadDrawing >> addMarksFrom: aDirectedPoint to: anotherDirectedPoint [ 
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

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 18:51'
}
SUSCurvyRoadDrawing >> buildLaneWithVertices: vertices [
	^ SUSLane newLaneWithPath: (CurveMorph vertices: vertices color: (Color r: 0 g: 0 b: 0 alpha: 0) 
		borderWidth: 2 borderColor: SUSDrawing colorPath)
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 19:20'
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 19:35'
}
SUSCurvyRoadDrawing >> drawRoadWithLane: aLane [
	| factor |
	factor := 1 / (aLane length / (SUSCurvyRoadDrawing curveResolution * 0.5)). 
	
	0 to: 1 by: factor do: [:t | 
		| aMorph rotation |
		aMorph := self generateRoadPartWithLenght: (SUSCurvyRoadDrawing curveResolution).
		self addMorphInLayer: aMorph.
		aMorph center: (aLane getPositionWithTValue: t) + (0@(SUSDrawing markWidth * 0.5)).
		rotation := (aLane getRotationWithTValue:  t).
		rotation first = 1 ifTrue: [aMorph rotationDegrees: rotation second]]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 18:51'
}
SUSCurvyRoadDrawing >> generateLaneWithVertices: vertices [
	^ SUSLane newLaneWithPath: (CurveMorph vertices: vertices color: (Color r: 0 g: 0 b: 0 alpha: 0) 
		borderWidth: 2 borderColor: SUSDrawing colorPath)
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/16/2024 19:36'
}
SUSCurvyRoadDrawing >> generateRoadPartWithLenght: aNumber [
	^ (SUSStraightRoadDrawing new
			extent: aNumber@(SUSDrawing normalLaneWidth * 2);
			color: SUSDrawing colorRoad)
			addMarkFrom: 0@0 to: aNumber@0;
			addMarkFrom: (aNumber * 0.25)@(SUSDrawing normalLaneWidth) to: (aNumber * 0.75)@(SUSDrawing normalLaneWidth);
			addMarkFrom: 0@(SUSDrawing normalLaneWidth * 2) to: aNumber@(SUSDrawing normalLaneWidth * 2);
			addFlexShellIfNecessary
]
