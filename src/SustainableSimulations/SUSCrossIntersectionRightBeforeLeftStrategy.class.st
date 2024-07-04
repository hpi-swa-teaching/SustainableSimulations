Class {
	#name : #SUSCrossIntersectionRightBeforeLeftStrategy,
	#superclass : #SUSCrossIntersectionStrategy,
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/3/2024 08:29'
}
SUSCrossIntersectionRightBeforeLeftStrategy >> isBlockedFrom: aLane [ 
	| blockedLanes index car |
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
		ifTrue: [car := (road
					searchForCarBackwardsFromLane: (road lanes at: index + 5 \\ 12 + 1)
					WithMaxDist: 200).
				car 
				ifNotNil: [(car turnsLeftAt: road) ifFalse: [^ true]]].
	^ false
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/3/2024 08:34'
}
SUSCrossIntersectionRightBeforeLeftStrategy >> shouldGiveRightOfWay: aCarCollection [
	aCarCollection size >= 3
		ifTrue: [^ true].
	^ false.
]
