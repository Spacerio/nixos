#!/usr/bin/env bash

img=$(find ~/.dotfiles/imgs -type f | wofi -d)

echo "$img"

wal -qi "$img"

cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/

cp "$img" ~/.cache/wallpaper

swww img "$img"
 
pkill waybar; waybar &
