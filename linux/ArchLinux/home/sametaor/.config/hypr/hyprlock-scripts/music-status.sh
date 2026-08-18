#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 --title | --arturl | --artist | --length | --album | --source"
  exit 1
fi

# Function to get metadata using playerctl
get_metadata() {
  key=$1
  playerctl metadata --format "{{ $key }}" 2>/dev/null
}

# Check for arguments

# Function to determine the source and return an icon and text
get_source_info() {
  trackid=$(get_metadata "mpris:trackid")
  if [[ "$trackid" == *"firefox"* ]]; then
    echo -e "󰈹 "
  elif [[ "$trackid" == *"spotify"* ]]; then
    echo -e " "
  elif [[ "$trackid" == *"chromium"* ]]; then
    echo -e " "
  elif [[ "$trackid" == *"browser_integration"* ]]; then
    echo -e " "
  else
    echo "None 󰽳 "
  fi
}

# Parse the argument
case "$1" in
--title)
  title=$(get_metadata "xesam:title")
  if [ -z "$title" ]; then
    echo "󰝛 Unknown song"
  else
    echo "󰽰 ${title:0:30}" # Limit the output to 50 characters
  fi
  ;;
--arturl)
  url=$(get_metadata "mpris:artUrl")
  if [ -z "$url" ]; then
    echo ""
  else
    if [[ "$url" == file://* ]]; then
      url=${url#file://}
    fi
    echo "$url"
  fi
  ;;
--artist)
  artist=$(get_metadata "xesam:artist")
  if [ -z "$artist" ]; then
    echo "󰳩 Unknown artist"
  else
    echo "󰠃 ${artist:0:30}" # Limit the output to 50 characters
  fi
  ;;
--length)
  length=$(get_metadata "mpris:length")
  if [ -z "$length" ]; then
    echo "0.0"
  else
    # Convert length from microseconds to a more readable format (seconds)
    echo "scale=2; $length / 1000000 / 60" | bc
  fi
  ;;
--status)
  status=$(playerctl status 2>/dev/null)
  if [[ $status == "Playing" ]]; then
    echo "󰎆 "
  elif [[ $status == "Paused" ]]; then
    echo "󱑽 "
  else
    echo "󰫔 "
  fi
  ;;
--album)
  album=$(playerctl metadata --format "{{ xesam:album }}" 2>/dev/null)
  if [[ -n $album ]]; then
    echo "󰀥  ${album:0:30}"
  else
    status=$(playerctl status 2>/dev/null)
    if [[ -n $status ]]; then
      echo "󰀥 Unknown album"
    else
      echo "󰀥 Unknown album"
    fi
  fi
  ;;
--source)
  get_source_info
  ;;
*)
  echo "Invalid option: $1"
  echo "Usage: $0 --title | --url | --artist | --length | --album | --source"
  exit 1
  ;;
esac
