#!/bin/bash


XP=0
NIVEAU=1
#choisi au hasard entre 15 et 150
#si > 150 on augmente le level et le playerstr augmente de 2
level(){
XP=$(( $XP+$[ RANDOM % 35 +15 ] ))

echo "XP: $XP"

if [[ $XP -ge 100 ]]; then
	NIVEAU=$(( $NIVEAU + 1 ))
	XP=0
	echo "NIVEAU: $NIVEAU"
	${playerStr[0]}=$(( ${playerStr[0]} + 2 ))

fi

}

