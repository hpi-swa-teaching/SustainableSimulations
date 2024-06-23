Class {
	#name : #SUSStraightRoad,
	#superclass : #Object,
	#instVars : [
		'speedLimit',
		'startPoint',
		'endPoint',
		'points',
		'adjacentRoads',
		'length'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:58'
}
SUSStraightRoad class >> newFrom: startPoint To: endPoint [

	^ SUSStraightRoad newFrom: startPoint To: endPoint SpeedLimit: 50
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 12:22'
}
SUSStraightRoad class >> newFrom: startPoint To: endPoint SpeedLimit: speedLimit [ 
	^ SUSStraightRoad new 
		 speedLimit: speedLimit;
		 points: {startPoint. endPoint} asOrderedCollection;
		 adjacentRoads: {nil. nil} asOrderedCollection;
		 length: ((endPoint x - startPoint x) squared + (endPoint y - startPoint y) squared) sqrt.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:36'
}
SUSStraightRoad >> adjacentRoads [
	^ adjacentRoads
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:36'
}
SUSStraightRoad >> adjacentRoads: anObject [
	adjacentRoads := anObject
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 12:15'
}
SUSStraightRoad >> connectNextStraightRoadFromRoad: road [ 
	(self adjacentRoads at: 2)
		ifNil: [(road adjacentRoads at: 1)
				ifNil: [self adjacentRoads at: 2 put: road.
					road adjacentRoads at: 1 put: self.
					road points at: 1 put: (self points at: 2).
					road points at: 2 put: (self points at: 2) + ((self points at: 2) - (self points at: 1) / self length * road length).
					(self adjacentRoads at: 2)
						updateConnectionFrom: self]]
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:57'
}
SUSStraightRoad >> connectNextStraightRoadWithLength: length [

	self connectNextStraightRoadWithLength: length SpeedLimit: 50
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 18:35'
}
SUSStraightRoad >> connectNextStraightRoadWithLength: length SpeedLimit: speedLimit [

	self connectNextStraightRoadFromRoad: (SUSStraightRoad newFrom: (0@0) To: (length@0) SpeedLimit: speedLimit)
	
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 12:15'
}
SUSStraightRoad >> connectPrevStraightRoadFromRoad: road [ 
	(self adjacentRoads at: 1)
		ifNil: [(road adjacentRoads at: 2)
				ifNil: [self adjacentRoads at: 1 put: road.
					road adjacentRoads at: 2 put: self.
					road points at: 2 put: (self points at: 1).
					road points at: 1 put: (self points at: 1) + ((self points at: 2) - (self points at: 1) / self length * road length).
					(self adjacentRoads at: 1)
						updateConnectionFrom: self]]
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 12:21'
}
SUSStraightRoad >> connectPrevStraightRoadWithLength: length [

	self connectPrevStraightRoadWithLength: length SpeedLimit: 50
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 13:31'
}
SUSStraightRoad >> connectPrevStraightRoadWithLength: length SpeedLimit: speedLimit [

	self connectPrevStraightRoadFromRoad: (SUSStraightRoad newFrom: (0@0) To: (length@0) SpeedLimit: speedLimit)
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:58'
}
SUSStraightRoad >> length [
	^ length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:58'
}
SUSStraightRoad >> length: anObject [
	length := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:38'
}
SUSStraightRoad >> points [
	^ points
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:38'
}
SUSStraightRoad >> points: anObject [
	points := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:23'
}
SUSStraightRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:23'
}
SUSStraightRoad >> speedLimit: anObject [
	speedLimit := anObject
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 12:19'
}
SUSStraightRoad >> updateConnectionFrom: lastRoad [ 
	(self adjacentRoads at: 1)
			== lastRoad
		ifTrue: [self points at: 2 put: (self points at: 1) + ((lastRoad points at: 2) - (lastRoad points at: 1) / lastRoad length * self length)]
		ifFalse: [self points at: 1 put: (self points at: 2) - ((lastRoad points at: 2) - (lastRoad points at: 1) / lastRoad length * self length)].
	(self adjacentRoads at: 1)
			== lastRoad
		ifFalse: [(self adjacentRoads at: 1)
				ifNotNil: [(self adjacentRoads at: 1)
						points at: 2 put: (self points at: 1).
					(self adjacentRoads at: 1)
						updateConnectionFrom: self]].
	(self adjacentRoads at: 2)
			== lastRoad
		ifFalse: [(self adjacentRoads at: 2)
				ifNotNil: [(self adjacentRoads at: 2)
						points at: 1 put: (self points at: 2).
					(self adjacentRoads at: 2)
						updateConnectionFrom: self]]
]
