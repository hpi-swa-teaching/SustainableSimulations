Class {
	#name : #TestMorph2,
	#superclass : #Morph,
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 18:47'
}
TestMorph2 >> handleMouseDown: anEvent [
	Transcript show: 'World'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 6/12/2024 18:47'
}
TestMorph2 >> handlesMouseDown: anEvent [
	^ true
]
