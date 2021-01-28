#!/bin/bash
first_name=$1
last_name=$2
full_name="$first_name $last_name"
second_initial="${last_name:0:1}"
url="https://www.basketball-reference.com/players/${second_initial,}/"
curl -s $url | awk -v player="$full_name" -F'\"' '$11~player{ gsub ("*", ""); gsub ("</strong>",""); gsub ("</a></th><td class=",""); gsub (">",""); printf "%s: https://basketball-reference.com%s\n",$11,$10}'
