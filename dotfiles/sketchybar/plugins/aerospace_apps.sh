#!/usr/bin/env bash

get_windows() {
  aerospace list-windows --workspace $1 --json | jq --raw-output '.[] | "\(."app-name").\(."window-id")"'
}

clear_space_apps() {
  sid=$1
  space_status=$(sketchybar --query space.$sid | jq -r '.geometry.drawing')
  if [ $? -eq 1 ]; then
    exit 0
  fi

  sketchybar --remove "/space\.$sid\..*/"
}

show_space_apps() {
  sid=$1

  IFS=$'\n'
  for app in $(get_windows $sid); do
    app_name=$(echo $app | cut -d"." -f1 | tr " " "_")
    item_id="space.$sid.apps.$app"

    sketchybar --query $item_id &>/dev/null
    if [ $? -ne 0 ]; then
      sketchybar \
        --add item $item_id left \
        --set $item_id \
        background.drawing=off \
        icon.color=0x44ffffff \
        icon.font="sketchybar-app-font:Regular:15.0" \
        icon="$($CONFIG_DIR/plugins/icon_map_fn.sh $app_name)" \
        icon.padding_left=5 \
        icon.padding_right=5 \
        label.drawing=off \
        drawing=on \
        --move $item_id after "space.$sid"
    fi
  done
  unset IFS
}

action=$1
sid=$2

if [ "$action" == "off" ]; then
  clear_space_apps $sid || true
else
  show_space_apps $sid || true
fi
