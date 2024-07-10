"
Abstract Class for different right of way rules / strategys for t intersection
"
Class {
	#name : #SUSTIntersectionStrategy,
	#superclass : #SUSRoadStrategy,
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:50'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSTIntersectionStrategy >> getBlockedLanesFrom: aLane [ 
	| index |
	index := road lanes indexOf: aLane.
	index \\ 2 = 1
		ifTrue: [^ self getBlockedLanesWithFirstTurnFrom: aLane]
		ifFalse: [^ self getBlockedLanesWithSecondTurnFrom: aLane]
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSTIntersectionStrategy >> getBlockedLanesWithFirstTurnFrom: aLane [ 
	| index blockedLanes |
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	index := index + 1 \\ 6 + 1.
	blockedLanes
		add: (road lanes at: index).
	blockedLanes
		add: (road lanes at: index \\ 6 + 1).
	blockedLanes
		add: (road lanes at: index + 1 \\ 6 + 1).
	^ blockedLanes
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSTIntersectionStrategy >> getBlockedLanesWithSecondTurnFrom: aLane [ 
	| index blockedLanes |
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (road lanes at: index + 2 \\ 6 + 1).
	^ blockedLanes
]
