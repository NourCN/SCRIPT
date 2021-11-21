#!/bin/bash

#couleurs
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
no='\033[0;m'

#init jeu
level=1
ingame=1
message=""

#initialisation des joueurs
#source playerRandom.sh ./data/players.csv
playerId[0]=0
playerName[0]=Link
playerHp[0]=60
playerHpMax[0]=60
playerStr[0]=15

#afficher la barre de vie
barredevie(){
    vieact=$2
    viemax=$1
    dmg=$3
    heal=$4
    barre=""
    barredmg=""
    barrevide=""
    barreheal=""
    for (( i=0; i<$viemax; i++ ))
    do
        if [[ $i -le $(($vieact-((${playerHpMax[0]}/2)*$4))) ]]; then
          barre+="I"
        elif [[ $i -le $vieact ]]; then
          barreheal+="I"
        elif [[ $i -le $(($vieact-((${playerHpMax[0]}/2)*$4)+$dmg)) ]]; then
        barredmg+="-"
        else
        barrevide+="-"
        fi
    done
    echo -e "HP: ${red}$barre${green}$barreheal${red}$barredmg${no}$barrevide $vieact / $viemax \n "
}

#afficher les points de vie des combattants
affichageHp(){
echo "=========== FIGHT $level ==========="
echo -e "${red}$monsterName${no}"
barredevie ${monsterHpMax[0]} ${monsterHp[0]} ${playerStr[0]} 0
echo -e "${green}${playerName[0]}${no}"
barredevie ${playerHpMax[0]} ${playerHp[0]} ${monsterStr[0]} $1
}

#boucle pour les combats
combat() {
  clear
    victoire=0
    affichageHp $name $hp $hpMax ${playerName[0]} ${playerHp[0]} ${playerHpMax[0]}
    echo -e "Debut Combat \n"
    echo "---Options-----------"
    echo -e "1. Attack   2. Heal\n"
    echo "You encounter a $name"

    while [[ $victoire -eq 0 ]]; do
    read option
    clear
    #echo "Option: $option"
    if [[ $option == "1" ]]; then
        monsterHp[0]=$(echo "${monsterHp[0]} - ${playerStr[0]}" | bc)
        playerHp[0]=$(echo "${playerHp[0]} - ${monsterStr[0]}" | bc)
        if [[ ${playerHp[0]} -le 0 ]]; then
            ingame=0
            victoire=1
        elif [[ ${monsterHp[0]} -le 0 ]]; then
        monsterHp[0]=0
        victoire=1
        affichageHp 0
        echo "You attacked and dealt ${playerStr[0]} damages!"
        echo "${monsterName[0]} died!"
        echo "=== Press any key to continue ==="
        else
            affichageHp 0
            echo -e "1. Attack   2. Heal\n"
            echo "You attacked and dealt ${playerStr[0]} damages!"
        fi
     elif [[ $option == "2" ]]; then
  playerHp[0]=$(echo "${playerHp[0]} + ${playerHpMax[0]}/2" | bc)
	if [[ ${playerHp[0]} -ge ${playerHpMax[0]} ]]; then
		playerHp[0]=${playerHpMax[0]}
	fi
	affichageHp 1
	echo "you used heal"
    fi
    done
}


#boucle d'une partie
ingame=1
while [[ $ingame -eq 1 ]]; do


if [ $level -le 9 ]; then
    monsterName[0]=Bokoblin
    monsterHp[0]=30
    monsterHpMax[0]=30
    monsterStr[0]=5
else
    monsterName[0]=Ganon
    monsterHp[0]=150
    monsterHpMax[0]=150
    monsterStr[0]=20
    ingame=0
    message="\n============  WELL PLAYED YOU SUCCEEDED ============= \n"
fi
#initialisation monstre de manière à en faire 4 plus tard

combat

level=$(($level+1))
done

echo -e $message