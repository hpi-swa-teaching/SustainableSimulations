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
	#'squeak_changestamp' : 'PM 6/11/2024 00:22'
}
SUSDrawing class >> newCrossIntersetion [

	^ (SUSDrawing new
		extent: 4@4 * SUSDrawing normalLaneWidth;
		color: SUSDrawing colorRoad)
		addCrossInterMarks;
		generateCrossInterPaths
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
	#'squeak_changestamp' : 'Len 6/11/2024 23:36'
}
SUSDrawing >> drawCurveRoadTo: aPosition withDirection: aDirection [
	| vertices delta lane | 
	delta := aDirection normal normalized * SUSDrawing normalLaneWidth * 0.5.
	vertices := self generateCurvePathFrom: (0@1 * SUSDrawing normalLaneWidth) To: (aPosition) withDirection: aDirection.
	lane := SUSLane newLaneWithPath: (CurveMorph vertices: vertices color: (Color r: 0 g: 0 b: 0 alpha: 0) 
		borderWidth: 2 borderColor: SUSDrawing colorPath).
	
	0 to: 1 by: 0.01 do: [:t | 
		| aMorph rotation |
		aMorph := (SUSDrawing new
			extent: 20@(SUSDrawing normalLaneWidth * 2);
			color: SUSDrawing colorRoad)
			addStraightMarks;
			addFlexShellIfNecessary.
		self addMorphInLayer: aMorph.
		aMorph center: (lane getPositionWithTValue: t).
		rotation := (lane getRotationWithTValue:  t).
		rotation first = 1 ifTrue: [aMorph rotationDegrees: rotation second]]

]

{
	#category : #drawing,
	#'squeak_changestamp' : 'Len 6/10/2024 01:45'
}
SUSDrawing >> generateCrossInterPaths [
	| factor |
	factor := SUSDrawing normalLaneWidth.
	"From top"
	self addPathWithVertices: ({1.5@0. 1.5@2.5. 4@2.5} * factor). "Left"
	self addPathWithVertices: ({1.5@0. 1.5@2. 1.5@4} * factor). "Straight"
	self addPathWithVertices: ({1.5@0. 1.5@1.5. 0@1.5} * factor). "Right"
	"From bottom"
	self addPathWithVertices: ({2.5@4. 2.5@2. 2.5@0} * factor). "Straight"
	self addPathWithVertices: ({2.5@4. 2.5@2.5. 4@2.5} * factor). "Right"
	self addPathWithVertices: ({2.5@4. 2.5@1.5. 0@1.5} * factor). "Left"
	"From left"
	self addPathWithVertices: ({0@2.5. 1.5@2.5. 1.5@4} * factor). "Right"
	self addPathWithVertices: ({0@2.5. 2.5@2.5. 2.5@0} * factor). "Left"
	self addPathWithVertices: ({0@2.5. 2@2.5. 4@2.5} * factor). "Straight"
	
	self addPathWithVertices: ({0@2.5. 2.5@2.5. 2.5@0} * factor). "Left"
	"From right"
	self addPathWithVertices: ({4@1.5. 2@1.5. 0@1.5} * factor). "Straight"
	self addPathWithVertices: ({4@1.5. 2.5@1.5. 2.5@0} * factor). "Right"
	self addPathWithVertices: ({4@1.5. 1.5@1.5. 1.5@4} * factor). "Left"
	
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
