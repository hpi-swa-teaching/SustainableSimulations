Class {
	#name : #SUSDrawing,
	#superclass : #Morph,
	#category : #SustainableSimulations
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
	#'squeak_changestamp' : 'Len 5/16/2024 11:35'
}
SUSDrawing class >> newNormalRoadWithLength: aNumber [

	^ (SUSDrawing new
		extent: aNumber@(SUSDrawing normalLaneWidth * 2);
		color: SUSDrawing colorRoad)
		generateMarks
]

{
	#category : #'class variables',
	#'squeak_changestamp' : 'Len 5/16/2024 11:02'
}
SUSDrawing class >> normalLaneWidth [
	^ 50
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/16/2024 11:54'
}
SUSDrawing >> addMidMark [
	|amount|
	amount := (self extent x) / (SUSDrawing midMarkLength * 2 + 2) floor.
	0 to: amount do: [ :anIndex |
		self addMorphInLayer: ((LineMorph 
			from: 0@0
			to: SUSDrawing midMarkLength@0
			color: SUSDrawing colorMark 
			width: SUSDrawing markWidth)
			position: (SUSDrawing midMarkLength * 2 * anIndex)@(self center y))]

	 

]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/16/2024 11:34'
}
SUSDrawing >> generateMarkWithLength: aNumber [

	^ LineMorph 
		from: 0@0
		to: aNumber@0
		color: SUSDrawing 
		colorMark width: SUSDrawing markWidth

]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/16/2024 11:48'
}
SUSDrawing >> generateMarks [

	self addMorphInLayer: (
		(self generateMarkWithLength: self extent x - (SUSDrawing markWidth)) 
		position: 0@SUSDrawing markWidth).
	self addMorphInLayer: (
		(self generateMarkWithLength: self extent x - (SUSDrawing markWidth)) 
		position: 0@(self extent y - (SUSDrawing markWidth * 2))).
	self addMidMark
]
