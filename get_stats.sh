#!/bin/bash
player_url=$1
curl -s $player_url | awk '/id="per_game\.[0-9]+".*data-stat="mp_per_g"/ { gsub(/<[^>]*>/," "); gsub(/ +/,"|"); print $0 }'
