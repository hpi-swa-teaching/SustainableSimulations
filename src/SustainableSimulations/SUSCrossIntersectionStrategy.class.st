"
Abstract Class for different right of way rules / strategys for cross intersections
"
Class {
	#name : #SUSCrossIntersectionStrategy,
	#superclass : #SUSRoadStrategy,
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:49'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:53'
}
SUSCrossIntersectionStrategy >> getBlockedLanesFrom: aLane [ 
	| index |
	index := road lanes indexOf: aLane.
	index := index - 1 \\ 3 + 1.
	index = 1
		ifTrue: [^ self getBlockedLanesWithLeftTurnFrom: aLane].
	index = 2
		ifTrue: [^ self getBlockedLanesWithNoTurnFrom: aLane].
	index = 3
		ifTrue: [^ self getBlockedLanesWithRightTurnFrom: aLane]
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:53'
}
SUSCrossIntersectionStrategy >> getBlockedLanesWithLeftTurnFrom: aLane [ 
	| index blockedLanes |
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (road lanes at: index + 2 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 3 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 6 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 7 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 8 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 9 \\ 12 + 1).
	^ blockedLanes
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:53'
}
SUSCrossIntersectionStrategy >> getBlockedLanesWithNoTurnFrom: aLane [ 
	| index blockedLanes |
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (road lanes at: index + 1 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 2 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 3 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 4 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 7 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 8 \\ 12 + 1).
	^ blockedLanes
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:53'
}
SUSCrossIntersectionStrategy >> getBlockedLanesWithRightTurnFrom: aLane [ 
	| index blockedLanes |
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (road lanes at: index + 3 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 7 \\ 12 + 1).
	^ blockedLanes
]
