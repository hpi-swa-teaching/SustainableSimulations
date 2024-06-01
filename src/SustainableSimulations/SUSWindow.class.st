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
	#'squeak_changestamp' : 'Len 6/1/2024 20:18'
}
SUSWindow >> addButtons [
	| row | 
 	row := AlignmentMorph newRow addAllMorphs: {self createAddRoadButton. self createAddCrossIntersectionButton . self createPlaySimulationButton . self createPauseSimulationButton . self createStopSimulationButton . self createSpawnSimulationButton}.
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
	#category : #events,
	#'squeak_changestamp' : 'PM 5/28/2024 01:22'
}
SUSWindow >> addRoad [
	simulation addMorph: ((SUSStraightRoad
			newOnSimulation: simulation
			withLength: self askForLength
			withSpeedLimit: self askForSpeedLimit) position: 100 @ 100 + simulation position;
			 yourself)
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
	#'squeak_changestamp' : 'PM 5/28/2024 01:42'
}
SUSWindow >> createAddCrossIntersectionButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #addCrossIntersection
		label: #labelAddIntersection) position: 20 @ 20;
		 yourself
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'PM 5/28/2024 01:30'
}
SUSWindow >> createAddRoadButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #addRoad
		label: #labelAddRoad) position: 20 @ 20;
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
	#'squeak_changestamp' : 'Len 6/1/2024 20:17'
}
SUSWindow >> createSpawnSimulationButton [
	^ (PluggableButtonMorph
		on: self
		getState: nil
		action: #spawnCar
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
	#'squeak_changestamp' : 'PM 5/28/2024 01:53'
}
SUSWindow >> initialize [
	super initialize.
	
	simulation := SUSSimulation new.
	
	self setLabel: 'Sustainable Simulations';
		addMorph: simulation frame: (0@0 corner: 1@1);
		addButtons
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:30'
}
SUSWindow >> labelAddIntersection [
	^ 'Add Intersection'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 01:30'
}
SUSWindow >> labelAddRoad [
	^ 'Add Road'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 09:14'
}
SUSWindow >> labelPauseSimulation [
	^ 'Pause'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 09:14'
}
SUSWindow >> labelPlaySimulation [
	^ 'Play'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Len 6/1/2024 21:41'
}
SUSWindow >> labelSpawnCar [
	^ 'TMP Spawn TMP'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 5/28/2024 09:14'
}
SUSWindow >> labelStopSimulation [
	^ 'Stop'
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 5/28/2024 09:13'
}
SUSWindow >> pauseSimulation [
	
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 5/28/2024 09:13'
}
SUSWindow >> playSimulation [
	
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'Len 6/1/2024 20:28'
}
SUSWindow >> spawnCar [
	"TMP Method to spawn a car on a random Road"
	simulation addMorph: (SUSCar
		newOnSimulation: simulation)
]

{
	#category : #simulation,
	#'squeak_changestamp' : 'PM 5/28/2024 09:13'
}
SUSWindow >> stopSimulation [
	
]
