Class {
	#name : #SUSStraightRoad,
	#superclass : #Object,
	#instVars : [
		'speedLimit',
		'startPoint',
		'endPoint',
		'prevRoad',
		'nextRoad'
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
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:33'
}
SUSStraightRoad class >> newFrom: startPoint To: endPoint SpeedLimit: speedLimit [

	^ SUSStraightRoad new 
		startPoint: startPoint;
		endPoint: endPoint;
		speedLimit: speedLimit.
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 18:56'
}
SUSStraightRoad >> connectNextStraightRoadFromRoad: road [ 
	| direction length roadLength |
	self nextRoad
		ifNil: [self nextRoad: road.
			road prevRoad: self.
			roadLength := ((road endPoint x - road startPoint x) squared + (road endPoint y - road startPoint y) squared) sqrt.
			length := ((self endPoint x - self startPoint x) squared + (self endPoint y - self startPoint y) squared) sqrt.
			direction := self endPoint - self startPoint / length.
			road startPoint: self endPoint.
			road endPoint: self endPoint + (direction * roadLength).
			self nextRoad updateConnectionForward]
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
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 18:57'
}
SUSStraightRoad >> connectPrevStraightRoadFromRoad: road [ 
	| direction length roadLength |
	self prevRoad
		ifNotNil: [self prevRoad: road.
			road nextRoad: self.
			roadLength := ((road endPoint x - road startPoint x) squared + (road endPoint y - road startPoint y) squared) sqrt.
			length := ((self endPoint x - self startPoint x) squared + (self endPoint y - self startPoint y) squared) sqrt.
			direction := self startPoint - self endPoint / length.
			road endPoint: self startPoint.
			road startPoint: self startPoint + (direction * roadLength).
			self prevRoad updateConnectionBackwards]
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
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:24'
}
SUSStraightRoad >> endPoint [
	^ endPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:24'
}
SUSStraightRoad >> endPoint: anObject [
	endPoint := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:24'
}
SUSStraightRoad >> nextRoad [
	^ nextRoad
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:24'
}
SUSStraightRoad >> nextRoad: anObject [
	nextRoad := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:24'
}
SUSStraightRoad >> prevRoad [
	^ prevRoad
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:24'
}
SUSStraightRoad >> prevRoad: anObject [
	prevRoad := anObject
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
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:23'
}
SUSStraightRoad >> startPoint [
	^ startPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:23'
}
SUSStraightRoad >> startPoint: anObject [
	startPoint := anObject
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 18:55'
}
SUSStraightRoad >> updateConnectionBackwards [

	self prevRoad ifNotNil: [
		self prevRoad endPoint: self startPoint.
		self nextRoad updateConnectionBackwards]
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 18:54'
}
SUSStraightRoad >> updateConnectionForward [

	self nextRoad ifNotNil: [
		self nextRoad startPoint: self endPoint.
		self nextRoad updateConnectionForward]
]
