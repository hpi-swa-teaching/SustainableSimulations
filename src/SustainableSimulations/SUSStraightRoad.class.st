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
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 12:14'
}
SUSStraightRoad >> connectNextStraightRoadFromRoad: road [

	| direction length roadLength |

	self nextRoad: road.
	road prevRoad: self.

	roadLength := ((road endPoint x - road startPoint x) squared + (road endPoint y - road startPoint y) 		squared) sqrt.
	length := ((self endPoint x - self startPoint x) squared + (self endPoint y - self startPoint y) 		squared) sqrt.
	direction := (self endPoint - self startPoint) / length.
	
	road startPoint: self endPoint.
	road endPoint: self endPoint + (direction * roadLength)
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
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 12:16'
}
SUSStraightRoad >> connectNextStraightRoadWithLength: length SpeedLimit: speedLimit [

	| newRoad direction|
	
	direction := (self endPoint - self startPoint) / 
		((self endPoint x - self startPoint x) squared +  (self endPoint y - self startPoint y) squared) sqrt.
		
	newRoad := (SUSStraightRoad newFrom: (self endPoint) To: (self endPoint + (direction * length)) 		SpeedLimit: speedLimit) prevRoad: self.
		
	self nextRoad: newRoad
	
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 12:22'
}
SUSStraightRoad >> connectPrevStraightRoadFromRoad: road [

	| direction length roadLength |

	self prevRoad: road.
	road nextRoad: self.

	roadLength := ((road endPoint x - road startPoint x) squared + (road endPoint y - road startPoint y) 		squared) sqrt.
	length := ((self endPoint x - self startPoint x) squared + (self endPoint y - self startPoint y) 		squared) sqrt.
	direction := (self startPoint - self endPoint) / length.
	
	road endPoint: self startPoint.
	road startPoint: self startPoint + (direction * roadLength)
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
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 12:25'
}
SUSStraightRoad >> connectPrevStraightRoadWithLength: length SpeedLimit: speedLimit [

	| newRoad direction|
	
	direction := (self startPoint - self endPoint) / 
		((self startPoint x - self endPoint x) squared +  (self startPoint y - self endPoint y) squared) sqrt.
		
	newRoad := (SUSStraightRoad newFrom: (self startPoint + (direction * length)) To: (self startPoint) 		SpeedLimit: speedLimit) nextRoad: self.
		
	self prevRoad: newRoad
	
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
