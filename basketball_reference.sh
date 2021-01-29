#!/bin/bash
if [ $1 == "-p" ]
then
  if [ $# != 3 ]
  then
    echo "Usage: ./basketball_reference.sh -p firstname lastname"
    exit 0
  fi
  first_name=$2
  last_name=$3
  full_name="$first_name $last_name"
  second_initial="${last_name:0:1}"
  url="https://www.basketball-reference.com/players/${second_initial,}/"
  curl -s $url | awk -v player="$full_name" -F'\"' '$11~player{
    gsub ("*", "");
    gsub ("</strong>","");
    gsub ("</a></th><td class=","");
    gsub (">","");
    printf "%s: https://basketball-reference.com%s\n",$11,$10
  }'
elif [ $1 == "-t" ] 
then
  if [ $# != 2 ]
  then
    echo "Usage: ./basketball_reference.sh -t team"
    exit 0
  fi
  team_name=$2
  url="https://www.basketball-reference.com/teams/"
  curl -s $url | awk -v team="full_table.*$team_name" -F'\"' '$0~team{
    printf "https://basketball-reference.com%s\n",$10
  }'
else
  echo "Fail"
fi
