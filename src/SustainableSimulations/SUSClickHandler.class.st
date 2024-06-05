Class {
	#name : #SUSClickHandler,
	#superclass : #Morph,
	#instVars : [
		'simulation'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:18'
}
SUSClickHandler >> handleMouseDown: anEvent [

	self simulation notifyClickedAtMousePos: (Sensor cursorPoint)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:14'
}
SUSClickHandler >> handlesMouseDown: anEvent [

	^ true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:18'
}
SUSClickHandler >> simulation [
	^ simulation
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/5/2024 14:18'
}
SUSClickHandler >> simulation: anObject [
	simulation := anObject
]
