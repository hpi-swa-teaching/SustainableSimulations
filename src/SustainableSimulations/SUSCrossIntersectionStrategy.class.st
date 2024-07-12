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
	#'squeak_changestamp' : 'PM 7/11/2024 19:01'
}
SUSCrossIntersectionStrategy >> getBlockedLanesWithAt: anArray from: aLane [
	^ (anArray
		collect: [:each | road lanes at: (road lanes indexOf: aLane)
					+ each \\ 12 + 1]) asOrderedCollection
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:01'
}
SUSCrossIntersectionStrategy >> getBlockedLanesWithLeftTurnFrom: aLane [ 
	^ self getBlockedLanesWithAt: {2. 3. 6. 7. 8. 9} from: aLane
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:01'
}
SUSCrossIntersectionStrategy >> getBlockedLanesWithNoTurnFrom: aLane [
	^ self getBlockedLanesWithAt: {1. 2. 3. 4. 7. 8} from: aLane
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:02'
}
SUSCrossIntersectionStrategy >> getBlockedLanesWithRightTurnFrom: aLane [ 
	^ self getBlockedLanesWithAt: {3. 7} from: aLane
]
