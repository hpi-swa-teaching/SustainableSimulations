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
	#'squeak_changestamp' : 'PM 7/11/2024 19:55'
}
SUSTIntersectionRightBeforeLeftStrategy >> isBlockedByOtherLanesFrom: aLane [ 
	| index |
	index := road lanes indexOf: aLane.
	index \\ 2 = 0
		ifTrue: [^ false].
	(index = 3 and: (self searchForCarAtIndex: 5) isNil not)
		ifTrue: [^ true].
	(index \\ 4 = 1 and: (self searchForCarAtIndex: index + 1 \\ 6 + 1) isNil not)
		ifTrue: [^ true].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:21'
}
SUSTIntersectionRightBeforeLeftStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	^ aCarCollection size >= 3
]
