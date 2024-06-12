Class {
	#name : #SUSStraightRoadDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 22:05'
}
SUSStraightRoadDrawing class >> newFrom: aPoint to: anotherPoint [
	| min max from to extent position |
	min := aPoint min: anotherPoint.
	max := aPoint max: anotherPoint.
	from := SUSDirectedPoint newWithPosition: (aPoint - min) inDirection: (anotherPoint - aPoint).
	extent :=  (from relativeOffset: 2 * SUSDrawing normalLaneWidth@0) + max - min.
	position := min + (from relativeOffset: SUSDrawing normalLaneWidth negated@0).
	to := anotherPoint - min.
	^ self new addDetailFrom: from to: to;
		addPathsFrom: from to: to;
		extent: extent;
		position: position;
		yourself.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/13/2024 00:00'
}
SUSStraightRoadDrawing >> addDetailFrom: aDirectedPoint to: aPoint [
	| length width pointA pointB pointC pointD |
	length := aDirectedPoint linearDist: aPoint - SUSDrawing markWidth.
	width := (SUSDrawing normalLaneWidth).
	pointA := (aDirectedPoint absoluteOffset: 0@0).
	pointB := (aDirectedPoint absoluteOffset: 2 * width@0).
	pointC := (aDirectedPoint absoluteOffset: 2 * width@length).
	pointD := (aDirectedPoint absoluteOffset: 0@length).
	self color: Color transparent.
	self addMorphInLayer: ((PolygonMorph vertices: { pointA . pointB . pointC . pointD } color: SUSDrawing colorRoad borderWidth: 4 borderColor: SUSDrawing colorRoad) morphicLayerNumber: self baseLayer; yourself).
	self addMarkFrom: pointA to: pointD.
	self addMarkFrom: pointB to: pointC.
	self addMidMarkFrom: aDirectedPoint to: aPoint
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 22:16'
}
SUSStraightRoadDrawing >> addMarkFrom: aPoint to: anotherPoint [ 
	self addMorphInLayer: ((LineMorph
			from: aPoint
			to: anotherPoint
			color: SUSDrawing colorMark
			width: SUSDrawing markWidth) morphicLayerNumber: self detailLayer;
			 yourself)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/13/2024 00:01'
}
SUSStraightRoadDrawing >> addMidMarkFrom: aDirectedPoint to: aPoint [
	| amount length start end |
	length := aDirectedPoint linearDist: aPoint - SUSDrawing markWidth.
	amount := (length / (SUSDrawing midMarkLength * 2)) floor.
	0 to: amount - 1 do: [ :anIndex |
		start := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth@(SUSDrawing midMarkLength * 2 * anIndex).
		end := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth@(SUSDrawing midMarkLength * 2 * anIndex + SUSDrawing midMarkLength).
		self addMarkFrom: start to: end]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 22:16'
}
SUSStraightRoadDrawing >> addPathFrom: aPoint to: anotherPoint [
	| path |
	path := CurveMorph vertices: {aPoint. anotherPoint}
			color: (Color r: 0 g: 0 b: 0 alpha: 0) 
			borderWidth: 2 
			borderColor: SUSDrawing colorPath.
	path morphicLayerNumber: self pathLayer.
	self addMorphInLayer: path.
	paths add: path
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 22:19'
}
SUSStraightRoadDrawing >> addPathsFrom: aDirectedPoint to: aPoint [
	| length from1 to1 from2 to2  |
	length := aDirectedPoint linearDist: aPoint - SUSDrawing markWidth.
	from1 := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth * 1.5@0.
	to1 := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth * 1.5@length.
	from2 := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth * 0.5@length.
	to2 := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth * 0.5@0.
	self 
		addPathFrom: from1 to: to1;
		addPathFrom: from2 to: to2
]
