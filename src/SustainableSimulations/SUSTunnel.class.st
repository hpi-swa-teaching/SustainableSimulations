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
	#'squeak_changestamp' : 'MK 7/8/2024 23:11'
}
SUSTunnel >> applyBehavior [
	| deltaTime |
	deltaTime := Time millisecondClock - lastTime.
	deltaTime >= (frequency * 1000)
		ifTrue: [self spawnCarFromTunnel.
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
	#'squeak_changestamp' : 'PM 7/3/2024 00:24'
}
SUSTunnel >> createDrawing [
	^ SUSTunnelDrawing newFrom: from to: to position
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
	#'squeak_changestamp' : 'PM 7/11/2024 11:30'
}
SUSTunnel >> postInitialize [
	simulation addTunnel: self.
	lanes second isRemoveRoad: true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 7/8/2024 23:10'
}
SUSTunnel >> spawnCarFromTunnel [
	| car |
	car := SUSCar newOnRoad: self withSpeed: 50 asNumber.
	car spawnRoad: 0.
	simulation addMorphInLayer: car
]
