"
Class for the right of way street rule / strategy for t intersections
"
Class {
	#name : #SUSTIntersectionRightOfWayStrategy,
	#superclass : #SUSTIntersectionStrategy,
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:51'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:08'
}
SUSTIntersectionRightOfWayStrategy >> isBlockedByOtherLanesFrom: aLane [ 
	| index car |
	index := road lanes indexOf: aLane.
	index = 3
		ifTrue: [(road
				searchForCarBackwardsFromLane: (road lanes at: 5)
				WithMaxDist: 300)
				ifNotNil: [^ true]].
	index > 2
		ifTrue: [^ false].
	car := road
				searchForCarBackwardsFromLane: (road lanes at: 5)
				WithMaxDist: 300.
	index = 2
		ifTrue: [car
				ifNil: [^ false]
				ifNotNil: [(car turnsRightAt: road)
						ifTrue: [^ false]]].
	car
		ifNotNil: [^ true].
	(road
		searchForCarBackwardsFromLane: (road lanes at: 3)
		WithMaxDist: 300)
		ifNotNil: [^ true].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:08'
}
SUSTIntersectionRightOfWayStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	^ false
]
