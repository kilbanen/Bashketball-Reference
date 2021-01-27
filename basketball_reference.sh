#!/bin/bash
curl -s https://www.basketball-reference.com/players/a/ | awk -F'\"' '/Kareem/ {printf "https://basketball-reference.com%s\n",$10}'
