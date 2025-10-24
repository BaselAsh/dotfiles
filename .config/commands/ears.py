#!/usr/bin/env python3
import subprocess
import time

# --- CONFIGURATION ---
DEVICE_MAC = "98:34:8C:03:AA:D7"  # Your earbud's specific MAC address
# ---------------------


def send_notification(title, message, icon=""):
    """Sends a desktop notification."""
    try:
        subprocess.run(
            ["notify-send", title, message, "-i", icon, "-t", "3000"], check=True
        )
    except FileNotFoundError:
        print("Note: 'notify-send' is not installed. Skipping notification.")


def connect_device(mac_address):
    """Tries to connect to the given MAC address using bluetoothctl."""

    # We send a notification to show it's trying
    send_notification(
        "Earbuds", f"Attempting to connect to {mac_address}...", "bluetooth"
    )

    try:
        proc = subprocess.Popen(
            ["bluetoothctl"],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True,
        )

        commands = f"power on\nconnect {mac_address}\nquit\n"

        # We set a timeout, as the connect command can hang
        stdout, stderr = proc.communicate(commands, timeout=15)
        time.sleep(3)

        if "Connection successful" in stdout:
            print("Successfully connected!")
            send_notification(
                "Earbuds Connected",
                "Connection successful.",
                "audio-headphones",  # A nice headphone icon
            )
        elif "Failed to connect" in stdout:
            print("Failed to connect.")
            send_notification(
                "Earbud Error",
                "Failed to connect. Make sure device is on.",
                "dialog-error",
            )
        else:
            print("Unknown status.")
            send_notification(
                "Earbud Status", "Connection attempt finished.", "dialog-information"
            )

    except subprocess.TimeoutExpired:
        time.sleep(2)
        print("Connection timed out.")
        send_notification("Earbud Error", "Connection timed out.", "dialog-error")
    except Exception as e:
        time.sleep(2)
        print(f"An error occurred: {e}")
        send_notification("Script Error", str(e), "dialog-error")


if __name__ == "__main__":
    connect_device(DEVICE_MAC)
