Class {
	#name : #SUSCrossIntersectionRightOfWayStrategy,
	#superclass : #SUSCrossIntersectionStrategy,
	#instVars : [
		'rightOfWayType'
	],
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 11:16'
}
SUSCrossIntersectionRightOfWayStrategy >> initialize [
	super initialize.
	rightOfWayType := 1.
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 13:36'
}
SUSCrossIntersectionRightOfWayStrategy >> isBlockedFrom: aLane [ 
	| blockedLanes index |
	index := road lanes indexOf: aLane.
	blockedLanes := self getBlockedLanesFrom: aLane.
	blockedLanes
		do: [:each | each cars
				ifNotEmpty: [^ true]].
	index \\ 3 = 1
		ifTrue: [
			| car |
			car := (road
					searchForCarBackwardsFromLane: (road lanes at: index + 5 \\ 12 + 1)
					WithMaxDist: 400).
				car ifNotNil: [
					(car turnsLeftAt: road) ifFalse: [^ true]]].
	(index - 1 / 3) floor \\ 2 == 0
		ifTrue: [^ false].
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
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 13:36'
}
SUSCrossIntersectionRightOfWayStrategy >> shouldGiveRightOfWay: aCarCollection [
	^ false
]
