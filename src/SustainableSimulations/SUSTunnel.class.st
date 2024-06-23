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
	#'squeak_changestamp' : 'Len 6/22/2024 22:09'
}
SUSTunnel >> createDrawing [
	| drawing |
	drawing := SUSTunnelDrawing newFrom: from to: to position.
	drawing paths
		do: [:each | self createLaneWithPath: each].
	self extent: drawing extent;
	 	position: drawing position.
	^ drawing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/23/2024 10:21'
}
SUSTunnel >> initialize [
	super initialize.
	frequency := 10.
	lastTime := Time millisecondClock - (frequency * 1000)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/22/2024 22:09'
}
SUSTunnel >> postInitialize [
	simulation addTunnel: self.
	lanes second killRoad: true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/22/2024 22:08'
}
SUSTunnel >> spawnCarFromTunnel [
	simulation
		addMorphInLayer: (SUSCar newOnRoad: self withSpeed: 50 asNumber)
]
