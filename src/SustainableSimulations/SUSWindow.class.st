Class {
	#name : #SUSWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'simulation',
		'playPauseRow'
	],
	#category : #'SustainableSimulations-UI'
}

{
	#category : #events,
	#'squeak_changestamp' : 'MK 6/25/2024 08:48'
}
SUSWindow >> addButtons [
	| row|
	row := AlignmentMorph newRow addAllMorphs: {self createStraightRoadButton. self createCurvyRoadButton. self createCrossIntersectionButton. self createTunnelButton. self createStopSimulationButton. self createSpawnSimulationButton}.
	self addMorph: row.
	row position: 15 @ 45.
	
	playPauseRow := AlignmentMorph newRow addAllMorphs: {self createPauseSimulationButton. self createPlaySimulationButton.}.
	self addMorph: row.
	self adjustPlayPausePosition.
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/25/2024 09:04'
}
SUSWindow >> adjustPlayPausePosition [
	
	playPauseRow ifNotNil:[
		self addMorph: playPauseRow.
		playPauseRow position: (((self width / 2) + 80))@(self height - 20)]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:13'
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
	#'squeak_changestamp' : 'PM 6/11/2024 00:58'
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
	#'squeak_changestamp' : 'PM 5/28/2024 09:15'
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
	#'squeak_changestamp' : 'PM 5/28/2024 09:15'
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
	#'squeak_changestamp' : 'MK 6/10/2024 23:34'
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
	#'squeak_changestamp' : 'PM 5/28/2024 09:15'
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
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:13'
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
	#'squeak_changestamp' : 'Len 6/20/2024 19:08'
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
	#'squeak_changestamp' : 'PM 6/12/2024 19:57'
}
SUSWindow >> crossIntersectionMode [

	simulation selectedSpawnType: #CrossIntersection
]

{
	#category : #events,
	#'squeak_changestamp' : 'PM 6/12/2024 19:57'
}
SUSWindow >> curvyRoadMode [

	simulation selectedSpawnType: #CurvyRoad
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MK 6/25/2024 09:00'
}
SUSWindow >> initialize [
	super initialize.
	
	simulation := SUSSimulation newWithWindow: self.
	
	self setLabel: 'Sustainable Simulations';
		addMorph: simulation frame: (0@0 corner: 1@1);
		addButtons.
	

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
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:08'
}
SUSWindow >> labelIntersection [
	^ 'Intersection'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 6/4/2024 16:48'
}
SUSWindow >> labelPauseSimulation [
	|pauseSymbolMorph|
	pauseSymbolMorph := Morph new.
	pauseSymbolMorph bounds: (0@0 extent: 20@20);
		color: Color transparent;
		addMorph: (Morph new bounds: (3@3 extent: 5@14); color: Color gray darker darker);
		addMorph: (Morph new bounds: (12@3 extent: 5@14); color: Color gray darker darker).

	^pauseSymbolMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MK 6/4/2024 17:01'
}
SUSWindow >> labelPlaySimulation [
	|playSymbolMorph|
	playSymbolMorph := PolygonMorph new. 
	playSymbolMorph color: Color transparent;
		setVertices: (Array with: 0@0 with: 10@5 with: 0@10);
		color: Color gray darker darker;
		borderWidth: 3;
		borderColor: Color gray darker darker.
		
	^playSymbolMorph
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
	#'squeak_changestamp' : 'MK 6/4/2024 16:40'
}
SUSWindow >> labelStopSimulation [
	|stopSymbolMorph|
	stopSymbolMorph := Morph new.
	stopSymbolMorph bounds: (0@0 extent: 20@20);
		color: Color transparent;
		addMorph: (Morph new bounds: (3@3 extent: 14@14); color: Color gray darker darker).
		
	^stopSymbolMorph
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
	#'squeak_changestamp' : 'Len 6/20/2024 19:07'
}
SUSWindow >> labelTunnel [
	^ 'Magic Tunnel'
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'MK 6/10/2024 17:16'
}
SUSWindow >> pauseSimulation [
	simulation pauseSimulation.
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'MK 6/10/2024 17:17'
}
SUSWindow >> playSimulation [
	simulation playSimulation.
]

{
	#category : #events,
	#'squeak_changestamp' : 'PM 6/12/2024 19:57'
}
SUSWindow >> spawnCarMode [

	simulation selectedSpawnType: #SpawnCar
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 5/28/2024 09:13'
}
SUSWindow >> stopSimulation [
	
]

{
	#category : #events,
	#'squeak_changestamp' : 'PM 6/12/2024 19:57'
}
SUSWindow >> straightRoadMode [

	simulation selectedSpawnType: #StraightRoad
]

{
	#category : #events,
	#'squeak_changestamp' : 'Len 6/20/2024 19:11'
}
SUSWindow >> tunnelMode [

	simulation selectedSpawnType: #Tunnel
]
