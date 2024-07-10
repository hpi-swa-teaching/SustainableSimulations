"
A SUSWindow is the main Window for the simulation and handles all buttons.
"
Class {
	#name : #SUSWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'simulation',
		'playPauseRow'
	],
	#category : #'SustainableSimulations-UI',
	#'squeak_changestamp' : 'Len 7/10/2024 21:34'
}

{
	#category : #events,
	#'squeak_changestamp' : 'Len 7/10/2024 21:31'
}
SUSWindow >> addButtons [
	| row |
	row := AlignmentMorph newRow addAllMorphs: {self createStraightRoadButton. self createCurvyRoadButton. self createCrossIntersectionButton. self createTIntersectionButton. self createTunnelButton. self createSpawnSimulationButton}.
	row position: 15 @ 45.
	playPauseRow := AlignmentMorph newRow addAllMorphs: {self createPauseSimulationButton. self createPlaySimulationButton. self createStopSimulationButton}.
	self addMorph: row;
		 addMorph: playPauseRow
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> createCrossIntersectionButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #crossIntersectionMode
		label: #labelIntersection) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> createCurvyRoadButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #curvyRoadMode
		label: #labelCurvyRoad) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> createPauseSimulationButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #pauseSimulation
		label: #labelPauseSimulation) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> createPlaySimulationButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #playSimulation
		label: #labelPlaySimulation) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> createSpawnSimulationButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #spawnCarMode
		label: #labelSpawnCar) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> createStopSimulationButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #stopSimulation
		label: #labelStopSimulation) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> createStraightRoadButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #straightRoadMode
		label: #labelStraightRoad) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:33'
}
SUSWindow >> createTIntersectionButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #tIntersectionMode
		label: #labelTIntersection) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:33'
}
SUSWindow >> createTunnelButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #tunnelMode
		label: #labelTunnel) position: 20 @ 20;
		 yourself
]

{
	#category : #events,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> crossIntersectionMode [
	simulation selectedSpawnType: #CrossIntersection
]

{
	#category : #events,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> curvyRoadMode [
	simulation selectedSpawnType: #CurvyRoad
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'Len 7/10/2024 21:33'
}
SUSWindow >> extent: anExtent [ 
	super extent: anExtent.
	playPauseRow center: self position + anExtent * (0.5 @ 1) - (0 @ 50)
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Len 7/10/2024 21:33'
}
SUSWindow >> initialize [
	super initialize.
	simulation := SUSSimulation new.
	self setLabel: 'Sustainable Simulations';
		addMorph: simulation
		frame: (0 @ 0 corner: 1 @ 1);
		 addButtons
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/11/2024 00:57'
}
SUSWindow >> labelCurvyRoad [
	^ 'Curvy Road'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/27/2024 10:00'
}
SUSWindow >> labelIntersection [
	^ 'x-Intersection'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:31'
}
SUSWindow >> labelPauseSimulation [
	| pauseSymbolMorph |
	pauseSymbolMorph := Morph new.
	pauseSymbolMorph
		bounds: (0 @ 0 extent: 20 @ 20);
		 color: Color transparent;
		 addMorph: (Morph new
			bounds: (3 @ 3 extent: 5 @ 14);
			 color: Color gray darker darker);
		 addMorph: (Morph new
			bounds: (12 @ 3 extent: 5 @ 14);
			 color: Color gray darker darker).
	^ pauseSymbolMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:31'
}
SUSWindow >> labelPlaySimulation [
	| playSymbolMorph |
	playSymbolMorph := PolygonMorph new.
	playSymbolMorph color: Color transparent;
		setVertices: (Array
				with: 0 @ 0
				with: 10 @ 5
				with: 0 @ 10);
		 color: Color gray darker darker;
		 borderWidth: 3;
		 borderColor: Color gray darker darker.
	^ playSymbolMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 6/10/2024 23:42'
}
SUSWindow >> labelSpawnCar [
	^ 'Car'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 7/10/2024 21:31'
}
SUSWindow >> labelStopSimulation [
	| stopSymbolMorph |
	stopSymbolMorph := Morph new.
	stopSymbolMorph
		bounds: (0 @ 0 extent: 20 @ 20);
		 color: Color transparent;
		 addMorph: (Morph new
			bounds: (3 @ 3 extent: 14 @ 14);
			 color: Color gray darker darker).
	^ stopSymbolMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:08'
}
SUSWindow >> labelStraightRoad [
	^ 'Straight Road'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 6/27/2024 10:00'
}
SUSWindow >> labelTIntersection [
	^ 'T-Intersection'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/20/2024 19:07'
}
SUSWindow >> labelTunnel [
	^ 'Magic Tunnel'
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'MK 7/8/2024 22:32'
}
SUSWindow >> pauseSimulation [
	simulation pauseSimulation
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'MK 7/8/2024 22:32'
}
SUSWindow >> playSimulation [
	simulation playSimulation
]

{
	#category : #events,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> spawnCarMode [
	simulation selectedSpawnType: #SpawnCar
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'MK 7/9/2024 00:59'
}
SUSWindow >> stopSimulation [
	simulation stopSimulation
]

{
	#category : #events,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> straightRoadMode [
	simulation selectedSpawnType: #StraightRoad
]

{
	#category : #events,
	#'squeak_changestamp' : 'PM 6/27/2024 10:01'
}
SUSWindow >> tIntersectionMode [
	simulation selectedSpawnType: #TIntersection
]

{
	#category : #events,
	#'squeak_changestamp' : 'Len 7/10/2024 21:32'
}
SUSWindow >> tunnelMode [
	simulation selectedSpawnType: #Tunnel
]
