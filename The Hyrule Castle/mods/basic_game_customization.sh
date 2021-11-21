#!/bin/bash

#options "new Game" or "Quit"

#if "New game" chose difficulty "Normal" "difficult" "Insane"

      #difficult mode ennemy stat is multiplied by 1.5
      #INsane multiplie by 2
# choose how many fight 10 20 50 or 100

# player start with 12 coins and win 1 after evry victory
coinsStart=12

ChoseDifficulty () {
    echo " difficulty level"
    echo " 1: Normal"
    echo " 2: Difficile"
    echo " 3: Insane"
    read option
    clear 

    if [[ $option == "1" ]]
    then
    difficulty=1
    elif [[ $option == "2" ]]
    then
    difficulty=1.5
 
    elif [[ $option == "3" ]]
    then
    difficulty=2

    fi
 
}

startOption() {
    echo "1: New Game"
    echo "2: Quit"
    read option
    clear 
    if [[ $option == "1" ]]
    then
    ChoseDifficulty
    elif [[ $# -eq 0 ]] || [[ $1 -eq 2 ]]
    then
    echo "See you soon"
    exit 1
    fi
    
    
}



chooseHowManyCombats() {

    echo "combien de combats ?"
    echo "1: 10"
    echo "2: 20"
    echo "3: 50"
    echo "4: 100"
    read option

    if [[ $option == '1' ]]
    then
    etage=10
    elif [[ $option == '2' ]]
    then
    etage=20
    elif [[ $option == '3' ]]
    then
    etage=50
    elif [[ $option == '4' ]]
    then
    etage=100
    fi
}

playerCoins() {
    coinsStart=$(($coinsStart+1))
}
clear







