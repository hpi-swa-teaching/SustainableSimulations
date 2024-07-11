"
Class for the right before left rule / strategy for t intersections
"
Class {
	#name : #SUSTIntersectionRightBeforeLeftStrategy,
	#superclass : #SUSTIntersectionStrategy,
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:51'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 14:57'
}
SUSTIntersectionRightBeforeLeftStrategy >> isBlockedByOtherLanesFrom: aLane [ 
	| index |
	index := road lanes indexOf: aLane.
	index \\ 2 = 0
		ifTrue: [^ false].
	index = 3
		ifTrue: [(road
				searchVehicleBackwardsFromLane: (road lanes at: 5)
				withMaxDist: 200)
				ifNotNil: [^ true]].
	index \\ 4 = 1
		ifTrue: [(road
				searchVehicleBackwardsFromLane: (road lanes at: index + 1 \\ 6 + 1)
				withMaxDist: 200)
				ifNotNil: [^ true]].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:08'
}
SUSTIntersectionRightBeforeLeftStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	aCarCollection size >= 3
		ifTrue: [^ true].
	^ false
]
