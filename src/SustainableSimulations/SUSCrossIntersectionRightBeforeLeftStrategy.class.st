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
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSCrossIntersectionRightBeforeLeftStrategy >> isBlockedByOtherLanesFrom: aLane [ 
	| index car |
	index := road lanes indexOf: aLane.
	index \\ 3 = 0
		ifTrue: [^ false].
	(road
		searchForCarBackwardsFromLane: (road lanes at: index + 2 \\ 12 + 1)
		WithMaxDist: 200)
		ifNotNil: [^ true].
	index \\ 3 = 1
		ifTrue: [car := road
						searchForCarBackwardsFromLane: (road lanes at: index + 5 \\ 12 + 1)
						WithMaxDist: 200.
			car
				ifNotNil: [(car turnsLeftAt: road)
						ifFalse: [^ true]]].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSCrossIntersectionRightBeforeLeftStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	aCarCollection size >= 3
		ifTrue: [^ true].
	^ false
]
