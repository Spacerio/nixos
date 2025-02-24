#!/usr/bin/env bash

img=$(find ~/.dotfiles/imgs -type f | wofi -d)

echo "$img"

wal -qsi "$img"

cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/

swww img "$img"
 
pkill waybar; waybar &

