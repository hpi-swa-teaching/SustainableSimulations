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
	#'squeak_changestamp' : 'PM 5/28/2024 09:16'
}
SUSWindow >> addButtons [
	| row | 
 	row := AlignmentMorph newRow addAllMorphs: {self createAddRoadButton. self createAddCrossIntersectionButton . self createPlaySimulationButton . self createPauseSimulationButton . self createStopSimulationButton }.
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
	#'squeak_changestamp' : 'ek 6/1/2024 20:32'
}
SUSWindow >> addRoad [
	| lengthAndSpeed |
	lengthAndSpeed := self askForLengthAndSpeed.
	simulation addMorph: ((SUSStraightRoad
			newOnSimulation: simulation
			withLength: lengthAndSpeed first
			withSpeedLimit: lengthAndSpeed second) position: 100 @ 100 + simulation position;
			 yourself).
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
	#'squeak_changestamp' : 'ek 6/1/2024 20:41'
}
SUSWindow >> askForLengthAndSpeed [
	| dialogWindow lengthInput speedLimitInput result |
	dialogWindow := (UIManager default
		request: 'Please enter length and speed limit separated by a comma (e.g.: 200, 50)'
		initialAnswer: '200, ' , simulation defaultSpeedLimit asString).
		
	result := dialogWindow findTokens: ', '.
	lengthInput := (result at: 1) asNumber.
	speedLimitInput := (result at: 2) asNumber.
	^ { lengthInput. speedLimitInput }.
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
	#'squeak_changestamp' : 'PM 5/28/2024 09:13'
}
SUSWindow >> stopSimulation [
	
]
