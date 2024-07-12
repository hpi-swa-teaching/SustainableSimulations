"
Class for the right of way street rule / strategy for cross intersections

Instance variables:
	rightOfWayType:	Number

rightOfWayType
	- Either 1 or 2 depending on the direction of the right of way rule
"
Class {
	#name : #SUSCrossIntersectionRightOfWayStrategy,
	#superclass : #SUSCrossIntersectionStrategy,
	#instVars : [
		'rightOfWayType'
	],
	#category : #'SustainableSimulations-RoadStrategy',
	#'squeak_changestamp' : 'PM 7/11/2024 18:54'
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
	#'squeak_changestamp' : 'PM 7/11/2024 19:53'
}
SUSCrossIntersectionRightOfWayStrategy >> isBlockedByOtherLanesFrom: aLane [ 
	| index car |
	index := road lanes indexOf: aLane.
	index \\ 3 = 1
		ifTrue: [car := self searchForCarAtIndex: index + 5 \\ 12 + 1.
			(car isNil not
					and: [(car turnsLeftAt: road) not])
				ifTrue: [^ true]].
	(index - 1 / 3) floor \\ 2 == (rightOfWayType - 1)
		ifTrue: [^ false].
	(self searchForCarAtIndex: index + 2 \\ 12 + 1)
		ifNotNil: [^ true].
	(self searchForCarAtIndex: index + 8 \\ 12 + 1)
		ifNotNil: [^ true].
	^ false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'PM 7/11/2024 19:17'
}
SUSCrossIntersectionRightOfWayStrategy >> maxSearchDistance [
	^ 400
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
