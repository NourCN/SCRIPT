#!/bin/bash

echo -e ${blue}

first_line=0
rt=0
fichier=$1

r=$[ RANDOM % 100 +1 ]
if [[ $r < 50 ]]; then
    rt=1
    elif [[ $r < 80 ]]; then
    rt=2
    elif [[ $r < 95 ]]; then
    rt=3
    elif [[ $r < 99 ]];then
    rt=4
else
    rt=5
fi

#determiner same rarity
count=0
while IFS="," read -r ID NAME HP MP STR INT DEF RES SPD LUCK RACE CLASS RARITY
do
    if [[ $first_line -ne 0 ]] && [[ $RARITY -eq $rt ]]; then
        count=$(($count+1))
#        echo $name $rarity
    fi
    first_line=1
done < $fichier

r2=$[ RANDOM % $count +1 ]

count2=0
first_line=O
while IFS="," read -r ID NAME HP MP STR INT DEF RES SPD LUCK RACE CLASS RARITY
do
    if [[ $first_line -ne 0 ]] && [[ $RARITY -eq $rt ]]; then
    count2=$(($count2+1))
     if [[ $count2 -eq $r2 ]]; then
#       echo "ID : $ID"
         id=$ID
         name=$NAME
         hp=$HP
         mp=$MP
         str=$STR
         int=$INT
         def=$DEF
         res=$RES
         spd=$SPD
         luck=$LUCK
         race=$RACE
         class=$CLASS
         rarity=$RARITY
      fi
    fi
    first_line=1
done < $fichier

echo -e ${no}