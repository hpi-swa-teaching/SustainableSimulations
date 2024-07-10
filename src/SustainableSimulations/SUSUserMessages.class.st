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
	#'squeak_changestamp' : 'PM 7/10/2024 12:58'
}
SUSUserMessages >> openTranscript [
	open
		ifFalse: [TranscriptStream openMorphicTranscript.
			open := true]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'PM 7/10/2024 12:57'
}
SUSUserMessages >> showError: aString [
	self openTranscript.
	Transcript showln: aString
]
