#!/usr/bin/env bash

# listen to aerospace events
sketchybar --add event aerospace_workspace_change

# add display
for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
    background.color=$TRANSPARENT_WHITE \
    background.corner_radius=5 \
    background.height=20 \
    background.drawing=off \
    icon="$sid" \
    icon.padding_left=5 \
    icon.padding_right=5 \
    label.drawing=off \
    drawing=off \
    click_script="aerospace workspace $sid" \
    script="$CONFIG_DIR/plugins/aerospace.sh $sid"

  # set background based on current active
  if [ "$sid" = "$(aerospace list-workspaces --focused)" ]; then
    sketchybar --set space.$sid background.drawing=on
  fi

  # decide display based on window count
  count=$(aerospace list-windows --workspace "$sid" --count)
  if [ $count -ne 0 ]; then
    sketchybar --set space.$sid drawing=on
  fi
done
