Class {
	#name : #SUSTunnel,
	#superclass : #SUSAbstractRoad,
	#instVars : [
		'lastTime',
		'frequency'
	],
	#category : #'SustainableSimulations-Roads'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 20:03'
}
SUSTunnel >> applyBehavior [
	| deltaTime |
	deltaTime := Time millisecondClock  - lastTime.
	deltaTime >= (frequency * 1000)
		ifTrue: [
			self spawnCarFromTunnel.
			lastTime := Time millisecondClock]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 20:18'
}
SUSTunnel >> connectionPointPositions [
	^ {from}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 19:14'
}
SUSTunnel >> createDrawing [
	| drawing |
	drawing := SUSTunnelDrawing newFrom: from to: to position.
	
	(drawing paths) do: [:each |
    		self createLaneWithPath: each].
	
	self extent: drawing extent.
	self position: drawing position.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 20:37'
}
SUSTunnel >> initialize [
	super initialize.

	frequency := 1.
	lastTime := Time millisecondClock - (frequency * 1000)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 20:25'
}
SUSTunnel >> postInitialize [
	simulation addTunnel: self.
	lanes second killRoad: true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 20:06'
}
SUSTunnel >> spawnCarFromTunnel [
	simulation addMorphInLayer: (SUSCar newOnRoad: self withSpeed: 50 asNumber)
]
