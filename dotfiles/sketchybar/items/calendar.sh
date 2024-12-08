#!/bin/sh

sketchybar --add item clock right \
  --set clock update_freq=10 \
  icon= \
  label="$(date '+%a %d/%m %H:%M')"
