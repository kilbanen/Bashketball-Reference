#!/bin/bash
player_url=$1
curl -s $player_url | awk '/id="per_game\.[0-9]+".*data-stat="mp_per_g"/ { gsub(/<[^>]*>/," "); gsub(/ +/,"|"); print "Season|Age|Tm|Lg|Pos|G|GS|MP|FG|FGA|FG%|3P|3PA|2P|2P%|eFG%|FT|FTA|FT%|ORB|DRB|TRB|AST|STL|BLK|TOV|PF|PTS"; print $0 }'
