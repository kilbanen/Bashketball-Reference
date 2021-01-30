#!/bin/bash
[ -z "$1" ] && echo "Not enough arguments" && exit 0 ||
[ $1 == "-p" ] && [ $# == 3 ] &&
  first_name=$2 &&
  last_name=$3 &&
  full_name="$first_name $last_name" &&
  second_initial="${last_name:0:1}" &&
  url="https://www.basketball-reference.com/players/${second_initial,}/" &&
  curl -s $url | awk -v player="$full_name" -F'\"' '$11~player{
    gsub ("*", "");
    gsub ("</strong>","");
    gsub ("</a></th><td class=","");
    gsub (">","");
    printf "%s: https://basketball-reference.com%s\n",$11,$10
  }' &&
  exit 0 ||
[ $1 == "-p" ] && echo "Usage: -p firstname lastname" && exit 0 ||
[ $1 == "-t" ] && [ $# == 2 ] &&
  team_name=$2 &&
  url="https://www.basketball-reference.com/teams/" &&
  curl -s $url | awk -v team="full_table.*$team_name" -F'\"' '$0~team{
    gsub ("*", "");
    gsub ("</strong>","");
    gsub ("</a></th><td class=","");
    gsub (">","");
    printf "%s: https://basketball-reference.com%s\n",$11,$10
  }' &&
  exit 0 ||
[ $1 == "-t" ] && echo "Usage: -t team" && exit 0
