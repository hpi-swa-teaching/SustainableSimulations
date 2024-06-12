Class {
	#name : #TestMorph,
	#superclass : #Morph,
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 18:46'
}
TestMorph >> handleMouseDown: anEvent [
	Transcript show: 'Hello'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 18:46'
}
TestMorph >> handlesMouseDown: anEvent [
	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 18:47'
}
TestMorph >> initialize [
	super initialize.
	self extent: 100@100;
		color: Color red;
		addMorph: TestMorph2 new;
		openInWorld.
]
