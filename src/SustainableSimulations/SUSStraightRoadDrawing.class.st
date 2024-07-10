"
A SUSStraightRoadDrawing is the drawing object of the straight Road.
"
Class {
	#name : #SUSStraightRoadDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI',
	#'squeak_changestamp' : 'Len 7/10/2024 21:23'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'Len 7/10/2024 21:21'
}
SUSStraightRoadDrawing class >> newFrom: aDirectedPoint to: aPoint [ 
	| min max from to extent position |
	min := aDirectedPoint position min: aPoint.
	max := aDirectedPoint position max: aPoint.
	from := SUSDirectedPoint newWithPosition: aDirectedPoint position - min inDirection: aDirectedPoint direction.
	to := aPoint - min.
	extent := (from relativeOffset: 2 * SUSDrawing normalLaneWidth @ 0) + max - min.
	position := min + (from relativeOffset: SUSDrawing normalLaneWidth negated @ 0).
	^ self new addDetailFrom: from to: to;
		 addPathsFrom: from to: to;
		 extent: extent;
		 position: position;
		 yourself
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:22'
}
SUSStraightRoadDrawing >> addDetailFrom: aDirectedPoint to: aPoint [
	| length pointA pointB pointC pointD |
	length := aDirectedPoint linearDist: aPoint - SUSDrawing markWidth.
	pointA := (aDirectedPoint absoluteOffset: 0@0).
	pointB := (aDirectedPoint absoluteOffset: 2 * (SUSDrawing normalLaneWidth)@0).
	pointC := (aDirectedPoint absoluteOffset: 2 * (SUSDrawing normalLaneWidth)@length).
	pointD := (aDirectedPoint absoluteOffset: 0@length).
	self color: Color transparent;
	 	addMorphInLayer: ((PolygonMorph vertices: { pointA . pointB . pointC . pointD } color: SUSDrawing colorRoad borderWidth: 4 borderColor: SUSDrawing colorRoad)  		morphicLayerNumber: self baseLayer; yourself);
		addMarkFrom: pointA to: pointD;
		addMarkFrom: pointB to: pointC;
		addMidMarkFrom: aDirectedPoint to: aPoint
]

{
	#category : #drawing,
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
	#category : #drawing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:22'
}
SUSStraightRoadDrawing >> addPathsFrom: aDirectedPoint to: aPoint [ 
	| length from1 to1 from2 to2 |
	length := aDirectedPoint linearDist: aPoint - SUSDrawing markWidth.
	from1 := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth * 1.5 @ 0.
	to1 := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth * 1.5 @ length.
	from2 := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth * 0.5 @ length.
	to2 := aDirectedPoint absoluteOffset: SUSDrawing normalLaneWidth * 0.5 @ 0.
	self addPathWithVertices: {from1. to1};
		 addPathWithVertices: {from2. to2}
]
