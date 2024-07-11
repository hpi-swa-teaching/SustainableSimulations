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
	#'squeak_changestamp' : 'PM 7/11/2024 19:55'
}
SUSTIntersectionRightOfWayStrategy >> isBlockedByOtherLanesFrom: aLane [ 
	| index car |
	index := road lanes indexOf: aLane.
	car := self searchForCarAtIndex: 5.
	(index = 3 and: car isNil not)
		ifTrue: [^ true].
	index > 2
		ifTrue: [^ false].
	(index = 2
			and: (car isNil
					or: [car turnsRightAt: road]))
		ifTrue: [^ false].
	car
		ifNotNil: [^ true].
	^ (self searchForCarAtIndex: 3) isNil not
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 19:57'
}
SUSTIntersectionRightOfWayStrategy >> maxSearchDistance [
	^ 300
]

{
	#category : #strategy,
	#'squeak_changestamp' : 'GoChriNo 7/10/2024 14:08'
}
SUSTIntersectionRightOfWayStrategy >> shouldGiveRightOfWayTime: aCarCollection [ 
	^ false
]
