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
	#'squeak_changestamp' : 'PM 6/17/2024 22:03'
}
SUSDrawing class >> colorPath [
	^ Color transparent
	"^ Color red"
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
	#'squeak_changestamp' : 'Len 6/11/2024 23:39'
}
SUSDrawing class >> newCurveTo: aPoint withDirection: anotherPoint [
	^ (SUSDrawing new
		extent: aPoint abs;
		color: (Color r: 0 g: 0 b: 0 alpha: 0))
		drawCurveRoadTo: aPoint withDirection: anotherPoint;
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
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/12/2024 20:21'
}
SUSDrawing >> addDetailFrom: aDirectedPoint to: aPoint [
	self subclassResponsibility
]

{
	#category : #drawing,
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
	#category : #drawing,
	#'squeak_changestamp' : 'PM 6/12/2024 20:21'
}
SUSDrawing >> addPathsFrom: aDirectedPoint to: aPoint [
	"Create paths here"
	self subclassResponsibility.
]

{
	#category : #layer,
	#'squeak_changestamp' : 'PM 6/12/2024 23:09'
}
SUSDrawing >> baseLayer [
	^ 29
]

{
	#category : #layer,
	#'squeak_changestamp' : 'PM 6/12/2024 23:09'
}
SUSDrawing >> detailLayer [
	^ 28
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
	#category : #layer,
	#'squeak_changestamp' : 'PM 6/12/2024 23:09'
}
SUSDrawing >> pathLayer [
	^ 27
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:13'
}
SUSDrawing >> paths [
	^ paths
]
