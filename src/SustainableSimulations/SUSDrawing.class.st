"
A SUSDrawing is an abstract class for all Road-Drawing-Objects of the simulation.
"
Class {
	#name : #SUSDrawing,
	#superclass : #Morph,
	#instVars : [
		'paths',
		'from',
		'to'
	],
	#category : #'SustainableSimulations-UI',
	#'squeak_changestamp' : 'Len 7/10/2024 21:12'
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
	#'squeak_changestamp' : 'Len 7/10/2024 21:11'
}
SUSDrawing class >> colorPath [
	^ Color transparent
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
	#'squeak_changestamp' : 'Len 7/10/2024 21:10'
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
	#'squeak_changestamp' : 'Len 7/10/2024 21:28'
}
SUSDrawing >> addPathFrom: aDirectedPoint withVertices: aCollection [ 
	self addPathWithVertices: (aCollection * SUSDrawing normalLaneWidth
				collect: [:aPoint | aDirectedPoint absoluteOffset: aPoint])
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:10'
}
SUSDrawing >> addPathWithVertices: aCollection [ 
	| path |
	path := CurveMorph
				vertices: aCollection
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
	#'squeak_changestamp' : 'Len 7/10/2024 21:09'
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
