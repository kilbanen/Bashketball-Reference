#!/bin/bash
curl -s https://www.basketball-reference.com/players/a/ | awk -v player="$1" -F'\"' '$0~player{printf "https://basketball-reference.com%s\n",$10}'
