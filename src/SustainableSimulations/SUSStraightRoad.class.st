Class {
	#name : #SUSStraightRoad,
	#superclass : #Object,
	#instVars : [
		'speedLimit',
		'points',
		'adjacentRoads',
		'length',
		'directions',
		'otherNodes',
		'buttons',
		'lastClicked'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:58'
}
SUSStraightRoad class >> newFrom: startPoint To: endPoint [

	^ SUSStraightRoad newFrom: startPoint To: endPoint SpeedLimit: 50
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 15:00'
}
SUSStraightRoad class >> newFrom: startPoint To: endPoint SpeedLimit: speedLimit [ 
	| length |
	length := ((endPoint x - startPoint x) squared + (endPoint y - startPoint y) squared) sqrt.
	
	
	
	^ SUSStraightRoad new 
		 speedLimit: speedLimit;
		 points: {startPoint. endPoint} asOrderedCollection;
		 adjacentRoads: {nil. nil} asOrderedCollection;
		otherNodes: {nil. nil} asOrderedCollection;
		 length: length;
		directions: {startPoint - endPoint / length. endPoint - startPoint / length};
		addButtons.
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 5/23/2024 13:30'
}
SUSStraightRoad >> addButtons [
	self buttons: {SUSConnectButton new position: (self points at: 1)
				- (20 @ 20);
			 extent: 40 @ 40;
			 color: Color red. SUSConnectButton new position: (self points at: 2)
				- (20 @ 20);
			 extent: 40 @ 40;
			 color: Color red} asOrderedCollection.
	self buttons
		doWithIndex: [:each :index | each road: self; node: index; openInWorld]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:36'
}
SUSStraightRoad >> adjacentRoads [
	^ adjacentRoads
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:36'
}
SUSStraightRoad >> adjacentRoads: anObject [
	adjacentRoads := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:54'
}
SUSStraightRoad >> buttons [
	^ buttons
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:54'
}
SUSStraightRoad >> buttons: anObject [
	buttons := anObject
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:23'
}
SUSStraightRoad >> connectToRoad: road From: ownNode To: otherNode [ 
	(self adjacentRoads at: ownNode)
		ifNil: [(road adjacentRoads at: otherNode)
				ifNil: [self adjacentRoads at: ownNode put: road.
					self otherNodes at: ownNode put: otherNode.
					road adjacentRoads at: otherNode put: self.
					road otherNodes at: otherNode put: ownNode.
					road updateConnectionFrom: otherNode]]
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/23/2024 13:33'
}
SUSStraightRoad >> connectWith: aRoad [

	aRoad lastClicked ifNotNil: [
		self lastClicked ifNotNil: [
			self connectToRoad: aRoad From: self lastClicked To: aRoad lastClicked.
			]
		]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 13:42'
}
SUSStraightRoad >> directions [
	^ directions
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 13:42'
}
SUSStraightRoad >> directions: anObject [
	directions := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:54'
}
SUSStraightRoad >> lastClicked [
	^ lastClicked
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:54'
}
SUSStraightRoad >> lastClicked: anObject [
	lastClicked := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:58'
}
SUSStraightRoad >> length [
	^ length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:58'
}
SUSStraightRoad >> length: anObject [
	length := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:14'
}
SUSStraightRoad >> otherNodes [
	^ otherNodes
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:14'
}
SUSStraightRoad >> otherNodes: anObject [
	otherNodes := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:38'
}
SUSStraightRoad >> points [
	^ points
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/21/2024 11:38'
}
SUSStraightRoad >> points: anObject [
	points := anObject
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 5/23/2024 13:32'
}
SUSStraightRoad >> roadClickedAt: node [

	self lastClicked: node.
	"notifyRoadSelected: self"
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:23'
}
SUSStraightRoad >> speedLimit [
	^ speedLimit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/14/2024 11:23'
}
SUSStraightRoad >> speedLimit: anObject [
	speedLimit := anObject
]

{
	#category : #utility,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:00'
}
SUSStraightRoad >> swap: node [ 
	node == 1
		ifTrue: [^ 2]
		ifFalse: [^ 1]
]

{
	#category : #connecting,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:41'
}
SUSStraightRoad >> updateConnectionFrom: node [ 
	self points
		at: node
		put: ((self adjacentRoads at: node) points
				at: (self otherNodes at: node)).
	self points
		at: (self swap: node)
		put: ((self adjacentRoads at: node) directions
				at: (self otherNodes at: node))
				* self length
				+ ((self adjacentRoads at: node) points
						at: (self otherNodes at: node)).
	self directions at: node put: ((self adjacentRoads at: node) directions
			at: (self otherNodes at: node)) negated.
	self directions
		at: (self swap: node)
		put: (self directions at: node) negated.
	self adjacentRoads
		doWithIndex: [:each :index | (each notNil and: index ~= node)
				ifTrue: [each
						updateConnectionFrom: (self otherNodes at: index)]]
]
