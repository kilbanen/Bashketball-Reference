#!/bin/bash
if [ $# != 0 ] && [ $1 == "-p" ] 
then
  if [ $# == 3 ]
  then
    first_name=$2
    last_name=$3
    full_name="$first_name $last_name"
    second_initial="${last_name:0:1}"
    url="https://www.basketball-reference.com/players/${second_initial,}/"
    search_pattern="tr.*$full_name"
  else
    echo "Usage: -p firstname lastname"
    exit 0
  fi
elif [ $# != 0 ] && [ $1 == "-t" ]
then
  if [ $# == 2 ]
  then
    team_name=$2
    url="https://www.basketball-reference.com/teams/"
    search_pattern="full_table.*$team_name"
  else
    echo "Usage: -t team"
    exit 0
  fi
else
  echo "Invalid input"
  exit 0
fi
curl -s $url | awk -v pattern="$search_pattern" -F'\"' '$0~pattern{
  gsub ("*", "");
  gsub ("</strong>","");
  gsub ("</a></th><td class=","");
  gsub (">","");
  printf "%s: https://basketball-reference.com%s\n",$11,$10
}'
