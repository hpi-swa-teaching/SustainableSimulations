Class {
	#name : #SUSWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'simulation'
	],
	#category : #'SustainableSimulations-UI'
}

{
	#category : #events,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:10'
}
SUSWindow >> addButtons [
	| row | 
 	row := AlignmentMorph newRow addAllMorphs: {self createStraightRoadButton . self createCrossIntersectionButton . self createPlaySimulationButton . self createPauseSimulationButton . self createStopSimulationButton . self createSpawnSimulationButton}.
	self addMorph:  row.
	row position: 15@45.
]

{
	#category : #events,
	#'squeak_changestamp' : 'PM 5/28/2024 01:42'
}
SUSWindow >> addCrossIntersection [
	simulation addMorph: ((SUSCrossIntersection
			newOnSimulation: simulation) position: 100 @ 100 + simulation position;
			 yourself)
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'MK 6/3/2024 21:18'
}
SUSWindow >> askForCarSpeed [
	^ (UIManager default request: 'Please enter car speed' initialAnswer: 50) asNumber
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'PM 5/28/2024 01:21'
}
SUSWindow >> askForLength [
	^ (UIManager default request: 'Please enter length' initialAnswer: 200) asNumber
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'PM 5/28/2024 01:21'
}
SUSWindow >> askForSpeedLimit [
	^ (UIManager default request: 'Please enter speed limit' initialAnswer: simulation defaultSpeedLimit) asNumber
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
	#category : #events,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:14'
}
SUSWindow >> crossIntersectionMode [

	simulation buildMode: 'crossintersection'
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MK 6/10/2024 18:09'
}
SUSWindow >> initialize [
	super initialize.
	
	simulation := SUSSimulation new.
	
	self setLabel: 'Sustainable Simulations';
		addMorph: simulation frame: (0@0 corner: 1@1);
		addButtons.
	

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
	#category : #simulation,
	#'squeak_changestamp' : 'MK 6/3/2024 21:18'
}
SUSWindow >> spawnCar [
	"TMP Method to spawn a car on a random Road"
	simulation addMorph: (SUSCar
		newOnSimulation: simulation
		withSpeed: self askForCarSpeed)
]

{
	#category : #events,
	#'squeak_changestamp' : 'MK 6/10/2024 23:33'
}
SUSWindow >> spawnCarMode [

	simulation buildMode: 'spawnCar'
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 5/28/2024 09:13'
}
SUSWindow >> stopSimulation [
	
]

{
	#category : #events,
	#'squeak_changestamp' : 'GoChriNo 6/10/2024 17:14'
}
SUSWindow >> straightRoadMode [

	simulation buildMode: 'straightroad'
]
