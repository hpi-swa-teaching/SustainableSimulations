Class {
	#name : #SUSCrossIntersectionDrawing,
	#superclass : #SUSDrawing,
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/13/2024 00:51'
}
SUSCrossIntersectionDrawing class >> newWithDegrees: aNumber [
	^ self new rotationDegrees: aNumber;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 20:18'
}
SUSCrossIntersectionDrawing >> addCrossInterMarks [

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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 21:40'
}
SUSCrossIntersectionDrawing >> addDetailFrom: aDirectedPoint to: aPoint [
	self extent: 4@4 * SUSDrawing normalLaneWidth;
		color: SUSDrawing colorRoad;
		addCrossInterMarks
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 20:22'
}
SUSCrossIntersectionDrawing >> addPathsFrom: aDirectedPoint to: aPoint [
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 22:18'
}
SUSCrossIntersectionDrawing >> generateStopMark [

	^ Morph new 
		extent: (SUSDrawing normalLaneWidth)@(SUSDrawing markWidth * 3);
		color: SUSDrawing colorMark;
		yourself

]
