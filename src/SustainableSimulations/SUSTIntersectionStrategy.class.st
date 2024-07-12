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
	#'squeak_changestamp' : 'PM 7/11/2024 19:26'
}
SUSTIntersectionStrategy >> getBlockedLanesFrom: aLane [ 
	(road lanes indexOf: aLane)
			\\ 2 = 1
		ifTrue: [^ self getBlockedLanesWithFirstTurnFrom: aLane]
		ifFalse: [^ self getBlockedLanesWithSecondTurnFrom: aLane]
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:20'
}
SUSTIntersectionStrategy >> getBlockedLanesWithFirstTurnFrom: aLane [ 
	| index |
	index := (road lanes indexOf: aLane)
				+ 1 \\ 6 + 1.
	^ ({index. index \\ 6 + 1. index + 1 \\ 6 + 1}
		collect: [:each | road lanes at: each]) asOrderedCollection
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:19'
}
SUSTIntersectionStrategy >> getBlockedLanesWithSecondTurnFrom: aLane [ 
	^ {road lanes at: (road lanes indexOf: aLane)
			+ 2 \\ 6 + 1} asOrderedCollection
]
