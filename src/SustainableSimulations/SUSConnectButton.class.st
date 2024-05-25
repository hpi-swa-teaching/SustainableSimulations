Class {
	#name : #SUSConnectButton,
	#superclass : #Morph,
	#instVars : [
		'road',
		'node'
	],
	#category : #SustainableSimulations
}

{
	#category : #'event handling',
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:53'
}
SUSConnectButton >> handleMouseDown: anEvent [ 
	self road roadClickedAt: self node
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:51'
}
SUSConnectButton >> handlesMouseDown: anEvent [ 
	^ true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:48'
}
SUSConnectButton >> node [
	^ node
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:48'
}
SUSConnectButton >> node: anObject [
	node := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:48'
}
SUSConnectButton >> road [
	^ road
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'GoChriNo 5/22/2024 14:48'
}
SUSConnectButton >> road: anObject [
	road := anObject
]
