Class {
	#name : #SUSBezierCurve,
	#superclass : #Object,
	#instVars : [
		'controlPoints'
	],
	#category : #SustainableSimulations
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/22/2024 20:14'
}
SUSBezierCurve >> addControlPoint: apoint [
	controlPoints add: apoint.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/23/2024 17:29'
}
SUSBezierCurve >> choose: k [ 
    ^((self factorial) / ((k factorial) * ((self - k) factorial)))

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/22/2024 20:15'
}
SUSBezierCurve >> controlPoints [
	^controlPoints.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/23/2024 17:22'
}
SUSBezierCurve >> initialize [

	controlPoints := OrderedCollection new.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 21:33'
}
SUSBezierCurve >> length [
	"Momentan nur für lineare Bezierkurven. Quadratische kommen noch."
	
	^(controlPoints last x - controlPoints first x)
	"((controlPoints last x - controlPoints first x) squared + (controlPoints last y - controlPoints first y) squared) sqrt."

	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 5/27/2024 22:06'
}
SUSBezierCurve >> pointAt: t [
	"Works only for linear bezier curve" 
	^((controlPoints first * (1 - t)) + (controlPoints last * t)) min: controlPoints last.
]
