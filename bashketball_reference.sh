#!/bin/bash
get_player()
{
    first_name=$1
    last_name=$2
    full_name="$first_name $last_name"
    second_initial="${last_name:0:1}"
    url="https://www.basketball-reference.com/players/${second_initial,}/"
    search_pattern="tr.*$full_name"
    return_string="https://www.basketball-reference.com%s\n"
    player_url=$(curl -s $url | awk -v pattern="$search_pattern" -v ret="$return_string" -F'\"' '$0~pattern{
      gsub ("*", "");
      gsub ("</strong>","");
      gsub ("</a></th><td class=","");
      gsub (">","");
      printf ret,$10
    }')
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
}

get_team()
{
  team_name=$1
  url="https://www.basketball-reference.com/teams/"
  search_pattern="full_table.*$team_name"
  return_string="https://www.basketball-reference.com%s$year.html\n"
  team_url=$(curl -s $url | awk -v pattern="$search_pattern" -v ret="$return_string" -F'\"' '$0~pattern{
    gsub ("*", "");
    gsub ("</strong>","");
    gsub ("</a></th><td class=","");
    gsub (">","");
    printf ret,$10
  }')
  echo "$team_url"
}

if [ $1 == "player" ] 
then
  if [ $# == 3 ]
  then
    first_name=$2
    last_name=$3
    get_player $first_name $last_name
  else
    echo "Usage: player firstname lastname"
    exit 0
  fi
elif [ $1 == "team" ]
then
  if [ $# == 3 ]
  then
    team_name=$2
    year=$3
    get_team $team_name $year
  else
    echo "Usage: team teamname year"
    exit 0
  fi
else
  echo "Invalid input"
  exit 0
fi
