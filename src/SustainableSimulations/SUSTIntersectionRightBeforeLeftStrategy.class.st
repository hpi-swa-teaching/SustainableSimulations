Class {
	#name : #SUSTIntersectionRightBeforeLeftStrategy,
	#superclass : #SUSTIntersectionStrategy,
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 12:52'
}
SUSTIntersectionRightBeforeLeftStrategy >> isBlockedFrom: aLane [ 
	| blockedLanes index |
	index := road lanes indexOf: aLane.
	blockedLanes := self getBlockedLanesFrom: aLane.
	blockedLanes
		do: [:each | each cars
				ifNotEmpty: [^ true]].
	index \\ 2 = 0
		ifTrue: [^ false].
	index = 3
		ifTrue: [(road
					searchForCarBackwardsFromLane: (road lanes at: 5)
					WithMaxDist: 200)
				ifNotNil: [^ true]].
	index \\ 4 = 1
		ifTrue: [(road
					searchForCarBackwardsFromLane: (road lanes at: index + 1 \\ 6 + 1)
					WithMaxDist: 200)
				ifNotNil: [^ true]].
	^ false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 11:37'
}
SUSTIntersectionRightBeforeLeftStrategy >> shouldGiveRightOfWay: aCarCollection [
	aCarCollection size >= 3
		ifTrue: [^ true].
	^ false.
]
