#!/usr/bin/env bash

wd=~/.dotfiles/imgs


file=/tmp/wpFile
kitty yazi $wd --chooser-file $file
img=$(cat $file)

# img=$(find ~/.dotfiles/imgs -type f | wofi -d)

echo "$img" >> /tmp/txt

wal -qsi "$img"

cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/
cp "$img" ~/.cache/wallpaper

swww img "$img" --transition-step 5 -t wave
 
pkill waybar; waybar &
kitty @ action load_config_file
