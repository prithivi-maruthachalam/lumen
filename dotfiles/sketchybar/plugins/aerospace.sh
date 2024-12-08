#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on
else
  sketchybar --set $NAME background.drawing=off
fi

# decide display based on window count
count=$(aerospace list-windows --workspace "$1" --count)
if [ $count -ne 0 ]; then
  sketchybar --set space.$1 drawing=on
else
  sketchybar --set space.$1 drawing=off
fi
