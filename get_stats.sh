#!/bin/bash
player_url=$1
row_template='|%6s|%3s|%3s|%3s|%3s|%2s|%2s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%3s|%3s|%4s|%3s|%4s|\n'
  echo "| Season|Age| Tm| Lg|Pos| G|GS|  MP|  FG| FGA| FG%|  3P| 3PA| 3P%|  2P| 2PA| 2P%|eFG%|  FT| FTA| FT%| ORB| DRB| TRB| AST|STL|BLK| TOV| PF| PTS|";
curl -s $player_url | awk -F" " '/id="per_game\.[0-9]+".*data-stat="mp_per_g"/ {
  gsub(/<tr/,"\n<tr");
  gsub(/<thead>.*<\/thead>/,"");
  gsub(/<[^>]*>/," ");
  printf($0)
}' | awk '/-/ {
  printf("|%6s|%3s|%3s|%3s|%3s|%2s|%2s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%4s|%3s|%3s|%4s|%3s|%4s|\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30)
}'
