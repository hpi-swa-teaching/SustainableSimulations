Class {
	#name : #SUSTIntersectionRightOfWayStrategy,
	#superclass : #SUSTIntersectionStrategy,
	#category : #'SustainableSimulations-RoadStrategy'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/2/2024 15:01'
}
SUSTIntersectionRightOfWayStrategy >> isBlockedFrom: aLane [ 
	| blockedLanes index car |
	index := road lanes indexOf: aLane.
	blockedLanes := self getBlockedLanesFrom: aLane.
	blockedLanes
		do: [:each | each cars
				ifNotEmpty: [^ true]].
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
		ifTrue: [car ifNil: [^ false] ifNotNil:[ (car turnsRightAt: road)
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 7/3/2024 08:34'
}
SUSTIntersectionRightOfWayStrategy >> shouldGiveRightOfWay: aCarCollection [
	^ false
]
