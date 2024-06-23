Class {
	#name : #SUSRoadBuilderTests,
	#superclass : #TestCase,
	#category : #'SustainableSimulations-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MK 6/23/2024 02:13'
}
SUSRoadBuilderTests >> testAddUserDirectionToToPositiveDegrees [
    | builder from to degrees direction |

    "Erstelle einen RoadBuilder und setze die Werte"
    builder := SUSRoadBuilder new.
    from := SUSDirectedPoint newWithPosition: 0@0 inDirection: 1@0.
    to := 1@1.
    degrees := 45.

    "Stub für askForDegrees Methode"
    builder class compile: 'askForDegrees ^ degrees'.

    "Setze die Directed Points"
    builder from: from.
    builder to: to.

    "Erstelle eine erwartete Richtung"
    direction := from direction rotateBy: degrees degreesToRadians about: 0 @ 0.

    "Rufe addUserDirectionToTo auf"
    builder addUserDirectionToTo.

    "Prüfe, ob die Richtung korrekt berechnet und aktualisiert wurde"
    self assert: (builder to direction = direction).
]
