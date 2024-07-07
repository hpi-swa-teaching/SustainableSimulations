Class {
	#name : #SUSUserMessages,
	#superclass : #Object,
	#instVars : [
		'open'
	],
	#category : #'SustainableSimulations-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 7/5/2024 15:01'
}
SUSUserMessages class >> newUserMessagesManager [
	^ self new
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 7/5/2024 15:13'
}
SUSUserMessages >> initialize [
	super initialize.
	
	open := false

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 7/7/2024 18:58'
}
SUSUserMessages >> openTranscript [
	open ifFalse: [
		TranscriptStream openMorphicTranscript.
		open := true]
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 7/7/2024 18:58'
}
SUSUserMessages >> showErrorRoadBuild [
	self openTranscript.
	Transcript showln: (self textErrorRoadBuild)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 7/7/2024 19:07'
}
SUSUserMessages >> showErrorRoadClick [
	self openTranscript.
	Transcript showln: (self textErrorRoadClick)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 7/7/2024 19:03'
}
SUSUserMessages >> textErrorRoadBuild [
	^ 'It is impossible to build this road. Try to build a realistic road. So no too tight angles or too short roads and do not click on any other road object.'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Len 7/7/2024 19:09'
}
SUSUserMessages >> textErrorRoadClick [
	^ 'This click is invalid. Click on an empty area or select auto-spawn mode.'
]
