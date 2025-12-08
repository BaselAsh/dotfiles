#!/bin/bash

# Configuration
INTERFACE="wlp2s0" # <--- **CHANGE THIS** to your primary network interface (e.g., wlan0, eth0, enp0s3)
INTERVAL=1 # Wait time in seconds for speed calculation
UNIT="B/s" # Initial unit

# Get the network interface name. Since you're on a Toshiba with a physical Ethernet port (i5-3210m), 
# the name is likely 'enp0s25' or 'wlp2s0' for Wi-Fi.
# You can find the correct name by running 'ip a' in your terminal.
# I'll use 'wlp2s0' as a common wireless name for the example.

# ---

# Function to read bytes from the kernel file
get_bytes() {
    cat /sys/class/net/$INTERFACE/statistics/$1_bytes
}

# Initial readings
RX_START=$(get_bytes rx)
TX_START=$(get_bytes tx)

sleep $INTERVAL

# Final readings
RX_END=$(get_bytes rx)
TX_END=$(get_bytes tx)

# Calculate speed in bytes per second
RX_SPEED=$(( (RX_END - RX_START) / INTERVAL ))
TX_SPEED=$(( (TX_END - TX_START) / INTERVAL ))

# Function to convert bytes/s to a human-readable format (KB/s, MB/s)
convert_to_human_readable() {
    local bytes=$1
    local unit="B/s"

    if (( $bytes >= 1048576 )); then
        # Convert to MB/s
        printf "%.1f" "$(( $bytes / 1048576 ))"
        unit="MB/s"
    elif (( $bytes >= 1024 )); then
        # Convert to KB/s
        printf "%.0f" "$(( $bytes / 1024 ))"
        unit="KB/s"
    else
        # Less than 1 KB/s, use B/s
        printf "%d" "$bytes"
        unit="B/s"
    fi

    echo "$unit"
}

# Convert and print
RX_HUMAN_READABLE=$(convert_to_human_readable $RX_SPEED | awk '{print $1}')
RX_UNIT=$(convert_to_human_readable $RX_SPEED | awk '{print $2}')
TX_HUMAN_READABLE=$(convert_to_human_readable $TX_SPEED | awk '{print $1}')
TX_UNIT=$(convert_to_human_readable $TX_SPEED | awk '{print $2}')

# Output the result for waybar (Down 󰇚 / Up 󰕒)
# You can change the format to your liking.
# The Down arrow (󰇚) and Up arrow (󰕒) are from a Nerd Font, which I see you are already using.
echo "󰇚 ${RX_HUMAN_READABLE}${RX_UNIT} 󰕒 ${TX_HUMAN_READABLE}${TX_UNIT}"
