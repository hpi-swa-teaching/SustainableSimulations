Class {
	#name : #SUSCrossIntersectionRightOfWayStrategy,
	#superclass : #SUSRoadStrategy,
	#instVars : [
		'rightOfWayType'
	],
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 11:18'
}
SUSCrossIntersectionRightOfWayStrategy >> getBlockedLanesFrom: aLane [ 
	| index |
	index := road lanes indexOf: aLane.
	index := index - 1 \\ 3 + 1.
	index = 1
		ifTrue: [^ self getBlockedLanesWithLeftTurnFrom: aLane].
	index = 2
		ifTrue: [^ self getBlockedLanesWithNoTurnFrom: aLane].
	index = 3
		ifTrue: [^ self getBlockedLanesWithRightTurnFrom: aLane]
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 11:51'
}
SUSCrossIntersectionRightOfWayStrategy >> getBlockedLanesWithLeftTurnFrom: aLane [ 
	| index blockedLanes |
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (road lanes at: index + 2 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 3 \\ 12 + 1).
	"blockedLanes
		add: (road lanes at: index + 5 \\ 12 + 1)."
	blockedLanes
		add: (road lanes at: index + 6 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 7 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 8 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 9 \\ 12 + 1).
	^ blockedLanes
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 11:18'
}
SUSCrossIntersectionRightOfWayStrategy >> getBlockedLanesWithNoTurnFrom: aLane [ 
	| index blockedLanes |
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (road lanes at: index + 1 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 2 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 3 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 4 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 7 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 8 \\ 12 + 1).
	^ blockedLanes
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 11:18'
}
SUSCrossIntersectionRightOfWayStrategy >> getBlockedLanesWithRightTurnFrom: aLane [ 
	| index blockedLanes |
	index := road lanes indexOf: aLane.
	blockedLanes := OrderedCollection new.
	blockedLanes
		add: (road lanes at: index + 3 \\ 12 + 1).
	blockedLanes
		add: (road lanes at: index + 7 \\ 12 + 1).
	^ blockedLanes
]

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
