#!/usr/bin/env bash

get_windows() {
  aerospace list-windows --workspace $1 --json | jq --raw-output '.[] | "\(."app-name").\(."window-id")"'
}

sid=$1

# remove existing windows for this space
# sketchybar --remove "/space\.$sid\..*/"

# for app in $(get_windows $sid); do
#   app_name=$(echo $app | cut -d"." -f1)
#   item_id="space.$sid.apps.$app"
#
#   sketchybar --add item $item_id left \
#     --subscribe $item_id space_windows_change \
#     --set $item_id \
#     background.drawing=off \
#     icon.color=$TRANSPARENT_WHITE \
#     icon.font="sketchybar-app-font:Regular:15.0" \
#     icon="$($CONFIG_DIR/plugins/icon_map_fn.sh "$app_name")" \
#     icon.padding_left=5 \
#     icon.padding_right=5 \
#     label.drawing=off \
#     drawing=off \
#     click_script="aerospace workspace $sid" \
#     script="$CONFIG_DIR/plugins/aerospace_apps.sh $sid" # icon.font="sketchybar-app-font:Regular:15.0" \
#
#   # move item to final location
#   sketchybar --move $item_id after "space.$sid" \
#     --set $item_id drawing=on
# done
