"
Class for the right of way street rule / strategy for cross intersections
"
Class {
	#name : #SUSCrossIntersectionRightOfWayStrategy,
	#superclass : #SUSCrossIntersectionStrategy,
	#instVars : [
		'rightOfWayType'
	],
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 13:51'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSCrossIntersectionRightOfWayStrategy >> initialize [
	super initialize.
	rightOfWayType := 1
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSCrossIntersectionRightOfWayStrategy >> isBlockedByOtherLanesFrom: aLane [ 
	| index |
	index := road lanes indexOf: aLane.
	index \\ 3 = 1
		ifTrue: [| car |
			car := road
						searchForCarBackwardsFromLane: (road lanes at: index + 5 \\ 12 + 1)
						WithMaxDist: 400.
			car
				ifNotNil: [(car turnsLeftAt: road)
						ifFalse: [^ true]]].
	rightOfWayType = 1
		ifTrue: [(index - 1 / 3) floor \\ 2 == 0
				ifTrue: [^ false]].
	rightOfWayType = 2
		ifTrue: [(index - 1 / 3) floor \\ 2 == 1
				ifTrue: [^ false]].
	(road
		searchForCarBackwardsFromLane: (road lanes at: index + 2 \\ 12 + 1)
		WithMaxDist: 400)
		ifNotNil: [^ true].
	(road
		searchForCarBackwardsFromLane: (road lanes at: index + 8 \\ 12 + 1)
		WithMaxDist: 400)
		ifNotNil: [^ true].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSCrossIntersectionRightOfWayStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	^ false
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:07'
}
SUSCrossIntersectionRightOfWayStrategy >> swapRightOfWayDirection [
	rightOfWayType = 1
		ifTrue: [rightOfWayType := 2]
		ifFalse: [rightOfWayType := 1]
]
