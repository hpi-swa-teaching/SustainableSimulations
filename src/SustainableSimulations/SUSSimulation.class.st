Class {
	#name : #SUSSimulation,
	#superclass : #Morph,
	#instVars : [
		'cars',
		'simulationSpeed',
		'roads',
		'bezierCurve'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 22:08'
}
SUSSimulation >> demoRoadWithCar [
	|car road|
	
	road := SUSDrawing newNormalRoadWithLength: 1000.
	car := SUSCar new.
	road openInWorld;
		position: 100@100.
			
	
	
	bezierCurve := SUSBezierCurve new.
	bezierCurve addControlPoint: (road position x)@(road position y + (2* road extent y / 3));
		addControlPoint: (road position x + 1000 - car extent x)@(road position y + (2* road extent y / 3)).
	
	car openInWorld;
		position: bezierCurve controlPoints first.
	
	cars add: car.
	roads add: road.

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 21:59'
}
SUSSimulation >> initialize [

	super initialize.
	self extent: 50@50;
		position: 0@0;
		color: Color blue.
	
	cars := OrderedCollection new.
	roads := OrderedCollection new.
	simulationSpeed := 1.
	
	self demoRoadWithCar.
	
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 21:59'
}
SUSSimulation >> step [

	cars first moveAlongBezier: bezierCurve.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 22:02'
}
SUSSimulation >> stepTime [
	^10
]
