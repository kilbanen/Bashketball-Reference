#!/bin/bash
player_url=$1
curl -s $player_url | awk '/per_game/ { gsub(/<[^>]*>/," "); gsub(/ +/," "); print $0 }'
