#!/usr/bin/env bash

echo "Received event for $1 with to: $FOCUSED_WORKSPACE from $SENDER with $INFO"

TMP_STATE_FILE=$2

load_state_file() {
  sid=$1
  PREVIOUS_COUNT=$(grep "^${sid}:" "$TMP_STATE_FILE" | cut -d":" -f2)
  PREVIOUS_COUNT=${PREVIOUS_COUNT:-0}
}

update_state_file() {
  sid=$1
  count=$2

  if grep -q "^${sid}:" "$TMP_STATE_FILE"; then
    sed -i '' "s/^${sid}:.*/${sid}:${count}/" "$TMP_STATE_FILE"
  else
    echo "${sid}:${count}" >>"$TMP_STATE_FILE"
  fi
}

if [ "$FOCUSED_WORKSPACE" != "" ]; then
  # decide if workspace needs to be highlighted
  if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
  else
    sketchybar --set $NAME background.drawing=off
  fi
fi

# load previous counts in $PREVIOUS_COUNT
load_state_file $1

count=$(aerospace list-windows --workspace "$1" --count)
if [ $count -ne 0 ]; then
  sketchybar --set space.$1 drawing=on

  # if number of windows decreased, clear and redraw
  if [ $PREVIOUS_COUNT -gt $count ]; then
    echo "Deleting for $1"
    $CONFIG_DIR/plugins/aerospace_apps.sh off $1 || true
    echo "Done deleting for $1"
  fi

  # if the number increased, draw
  $CONFIG_DIR/plugins/aerospace_apps.sh on $1 || true
else
  sketchybar --set space.$1 drawing=off

  # clear only if count decreased
  if [ $PREVIOUS_COUNT -gt $count ]; then
    $CONFIG_DIR/plugins/aerospace_apps.sh off $1 || true
  fi
fi

# update current counts to file
update_state_file $1 $count

if [ "$FOCUSED_WORKSPACE" != "" ]; then
  # decide if workspace needs to be highlighted
  if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
  else
    sketchybar --set $NAME background.drawing=off
  fi
fi
