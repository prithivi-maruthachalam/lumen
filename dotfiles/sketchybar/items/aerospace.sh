#!/usr/bin/env bash

# listen to aerospace events
sketchybar --add event aerospace_workspace_change

get_monitors() {
  aerospace list-monitors --json | jq '.[] | ."monitor-id"'
}

get_workspaces() {
  aerospace list-workspaces --monitor $1
}

get_windows() {
    aerospace list-windows --workspace $1 --json | jq --raw-output '.[] | "\(."app-name").\(."window-id")"'
}

# add display
for monitor_id in $(get_monitors); do
  for sid in $(get_workspaces $monitor_id); do
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

    for item_id in $(get_windows $sid); do
      app_name=$(echo $item_id | cut -d"." -f1)

      sketchybar --add item $item_id left \
        --subscribe $item_id aerospace_workspace_change \
        --set $item_id \
        background.drawing=off \
        icon.color=$TRANSPARENT_WHITE \
        icon.font="sketchybar-app-font:Regular:15.0" \
        icon="$($CONFIG_DIR/plugins/icon_map_fn.sh "$app_name")" \
        icon.padding_left=5 \
        icon.padding_right=5 \
        label.drawing=off \
        drawing=on \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid" # icon.font="sketchybar-app-font:Regular:15.0" \
    done

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
  
  # add separator after a workspace
  sketchybar --add item separator.$monitor_id left \
    --set separator.$monitor_id \
    background.drawing=off \
    label.drawing=off \
    icon="|" \
    icon.font="sketchybar-app-font:Regular:15.0" \
    icon.color=$TRANSPARENT_WHITE \
    icon.padding_left=5 \
    icon.padding_right=5 \
    drawing=on

done
