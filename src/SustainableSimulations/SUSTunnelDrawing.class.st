"
A SUSTunnelDrawing is drawing object of a Magic Tunnel.

"
Class {
	#name : #SUSTunnelDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI',
	#'squeak_changestamp' : 'Len 7/10/2024 21:30'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'Len 7/10/2024 21:26'
}
SUSTunnelDrawing class >> newFrom: aDirectedPoint to: aPoint [ 
	| corners min max from to |
	corners := {1 negated @ 2. 1 @ 2. 1 @ 0. 1 negated @ 0} * SUSDrawing normalLaneWidth
				collect: [:each | aDirectedPoint absoluteOffset: each].
	min := corners min.
	max := corners max.
	from := SUSDirectedPoint newWithPosition: aDirectedPoint position - min inDirection: aDirectedPoint direction.
	to := aPoint - min.
	^ self new addDetailFrom: from to: to;
		 addPathsFrom: from to: to;
		 extent: max - min;
		 position: min;
		 yourself
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Lennard 10/27/2024 16:05'
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
	#'squeak_changestamp' : 'Len 7/10/2024 21:26'
}
SUSTunnelDrawing >> addDetailFrom: aDirectedPoint to: aPoint [ 
	self color: Color transparent;
		 addBaseFrom: aDirectedPoint
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:27'
}
SUSTunnelDrawing >> addPathsFrom: aDirectedPoint to: aPoint [ 
	self addPathFrom: aDirectedPoint withVertices: {-0.5 @ 1. -0.5 @ 0};
		 addPathFrom: aDirectedPoint withVertices: {0.5 @ 0. 0.5 @ 5}
]
