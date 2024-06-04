Class {
	#name : #SUSDrawing,
	#superclass : #Morph,
	#instVars : [
		'paths'
	],
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
	#'squeak_changestamp' : 'Len 5/23/2024 10:12'
}
SUSDrawing class >> colorPath [
	^ self colorRoad
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
	#'squeak_changestamp' : 'Len 5/26/2024 23:44'
}
SUSDrawing class >> newCrossIntersetion [

	^ (SUSDrawing new
		extent: (SUSDrawing normalLaneWidth * 4)@(SUSDrawing normalLaneWidth * 4);
		color: SUSDrawing colorRoad)
		addCrossInterMarks;
		generateCrossInterPaths
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'Len 6/1/2024 20:42'
}
SUSDrawing class >> newNormalRoadWithLength: aNumber [

	^ (SUSDrawing new
		extent: aNumber@(SUSDrawing normalLaneWidth * 2);
		color: SUSDrawing colorRoad)
		addStraightMarks;
		generateNormalPathFrom: 0@(SUSDrawing normalLaneWidth * 1.5) To: aNumber@(SUSDrawing normalLaneWidth * 1.5);
		generateNormalPathFrom: aNumber@(SUSDrawing normalLaneWidth * 0.5) To: 0@(SUSDrawing normalLaneWidth * 0.5)
		
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
	#'squeak_changestamp' : 'Len 6/1/2024 21:40'
}
SUSDrawing >> addCrossInterMarks [

	self addCurveAt: SUSDrawing normalLaneWidth@SUSDrawing normalLaneWidth * 0.55 withRotation: 0.
	self addCurveAt: SUSDrawing normalLaneWidth@SUSDrawing normalLaneWidth * 3.45 withRotation: 180.
	self addCurveAt: (SUSDrawing normalLaneWidth * 0.55)@(SUSDrawing normalLaneWidth * 3.45) withRotation: 270.
	self addCurveAt: (SUSDrawing normalLaneWidth * 3.45)@(SUSDrawing normalLaneWidth * 0.55) withRotation: 90.
	
	self addMorphInLayer: ((self generateMarkWithLength: SUSDrawing normalLaneWidth * 0.6) 
		center: (SUSDrawing normalLaneWidth * 0.3)@(SUSDrawing normalLaneWidth * 2)).
	self addMorphInLayer: ((self generateMarkWithLength: SUSDrawing normalLaneWidth * 0.6) 
		center: (SUSDrawing normalLaneWidth * 3.7)@(SUSDrawing normalLaneWidth * 2)).
	self addMorphInLayer: (((self generateMarkWithLength: SUSDrawing normalLaneWidth * 0.6) 
		rotationDegrees: 90; addFlexShellIfNecessary) center: (SUSDrawing normalLaneWidth * 2)@(SUSDrawing normalLaneWidth * 0.3)).
	self addMorphInLayer: (((self generateMarkWithLength: SUSDrawing normalLaneWidth * 0.6)
		rotationDegrees: 90; addFlexShellIfNecessary) center: (SUSDrawing normalLaneWidth * 2)@(SUSDrawing normalLaneWidth * 3.7)).
		
	self addMorphInLayer: (self generateStopMark center: (SUSDrawing normalLaneWidth * 1.5)@(SUSDrawing normalLaneWidth * 0.5)).
	self addMorphInLayer: (self generateStopMark center: (SUSDrawing normalLaneWidth * 2.5)@(SUSDrawing normalLaneWidth * 3.5))
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/26/2024 23:03'
}
SUSDrawing >> addCurveAt: aPoint withRotation: aNumber [

	self addMorphInLayer: (
		((LineMorph 
			vertices: (SUSDrawing verticesLineCurve * SUSDrawing normalLaneWidth)
			color: (Color r: 0 g: 0 b: 0 alpha: 0)  
			borderWidth: SUSDrawing markWidth 
			borderColor: SUSDrawing colorMark)
			beSmoothCurve;
			rotationDegrees: aNumber;
			addFlexShellIfNecessary) 
	 	center: aPoint)
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/26/2024 22:38'
}
SUSDrawing >> addMidMark [
	|amount|
	amount := ((self extent x) / (SUSDrawing midMarkLength * 2)) floor.
	0 to: amount - 1 do: [ :anIndex |
		self addMorphInLayer: ((LineMorph 
			from: 0@0
			to: SUSDrawing midMarkLength@0
			color: SUSDrawing colorMark 
			width: SUSDrawing markWidth)
			position: (SUSDrawing midMarkLength * 2 * anIndex)@(self center y))]

	 

]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/1/2024 21:32'
}
SUSDrawing >> addPathWithVertices: aCollection [
	| path |
	path := CurveMorph vertices: aCollection
			color: (Color r: 0 g: 0 b: 0 alpha: 0) 
			borderWidth: 2 
			borderColor: SUSDrawing colorPath.
	self addMorphInLayer: path.
	paths add: path
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/26/2024 23:16'
}
SUSDrawing >> addStraightMarks [

	self addMorphInLayer: (
		(self generateMarkWithLength: self extent x - (SUSDrawing markWidth)) 
		position: 0@SUSDrawing markWidth).
	self addMorphInLayer: (
		(self generateMarkWithLength: self extent x - (SUSDrawing markWidth)) 
		position: 0@(self extent y - (SUSDrawing markWidth * 2))).
	self addMidMark
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/1/2024 21:39'
}
SUSDrawing >> generateCrossInterPaths [
	| factor |
	factor := SUSDrawing normalLaneWidth.
	"From top"
	self addPathWithVertices: ({1.5@0. 1.5@2. 1.5@0} * factor). "Straight"
	self addPathWithVertices: ({1.5@0. 1.5@1.5. 0@1.5} * factor). "Right"
	self addPathWithVertices: ({1.5@0. 1.5@2.5. 4@2.5} * factor). "Left"
	"From bottom"
	self addPathWithVertices: ({2.5@4. 2.5@2. 2.5@0} * factor). "Straight"
	self addPathWithVertices: ({2.5@4. 2.5@2.5. 4@2.5} * factor). "Right"
	self addPathWithVertices: ({2.5@4. 2.5@1.5. 0@1.5} * factor). "Left"
	"From left"
	self addPathWithVertices: ({0@2.5. 2@2.5. 4@2.5} * factor). "Straight"
	self addPathWithVertices: ({0@2.5. 1.5@2.5. 1.5@4} * factor). "Right"
	self addPathWithVertices: ({0@2.5. 2.5@2.5. 2.5@0} * factor). "Left"
	"From right"
	self addPathWithVertices: ({4@1.5. 2@1.5. 0@1.5} * factor). "Straight"
	self addPathWithVertices: ({4@1.5. 2.5@1.5. 2.5@0} * factor). "Right"
	self addPathWithVertices: ({4@1.5. 1.5@1.5. 1.5@4} * factor). "Left"
	
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/23/2024 09:55'
}
SUSDrawing >> generateMarkWithLength: aNumber [

	^ LineMorph 
		from: 0@0
		to: aNumber@0
		color: SUSDrawing colorMark 
		width: SUSDrawing markWidth

]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/1/2024 20:14'
}
SUSDrawing >> generateNormalPathFrom: aPoint To: anotherPoint [
	| path |
	path := CurveMorph vertices: {aPoint. anotherPoint}
			color: (Color r: 0 g: 0 b: 0 alpha: 0) 
			borderWidth: 2 
			borderColor: SUSDrawing colorPath.
	self addMorphInLayer: path.
	paths add: path
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/26/2024 23:34'
}
SUSDrawing >> generateStopMark [

	^ Morph new 
		extent: (SUSDrawing normalLaneWidth)@(SUSDrawing markWidth * 3);
		color: SUSDrawing colorMark;
		yourself

]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 5/23/2024 09:31'
}
SUSDrawing >> generateStraightPathWithYValue: aNumber [
	| path |
	path := CurveMorph vertices: {0@aNumber. self extent x@aNumber}
			color: (Color r: 0 g: 0 b: 0 alpha: 0) 
			borderWidth: 2 
			borderColor: SUSDrawing colorPath.
	self addMorphInLayer: path.
	paths add: path
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 5/21/2024 17:36'
}
SUSDrawing >> initialize [

	super initialize.
	paths := OrderedCollection new
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 6/1/2024 20:13'
}
SUSDrawing >> paths [
	^ paths
]
