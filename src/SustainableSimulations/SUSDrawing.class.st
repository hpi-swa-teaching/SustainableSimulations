Class {
	#name : #SUSDrawing,
	#superclass : #Morph,
	#instVars : [
		'paths',
		'from',
		'to'
	],
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'class variables',
	#'squeak_changestamp' : 'Len 5/16/2024 11:16'
}
SUSDrawing class >> colorMark [
	^ Color white
]

{
	#category : #'class variables',
	#'squeak_changestamp' : 'PM 6/11/2024 00:22'
}
SUSDrawing class >> colorPath [
	"^ self colorRoad"
	^ Color red
]

{
	#category : #'class variables',
	#'squeak_changestamp' : 'Len 5/16/2024 11:15'
}
SUSDrawing class >> colorRoad [
	^ (Color r:176 g: 184 b: 187)
]

{
	#category : #'class variables',
	#'squeak_changestamp' : 'Len 5/16/2024 11:34'
}
SUSDrawing class >> markWidth [
	^ 4
]

{
	#category : #'class variables',
	#'squeak_changestamp' : 'Len 5/16/2024 11:52'
}
SUSDrawing class >> midMarkLength [
	^ 20
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'PM 6/11/2024 04:15'
}
SUSDrawing class >> newCurveTo: aPoint withDirection: anotherPoint [
	^ (SUSDrawing new
		extent: aPoint abs;
		color: SUSDrawing colorRoad)
		generateCurvePathsTo: aPoint withDirection: anotherPoint
]

{
	#category : #'class variables',
	#'squeak_changestamp' : 'Len 5/16/2024 11:02'
}
SUSDrawing class >> normalLaneWidth [
	^ 50
]

{
	#category : #'class variables',
	#'squeak_changestamp' : 'Len 5/26/2024 22:54'
}
SUSDrawing class >> verticesLineCurve [

	^ {0@1. 0.7@1. 1@0.7. 1@0. 1@0.7. 0.7@1.}
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 20:21'
}
SUSDrawing >> addDetailFrom: aDirectedPoint to: aPoint [
	self subclassResponsibility
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/15/2024 13:19'
}
SUSDrawing >> addMarkFrom: aPoint to: anotherPoint [ 
	self addMorphInLayer: ((LineMorph
			from: aPoint
			to: anotherPoint
			color: SUSDrawing colorMark
			width: SUSDrawing markWidth) morphicLayerNumber: self detailLayer;
			 yourself)
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/15/2024 15:03'
}
SUSDrawing >> addPathWithVertices: aCollection [
	| path |
	path := CurveMorph vertices: aCollection
			color: Color transparent 
			borderWidth: 2 
			borderColor: SUSDrawing colorPath.
	path morphicLayerNumber: self pathLayer.
	self addMorphInLayer: path.
	paths add: path
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 20:21'
}
SUSDrawing >> addPathsFrom: aDirectedPoint to: aPoint [
	"Create paths here"
	self subclassResponsibility.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 23:09'
}
SUSDrawing >> baseLayer [
	^ 29
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 23:09'
}
SUSDrawing >> detailLayer [
	^ 28
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:32'
}
SUSDrawing >> generateCurvePathFrom: aPointPosition To: anotherPointPosition withDirection: anotherPointDirection [
	| midpoint lineA lineB |
	lineA := SUSDirectedPoint newWithPosition: aPointPosition inDirection: 1@0.
	lineB := SUSDirectedPoint newWithPosition: anotherPointPosition inDirection: anotherPointDirection.
	midpoint := lineA calculateIntersectionPoint: lineB.
	^ {aPointPosition . midpoint . anotherPointPosition }
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:19'
}
SUSDrawing >> generateCurvePathOldFrom: aPointPosition To: anotherPointPosition withDirection: anotherPointDirection [
	| aPointDirection directionA directionB lineA lineB middlePoint | 
	aPointDirection := 1@0.
	directionA := (anotherPointPosition - aPointPosition) normalized.
	directionA := (aPointDirection normalized + directionA) normalized.
	directionB := (aPointPosition - anotherPointPosition) normalized.
	directionB := (anotherPointDirection normalized + directionB) normalized.
	
	lineA := SUSDirectedPoint newWithPosition: aPointPosition inDirection: directionA.
	lineB := SUSDirectedPoint newWithPosition: anotherPointPosition inDirection: directionB.
	
	middlePoint := lineA calculateIntersectionPoint: lineB.
	
	^ {aPointPosition . middlePoint . anotherPointPosition }
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/11/2024 05:35'
}
SUSDrawing >> generateCurvePathsTo: aPosition withDirection: aDirection [
	| verticesA verticesB delta | 
	delta := aDirection normal normalized * SUSDrawing normalLaneWidth * 0.5.
	verticesA := self generateCurvePathFrom: (0@0.5 * SUSDrawing normalLaneWidth) To: (aPosition + delta) withDirection: aDirection.
	verticesB := self generateCurvePathFrom: (0@1.5 * SUSDrawing normalLaneWidth) To: (aPosition - delta) withDirection: aDirection.
	self addPathWithVertices: verticesA.
	self addPathWithVertices: verticesB.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 22:17'
}
SUSDrawing >> initialize [
	super initialize.
	self morphicLayerNumber: self baseLayer.
	paths := OrderedCollection new
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 6/12/2024 23:09'
}
SUSDrawing >> pathLayer [
	^ 27
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 6/1/2024 20:13'
}
SUSDrawing >> paths [
	^ paths
]
