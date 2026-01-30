#!/bin/bash
# ~/.config/waybar/scripts/todo_done.sh

TODO_FILE="$HOME/Workspace/Journal/todo.txt"
LINE_TRACKER="/tmp/waybar_todo_line"

if [[ -f "$LINE_TRACKER" ]]; then
    line_num=$(cat "$LINE_TRACKER")
    
    # If line_num is 0 or empty, do nothing
    [[ -z "$line_num" || "$line_num" -eq 0 ]] && exit 0

    # Specifically target that line number and change [ ] to [x]
    sed -i "${line_num}s/\[ \]/\[x\]/" "$TODO_FILE"
fi

# Reset index to avoid skipping
echo 0 > "/tmp/waybar_todo_index"

# Signal Waybar to refresh
pkill -RTMIN+1 waybar
