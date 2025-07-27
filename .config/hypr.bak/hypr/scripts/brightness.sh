#!/usr/bin/env bash

iDIR="$HOME/.config/dunst/icons"
step=10

# Get internal display brightness
get_internal_backlight() {
  brightnessctl -m | cut -d, -f4 | sed 's/%//'
}

# Set internal display brightness
set_internal_backlight() {
  brightnessctl set "$1%"
}

# Get brightness level of an external monitor
get_monitor_backlight() {
  ddcutil --display "$1" getvcp 10 2>/dev/null |
    awk -F 'value =' '/current value/ { gsub(",", "", $2); print $2 }' | awk '{print $1}'
}

# Set brightness level of an external monitor
set_monitor_backlight() {
  ddcutil --display "$1" setvcp 10 "$2" >/dev/null
}

# Choose an icon based on brightness level
get_icon() {
  local level=$1
  if [ "$level" -le 20 ]; then
    echo "$iDIR/brightness-20.png"
  elif [ "$level" -le 40 ]; then
    echo "$iDIR/brightness-40.png"
  elif [ "$level" -le 60 ]; then
    echo "$iDIR/brightness-60.png"
  elif [ "$level" -le 80 ]; then
    echo "$iDIR/brightness-80.png"
  else
    echo "$iDIR/brightness-100.png"
  fi
}

# Send notification about brightness change
notify_user() {
  local level=$1
  local icon=$2
  notify-send -e -h string:x-canonical-private-synchronous:brightness_notif \
    -h int:value:$level -u low -i "$icon" "Brightness: $level%"
}

# Adjust brightness up or down, keeping it between 5 and 100
adjust_brightness() {
  local current=$1
  local mode=$2
  local new

  if [[ "$mode" == "+${step}%" ]]; then
    new=$((current + step))
  elif [[ "$mode" == "${step}%-" ]]; then
    new=$((current - step))
  else
    return 1
  fi

  ((new < 5)) && new=5
  ((new > 100)) && new=100

  echo "$new"
}

# Loop monitors
loop_monitors() {
  local total_no_of_external_monitors=$(hyprctl monitors -j | jq '. | length') # Expecting all modern monitors DDC supported.
  local action=$1
  local value=$2

  for ((id = 1; id <= total_no_of_external_monitors; id++)); do
    case "$action" in
    "get")
      echo "Monitor $id: $(get_monitor_backlight "$id")"
      ;;
    "set")
      set_monitor_backlight "$id" "$value"
      notify_user "$value" "$(get_icon "$value")"
      ;;
    "adjust")
      current=$(get_monitor_backlight "$id")
      new=$(adjust_brightness "$current" "$value")
      set_monitor_backlight "$id" "$new"
      notify_user "$new" "$(get_icon "$new")"
      ;;
    esac
  done
}

# Entry point
case "$1" in
"--get")
  get_internal_backlight
  ;;

"--inc")
  current=$(get_internal_backlight)
  new=$(adjust_brightness "$current" "+${step}%")
  set_internal_backlight "$new"
  notify_user "$new" "$(get_icon "$new")"
  ;;

"--dec")
  current=$(get_internal_backlight)
  new=$(adjust_brightness "$current" "${step}%-")
  set_internal_backlight "$new"
  notify_user "$new" "$(get_icon "$new")"
  ;;

"--low")
  set_internal_backlight 5
  notify_user 5 "$(get_icon 5)"
  ;;

"--high")
  set_internal_backlight 100
  notify_user 100 "$(get_icon 100)"
  ;;

"--mon-get")
  loop_monitors "get"
  ;;

"--mon-inc")
  loop_monitors "adjust" "+${step}%"
  ;;

"--mon-dec")
  loop_monitors "adjust" "${step}%-"
  ;;

"--mon-low")
  loop_monitors "set" 5
  ;;

"--mon-high")
  loop_monitors "set" 100
  ;;

*)
  echo "Usage: $0 [--get|--inc|--dec|--low|--high|--mon-get|--mon-inc|--mon-dec|--mon-low|--mon-high]"
  ;;
esac
