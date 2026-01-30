#!/bin/bash
# ~/.config/waybar/scripts/todo.sh

TODO_FILE="$HOME/Workspace/Journal/todo.txt"
INDEX_FILE="/tmp/waybar_todo_index"
LINE_TRACKER="/tmp/waybar_todo_line"

[[ ! -f "$INDEX_FILE" ]] && echo 0 > "$INDEX_FILE"

if [[ -f "$TODO_FILE" ]]; then
    # Get pending tasks and their original line numbers
    mapfile -t tasks < <(grep -n "\[ \]" "$TODO_FILE")
    line_count=${#tasks[@]}

    if [[ $line_count -eq 0 ]]; then
        echo "Done! ✅"
        echo "0" > "$LINE_TRACKER"
    else
        index=$(cat "$INDEX_FILE")
        [[ $index -ge $line_count ]] && index=0
        
        # Extract the line number and the task text
        current_entry="${tasks[$index]}"
        line_num=$(echo "$current_entry" | cut -d: -f1)
        task_text=$(echo "$current_entry" | cut -d: -f2-)
        
        # Save the line number for the finisher script
        echo "$line_num" > "$LINE_TRACKER"
        echo "$task_text"
        
        # Increment index
        echo "$(( (index + 1) % line_count ))" > "$INDEX_FILE"
    fi
else
    echo "No file"
fi
