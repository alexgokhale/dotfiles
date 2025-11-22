#!/bin/bash

player_status=$(playerctl --player=spotify,%any status 2> /dev/null)
artist=$(playerctl --player=spotify,%any metadata artist 2>&1)
artist_code=$?
title=$(playerctl --player=spotify,%any metadata title 2>&1)
title_code=$?

player_string=""

if [ $artist_code = 0 ]; then
    player_string+="${artist} -"
fi

if [ $title_code = 0 ]; then
    player_string+=" ${title}"
fi

if [ "$player_string" = "" ]; then
    player_string=$player_status
fi

if [ "$player_status" = "Playing" ]; then
    echo " $player_string"
elif [ "$player_status" = "Paused" ]; then
    echo " $player_string"
else
    echo ""
fi

