Class {
	#name : #SUSCrossIntersectionRightBeforeLeftStrategy,
	#superclass : #SUSCrossIntersectionStrategy,
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 12:52'
}
SUSCrossIntersectionRightBeforeLeftStrategy >> isBlockedFrom: aLane [ 
	| blockedLanes index |
	index := road lanes indexOf: aLane.
	blockedLanes := self getBlockedLanesFrom: aLane.
	blockedLanes
		do: [:each | each cars
				ifNotEmpty: [^ true]].
	index \\ 3 = 0
		ifTrue: [^ false].
	(road
			searchForCarBackwardsFromLane: (road lanes at: index + 2 \\ 12 + 1)
			WithMaxDist: 200)
		ifNotNil: [^ true].
	index \\ 3 = 1
		ifTrue: [(road
					searchForCarBackwardsFromLane: (road lanes at: index + 5 \\ 12 + 1)
					WithMaxDist: 200)
				ifNotNil: [^ true]].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 11:37'
}
SUSCrossIntersectionRightBeforeLeftStrategy >> shouldGiveRightOfWay: aCarCollection [
"check for two left turners"
	aCarCollection size = 2
		ifTrue: [| car1 car2 |
			car1 := aCarCollection asOrderedCollection at: 1.
			car2 := aCarCollection asOrderedCollection at: 2.
			(car1 route first = 1
					and: car2 route first = 1
					and: ((self getOppositeLanesFrom: car1 lane nextLanes first)
							includes: car2 lane nextLanes first))
				ifTrue: [^ true]].
	"check for remaining edgecases"
	aCarCollection size >= 3
		ifTrue: [^ true].
	^ false.
]
