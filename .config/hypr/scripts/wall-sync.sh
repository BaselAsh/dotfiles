#!/bin/bash

# Configuration
WP_DIR="/home/baselash/.config/hypr/Wallpapers"

update_wallpaper() {
    local ws=$1
    local monitor=""
    local wallpaper=""

    case $ws in
        1) monitor="LVDS-1"; wallpaper="Arch-Wallpaper.jpg" ;;
        3) monitor="LVDS-1"; wallpaper="Web-Wallpaper.jpg" ;;
        5) monitor="LVDS-1"; wallpaper="Database-Wallpaper.jpg" ;;
        7) monitor="LVDS-1"; wallpaper="Work-Wallpaper.jpg" ;;
        9) monitor="LVDS-1"; wallpaper="Computer-Hardware-Wallpaper.jpg" ;;
        2) monitor="VGA-1";  wallpaper="Coding-Wallpaper.jpg" ;;
        4) monitor="VGA-1";  wallpaper="Server-Wallpaper.jpg" ;;
        6) monitor="VGA-1";  wallpaper="Study-Wallpaper.jpg" ;;
        8) monitor="VGA-1";  wallpaper="Social-Wallpaper.jpg" ;;
        10) monitor="VGA-1"; wallpaper="Audio-Wallpaper.jpg" ;;
    esac

    if [[ -n $wallpaper ]]; then
        hyprctl hyprpaper wallpaper "$monitor,$WP_DIR/$wallpaper"
    fi
}

# Listen to Hyprland's socket
socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    if [[ $line == workspacev2* ]]; then
        # Use awk or cut to extract the ID
        ws_id=$(echo "$line" | cut -d ">" -f 3 | cut -d "," -f 1)
        update_wallpaper "$ws_id"
    fi
done
