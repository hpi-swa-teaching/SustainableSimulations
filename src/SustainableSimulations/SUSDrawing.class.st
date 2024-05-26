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
	#'squeak_changestamp' : 'Len 5/26/2024 23:15'
}
SUSDrawing class >> newNormalRoadWithLength: aNumber [

	^ (SUSDrawing new
		extent: aNumber@(SUSDrawing normalLaneWidth * 2);
		color: SUSDrawing colorRoad)
		addStraightMarks;
		generateStraightPathWithYValue: (SUSDrawing normalLaneWidth * 0.5);
		generateStraightPathWithYValue: (SUSDrawing normalLaneWidth * 1.5)
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
	#'squeak_changestamp' : 'Len 5/26/2024 23:39'
}
SUSDrawing >> addCrossInterMarks [

	self addCurveAt: SUSDrawing normalLaneWidth@SUSDrawing normalLaneWidth * 0.5 withRotation: 0.
	self addCurveAt: SUSDrawing normalLaneWidth@SUSDrawing normalLaneWidth * 3.5 withRotation: 180.
	self addCurveAt: (SUSDrawing normalLaneWidth * 0.5)@(SUSDrawing normalLaneWidth * 3.5) withRotation: 270.
	self addCurveAt: (SUSDrawing normalLaneWidth * 3.5)@(SUSDrawing normalLaneWidth * 0.5) withRotation: 90.
	
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
	#'squeak_changestamp' : 'Len 5/26/2024 23:55'
}
SUSDrawing >> generateCrossInterPaths [
	| factor collection |
	factor := SUSDrawing normalLaneWidth.
	collection := OrderedCollection new. "From top"
	collection add: {1.5@0. 1.5@1.5. 0@1.5} * factor. "Right"
	collection add: {1.5@0. 1.5@2. 1.5@0} * factor. "Straight"
	collection add: {1.5@0. 1.5@2.5. 4@2.5} * factor. "Left"
	paths add: collection.
	collection := OrderedCollection new. "From bottom"
	collection add: {2.5@4. 2.5@2.5. 4@2.5} * factor. "Right"
	collection add: {2.5@4. 2.5@2. 2.5@0} * factor. "Straight"
	collection add: {2.5@4. 2.5@1.5. 0@1.5} * factor. "Left"
	paths add: collection.
	collection := OrderedCollection new. "From left"
	collection add: {0@2.5. 1.5@2.5. 1.5@4} * factor. "Right"
	collection add: {0@2.5. 2@2.5. 4@2.5} * factor. "Straight"
	collection add: {0@2.5. 2.5@2.5. 2.5@0} * factor. "Left"
	paths add: collection.
	collection := OrderedCollection new. "From right"
	collection add: {4@1.5. 2.5@1.5. 2.5@0} * factor. "Right"
	collection add: {4@1.5. 2@1.5. 0@1.5} * factor. "Straight"
	collection add: {4@1.5. 1.5@1.5. 1.5@4} * factor. "Left"
	paths add: collection
	
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
