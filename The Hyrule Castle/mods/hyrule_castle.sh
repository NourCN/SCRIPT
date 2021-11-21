#!/bin/bash

#couleurs
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
no='\033[0;m'

#init jeu
level=1
ingame=1
difficulty=1

source basic_game_customization.sh
startOption
chooseHowManyCombats

source better_combat_options.sh

#initialisation des joueurs
source playerRandom.sh ./data/players.csv
playerId[0]=$id
playerName[0]=$name
playerHp[0]=$hp
playerHpMax[0]=$hp
playerMp[0]=$mp
playerStr[0]=$str
playerInt[0]=$int
playerDef[0]=$def
playerRes[0]=$res
playerSpd[0]=$spd
playerLuck[0]=$luck
playerRace[0]=$race
playerClass[0]=$class
playerRarity[0]=$rarity
hpmaxhero=${playerHp[0]}
source level_and_experience.sh

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

#afficher les points stats des combattants
affichageHp(){
echo -e "=========== FIGHT $level ===========\n"
echo "NIVEAU : $NIVEAU, XP : $XP"
echo "COIN : $coinsStart"
echo -e "${red}$name${no}"
barredevie ${monsterHpMax[0]} ${monsterHp[0]} ${playerStr[0]} 0
echo -e "${green}${playerName[0]}${no}"
barredevie ${playerHpMax[0]} ${playerHp[0]} ${monsterStr[0]} $1
}

#boucle pour les combats
combat() {
    victoire=0
    affichageHp $name $hp $hpMax ${playerName[0]} ${playerHp[0]} ${playerHpMax[0]}
    echo -e "Debut Combat \n"
    echo "---Options-----------"
    echo -e "1. Attack   2. Heal   $escapename \n"
    echo "You encounter a $name"
    
    while [[ $victoire -eq 0 ]]; do
    read option
    clear
    #echo "Option: $option"
    if [[ $option == "1" ]]; then
       # calcul des dégats infligé et reçu
       dmgmonster=$(echo "${monsterStr[0]} * $difficulty" | bc | awk '{print int($1)}')
        monsterHp[0]=$(echo "${monsterHp[0]} - ${playerStr[0]}" | bc)
        playerHp[0]=$(echo "${playerHp[0]} - $dmgmonster" | bc)
        if [[ ${playerHp[0]} -le 0 ]]; then
            ingame=0
            victoire=1
        elif [[ ${monsterHp[0]} -le 0 ]]; then
        monsterHp[0]=0
        victoire=1
        affichageHp 0
        echo "You attacked and dealt ${playerStr[0]} damages!"
        echo "${monsterName[0]}} died!"
        echo "=== Press any key to continue ==="
        read
        else
            affichageHp 0
            echo -e "1. Attack   2. Heal   $escapename \n"
            echo "You attacked and dealt ${playerStr[0]} damages!"
        fi
     elif [[ $option == "2" ]]; then
  playerHp[0]=$(echo "${playerHp[0]} + ${playerHpMax[0]}/2" | bc)
	if [[ ${playerHp[0]} -ge ${playerHpMax[0]} ]]; then
		playerHp[0]=${playerHpMax[0]}
	fi
	affichageHp 1
	echo "you used heal"
  elif [[ $option == "3" ]]; then
  		victoire=1
  	  playerName[0]="(coward) ${playerName}"
  	  coinsStart=$(($coinsStart-5))
  fi
    done
}


#boucle d'une partie
ingame=1
while [[ $ingame -eq 1 ]]; do


if [[ $level -lt $etage ]]; then
  echo $(($level % 10))
  if [[ $(($level % 10)) -eq "0"  ]]; then
    source playerRandom.sh ./data/bosses.csv
  else
    source playerRandom.sh ./data/enemies.csv
  fi
else
    source playerRandom.sh ./data/bosses.csv
    ingame=0
fi
#initialisation monstre de manière à en faire 4 plus tard
monsterId[0]=$id
monsterName[0]=$name
monsterHp[0]=$hp
monsterHpMax[0]=$hp
monsterMp[0]=$mp
monsterStr[0]=$str
monsterInt[0]=$int
monsterDef[0]=$def
monsterRes[0]=$res
monsterSpd[0]=$spd
monsterLuck[0]=$luck
monsterRace[0]=$race
monsterClass[0]=$class
monsterRarity[0]=$rarity
playerCoins
clear
combat
level


level=$(($level+1))
done
