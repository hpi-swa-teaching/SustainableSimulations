Class {
	#name : #SUSStraightRoadButton,
	#superclass : #Object,
	#category : #'SustainableSimulations-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/26/2024 22:41'
}
SUSStraightRoadButton class >> addButtonToWorld [
	| button |
	button := SimpleButtonMorph new.
	button
		label: 'Create Straight Road'
		font: (TextStyle default fontOfSize: 46);
		target: self;
		actionSelector: #createStraightRoad:;
		arguments: #(265);
		color: Color lightGray;
		borderColor: Color black;
		borderWidth: 3;
		extent: 400 @ 120.
	button position: World bounds center - (button extent // 2).
	World addMorph: button
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'ek 5/26/2024 22:24'
}
SUSStraightRoadButton class >> createStraightRoad: length [ 
	(SUSDrawing newNormalRoadWithLength: length) openInWorld.
	" Transcript show: 'Created road with length ' , length printString;
		 cr "
]
