Class {
	#name : #SUSTunnelDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 6/22/2024 21:58'
}
SUSTunnelDrawing class >> newFrom: aDirectedPoint to: aPoint [
	| corners min max from to |
	corners := ({1 negated @ 2. 1 @ 2. 1 @ 0. 1 negated @ 0} * SUSDrawing normalLaneWidth) collect: [:each | aDirectedPoint absoluteOffset: each].
	min := corners min.
	max := corners max.
	from := SUSDirectedPoint newWithPosition: (aDirectedPoint position - min) inDirection: aDirectedPoint direction.
	to := aPoint - min.
	^ self new addDetailFrom: from to: to;
		addPathsFrom: from to: to;
		extent: max - min;
		position: min;
		yourself
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/22/2024 21:51'
}
SUSTunnelDrawing >> addBaseFrom: aDirectedPoint [ 
	| vertices |
	vertices := {1 negated @ 2. 1 @ 2. 1 @ 0. 1 negated @ 0} * SUSDrawing normalLaneWidth.
	self addMorphInLayer: ((PolygonMorph
			vertices: (vertices
					collect: [:aPoint | aDirectedPoint absoluteOffset: aPoint])
			color: Color transparent
			borderWidth: 4
			borderColor: SUSDrawing colorRoad) morphicLayerNumber: self baseLayer;
			 yourself)
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/22/2024 21:51'
}
SUSTunnelDrawing >> addDetailFrom: aDirectedPoint to: aPoint [ 
	self color: Color transparent;
		 addBaseFrom: aDirectedPoint
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/22/2024 21:51'
}
SUSTunnelDrawing >> addPathFrom: aDirectedPoint withVertices: aCollection [ 
	self
		addPathWithVertices: (aCollection * SUSDrawing normalLaneWidth
				collect: [:aPoint | aDirectedPoint absoluteOffset: aPoint])
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/22/2024 21:51'
}
SUSTunnelDrawing >> addPathsFrom: aDirectedPoint to: aPoint [ 
	self addPathFrom: aDirectedPoint withVertices: {-0.5 @ 1. -0.5 @ 0};
		 addPathFrom: aDirectedPoint withVertices: {0.5 @ 0. 0.5 @ 3}
]
