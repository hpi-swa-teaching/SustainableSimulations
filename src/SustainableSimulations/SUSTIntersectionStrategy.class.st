Class {
	#name : #SUSTIntersectionStrategy,
	#superclass : #SUSRoadStrategy,
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:25'
}
SUSTIntersectionStrategy >> getBlockedLanesFrom: aLane [ 

	| index | 
	index := road lanes indexOf: aLane.
	(index \\ 2 = 1) ifTrue: [
		^ self getBlockedLanesWithFirstTurnFrom: aLane] 
	ifFalse: [
		^ self getBlockedLanesWithSecondTurnFrom: aLane].
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:25'
}
SUSTIntersectionStrategy >> getBlockedLanesWithFirstTurnFrom: aLane [ 

	| index blockedLanes | 
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	index := index + 1 \\ 6 + 1.
	blockedLanes add: (road lanes at: index).
	blockedLanes add: (road lanes at: (index \\ 6 + 1)).
	blockedLanes add: (road lanes at: (index + 1 \\ 6 +1)).
	^ blockedLanes
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:25'
}
SUSTIntersectionStrategy >> getBlockedLanesWithSecondTurnFrom: aLane [ 

	| index blockedLanes | 
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes add: (road lanes at: (index + 2 \\ 6 + 1)).
	^ blockedLanes
]
