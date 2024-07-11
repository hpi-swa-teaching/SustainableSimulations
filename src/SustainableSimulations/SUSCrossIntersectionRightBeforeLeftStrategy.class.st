"
Class for the right before left rule / strategy for cross intersections
"
Class {
	#name : #SUSCrossIntersectionRightBeforeLeftStrategy,
	#superclass : #SUSCrossIntersectionStrategy,
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:50'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:52'
}
SUSCrossIntersectionRightBeforeLeftStrategy >> isBlockedByOtherLanesFrom: aLane [ 
	| index car |
	index := road lanes indexOf: aLane.
	index \\ 3 = 0
		ifTrue: [^ false].
	(self searchForCarAtIndex: index + 2 \\ 12 + 1)
		ifNotNil: [^ true].
	index \\ 3 = 1
		ifTrue: [car := self searchForCarAtIndex: index + 5 \\ 12 + 1.
			(car isNil not
					and: [(car turnsLeftAt: road) not])
				ifTrue: [^ true]].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'PM 7/11/2024 19:52'
}
SUSCrossIntersectionRightBeforeLeftStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	^ aCarCollection size >= 3
]
