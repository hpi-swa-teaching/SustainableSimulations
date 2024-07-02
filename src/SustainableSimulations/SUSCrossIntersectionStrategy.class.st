Class {
	#name : #SUSCrossIntersectionStrategy,
	#superclass : #SUSRoadStrategy,
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:24'
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:24'
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:24'
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 14:24'
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
