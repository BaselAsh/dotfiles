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


def disconnect_device(mac_address):
    """Tries to disconnect from the given MAC address using bluetoothctl."""

    send_notification(
        "Earbuds",
        f"Attempting to disconnect from {mac_address}...",
        "bluetooth-disabled",  # Using a different icon
    )

    try:
        proc = subprocess.Popen(
            ["bluetoothctl"],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True,
        )

        # Use the 'disconnect' command
        commands = f"disconnect {mac_address}\nquit\n"

        stdout, stderr = proc.communicate(commands, timeout=10)
        time.sleep(2)

        # Check for the different success/failure messages
        if "Successful disconnected" in stdout:
            print("Successfully disconnected!")
            send_notification(
                "Earbuds Disconnected",
                "Disconnection successful.",
                "audio-headphones",  # Or maybe bluetooth-disabled
            )
        elif "Failed to disconnect" in stdout:
            print("Failed to disconnect.")
            send_notification("Earbud Error", "Failed to disconnect.", "dialog-error")
        elif "Device not connected" in stdout:
            print("Device was not connected.")
            send_notification(
                "Earbuds", "Device was already disconnected.", "dialog-information"
            )
        else:
            print("Unknown status.")
            send_notification(
                "Earbud Status", "Disconnect attempt finished.", "dialog-information"
            )

    except subprocess.TimeoutExpired:
        print("Disconnect process timed out.")
        send_notification(
            "Earbud Error", "Disconnect process timed out.", "dialog-error"
        )
    except Exception as e:
        print(f"An error occurred: {e}")
        send_notification("Script Error", str(e), "dialog-error")


if __name__ == "__main__":
    disconnect_device(DEVICE_MAC)
