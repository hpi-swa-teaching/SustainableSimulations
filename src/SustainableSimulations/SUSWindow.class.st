Class {
	#name : #SUSWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'playgroundMorph'
	],
	#category : #'SustainableSimulations-UI'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 5/14/2024 11:38'
}
SUSWindow >> initialize [
	super initialize.
	
	self initializePlaygroundMorph;
		setLabel: 'Sustainable Simulations';
		addMorph: playgroundMorph frame: (0@0 corner: 1@1).
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 5/14/2024 11:38'
}
SUSWindow >> initializePlaygroundMorph [
	playgroundMorph := Morph new
		color: Color gray muchLighter
]

{
	#category : #layout,
	#'squeak_changestamp' : 'PM 5/14/2024 11:38'
}
SUSWindow >> renderOneRoadInNetwork: aRoad atPosition: aPoint [
	"Todo recursively add Road Morph to playgroundMorph and position it at aPoint"
	"also call this method recursively on the former/latter roads with updated positions"
]

{
	#category : #layout,
	#'squeak_changestamp' : 'PM 5/14/2024 11:38'
}
SUSWindow >> renderRoadNetwork: aRoad [
	self renderOneRoadInNetwork: aRoad atPosition: (playgroundMorph center)
]
