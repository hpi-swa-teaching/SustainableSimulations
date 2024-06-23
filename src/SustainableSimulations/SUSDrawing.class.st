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
	#'squeak_changestamp' : 'Len 6/20/2024 20:35'
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
	#category : #'class variables',
	#'squeak_changestamp' : 'MK 6/23/2024 02:44'
}
SUSDrawing class >> normalLaneWidth [ 
	^ 50
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
	#'squeak_changestamp' : 'Len 6/22/2024 21:57'
}
SUSDrawing >> initialize [
	super initialize.
	paths := OrderedCollection new.
	self morphicLayerNumber: self baseLayer
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
