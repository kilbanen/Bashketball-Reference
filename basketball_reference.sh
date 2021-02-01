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
    return_string="%s: https://basketball-reference.com%s\n"
  else
    echo "Usage: -p firstname lastname"
    exit 0
  fi
elif [ $# -ge 2 ] && [ $1 == "-t" ]
then
  team_name=$2
  url="https://www.basketball-reference.com/teams/"
  search_pattern="full_table.*$team_name"
  if [ $# == 2 ]
  then
    return_string="%s: https://basketball-reference.com%s\n"
  elif [ $# == 3 ]
  then
    year=$3
    return_string="%s: https://basketball-reference.com%s$year.html\n"
  else
    echo "Usage: -t team year"
    exit 0
  fi
else
  echo "Invalid input"
  exit 0
fi
curl -s $url | awk -v pattern="$search_pattern" -v ret="$return_string" -F'\"' '$0~pattern{
  gsub ("*", "");
  gsub ("</strong>","");
  gsub ("</a></th><td class=","");
  gsub (">","");
  printf ret,$11,$10
}'
