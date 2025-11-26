#!/usr/bin/env dash
#             __ _       _     _            _              _   _
#  _ __ ___  / _(_)     | |__ | |_   _  ___| |_ ___   ___ | |_| |__
# | '__/ _ \| |_| |_____| '_ \| | | | |/ _ \ __/ _ \ / _ \| __| '_ \
# | | | (_) |  _| |_____| |_) | | |_| |  __/ || (_) | (_) | |_| | | |
# |_|  \___/|_| |_|     |_.__/|_|\__,_|\___|\__\___/ \___/ \__|_| |_|
#
# Author: Nick Clyde (clydedroid)
#
# A script that generates a rofi/fuzzel menu that uses bluetoothctl to
# connect to bluetooth devices and display status info.
#
# Inspired by networkmanager-dmenu (https://github.com/firecat53/networkmanager-dmenu)
# Thanks to x70b1 (https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-bluetooth-bluetoothctl)
#
# Depends on:
#   rofi/fuzzel, bluez-utils (contains bluetoothctl), bc (for version check)

# Constants
divider="---------"
goback="Back"

# Cache for bluetoothctl show output to avoid repeated calls
_bt_show_cache=""

# Get cached bluetoothctl show output (refreshes if empty)
get_bt_show() {
    if [ -z "$_bt_show_cache" ]; then
        _bt_show_cache=$(bluetoothctl show)
    fi
    printf '%s' "$_bt_show_cache"
}

# Clear the cache (call when state changes)
clear_bt_cache() {
    _bt_show_cache=""
}

# Checks if bluetooth controller is powered on
power_on() {
    if get_bt_show | grep -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles power state
toggle_power() {
    if power_on; then
        bluetoothctl power off
        clear_bt_cache
        show_menu
    else
        if rfkill list bluetooth | grep -q 'blocked: yes'; then
            rfkill unblock bluetooth && sleep 3
        fi
        bluetoothctl power on
        clear_bt_cache
        show_menu
    fi
}

# Checks if controller is scanning for new devices
scan_on() {
    if get_bt_show | grep -q "Discovering: yes"; then
        echo "Scan: on"
        return 0
    else
        echo "Scan: off"
        return 1
    fi
}

# Toggles scanning state
toggle_scan() {
    if scan_on; then
        # 'scan off' is sufficient to stop the background scan process
        bluetoothctl scan off
        clear_bt_cache
        show_menu
    else
        bluetoothctl scan on &
        echo "Scanning..."
        sleep 5
        clear_bt_cache
        show_menu
    fi
}

# Checks if controller is able to pair to devices
pairable_on() {
    if get_bt_show | grep -q "Pairable: yes"; then
        echo "Pairable: on"
        return 0
    else
        echo "Pairable: off"
        return 1
    fi
}

# Toggles pairable state
toggle_pairable() {
    if pairable_on; then
        bluetoothctl pairable off
        clear_bt_cache
        show_menu
    else
        bluetoothctl pairable on
        clear_bt_cache
        show_menu
    fi
}

# Checks if controller is discoverable by other devices
discoverable_on() {
    if get_bt_show | grep -q "Discoverable: yes"; then
        echo "Discoverable: on"
        return 0
    else
        echo "Discoverable: off"
        return 1
    fi
}

# Toggles discoverable state
toggle_discoverable() {
    if discoverable_on; then
        bluetoothctl discoverable off
        clear_bt_cache
        show_menu
    else
        bluetoothctl discoverable on
        clear_bt_cache
        show_menu
    fi
}

# Get device info (uses cache if available for same MAC)
_device_info_cache=""
_device_info_mac=""

get_device_info() {
    if [ "$_device_info_mac" != "$1" ] || [ -z "$_device_info_cache" ]; then
        _device_info_mac="$1"
        _device_info_cache=$(bluetoothctl info "$1")
    fi
    printf '%s' "$_device_info_cache"
}

clear_device_cache() {
    _device_info_cache=""
    _device_info_mac=""
}

# Checks if a device is connected
device_connected() {
    if get_device_info "$1" | grep -q "Connected: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles device connection
toggle_connection() {
    if device_connected "$1"; then
        bluetoothctl disconnect "$1"
        clear_device_cache
        device_menu "$device"
    else
        bluetoothctl connect "$1"
        clear_device_cache
        device_menu "$device"
    fi
}

# Checks if a device is paired
device_paired() {
    if get_device_info "$1" | grep -q "Paired: yes"; then
        echo "Paired: yes"
        return 0
    else
        echo "Paired: no"
        return 1
    fi
}

# Toggles device paired state
toggle_paired() {
    if device_paired "$1"; then
        bluetoothctl remove "$1"
        clear_device_cache
        device_menu "$device"
    else
        bluetoothctl pair "$1"
        clear_device_cache
        device_menu "$device"
    fi
}

# Checks if a device is trusted
device_trusted() {
    if get_device_info "$1" | grep -q "Trusted: yes"; then
        echo "Trusted: yes"
        return 0
    else
        echo "Trusted: no"
        return 1
    fi
}

# Toggles device trust state
toggle_trust() {
    if device_trusted "$1"; then
        bluetoothctl untrust "$1"
        clear_device_cache
        device_menu "$device"
    else
        bluetoothctl trust "$1"
        clear_device_cache
        device_menu "$device"
    fi
}

# Prints a short string with the current bluetooth status
# Useful for status bars like polybar, etc.
print_status() {
    if ! power_on; then
        printf '\n'
        return
    fi

    printf ''

    paired_devices_cmd="devices Paired"
    # Check if an outdated version of bluetoothctl is used
    # Requires `bc` for floating point comparison
    if [ "$(echo "$(bluetoothctl version | cut -d ' ' -f 2) < 5.65" | bc -l)" = "1" ]; then
        paired_devices_cmd="paired-devices"
    fi

    # Get list of paired MAC addresses
    paired_macs=$(bluetoothctl $paired_devices_cmd | grep Device | cut -d ' ' -f 2)

    connected_list=""
    # Loop through MACs and build a list of connected device aliases
    for mac in $paired_macs; do
        # Use cached device info - reuse result from device_connected check
        clear_device_cache
        if device_connected "$mac"; then
            device_alias=$(get_device_info "$mac" | grep "Alias" | cut -d ' ' -f 2-)
            if [ -z "$connected_list" ]; then
                connected_list=" $device_alias"
            else
                connected_list="$connected_list, $device_alias"
            fi
        fi
    done

    printf '%s\n' "$connected_list"
}


# A submenu for a specific device that allows connecting, pairing, and trusting
device_menu() {
    device=$1

    # Get device name and mac address
    device_name=$(echo "$device" | cut -d ' ' -f 3-)
    mac=$(echo "$device" | cut -d ' ' -f 2)

    # Build options
    if device_connected "$mac"; then
        connected="Connected: yes"
    else
        connected="Connected: no"
    fi
    paired=$(device_paired "$mac")
    trusted=$(device_trusted "$mac")

    # Pipe options to dmenu
    chosen=$(printf '%s\n' "$connected" "$paired" "$trusted" "$divider" "$goback" "Exit" | $rofi_command "$device_name")

    # Match chosen option to command
    case "$chosen" in
        "" | "$divider")
            echo "No option chosen."
            ;;
        "$connected")
            toggle_connection "$mac"
            ;;
        "$paired")
            toggle_paired "$mac"
            ;;
        "$trusted")
            toggle_trust "$mac"
            ;;
        "$goback")
            show_menu
            ;;
    esac
}

# Opens a rofi/fuzzel menu with current bluetooth status and options to connect
show_menu() {
    # Get menu options
    if power_on; then
        power="Power: on"
        devices=$(bluetoothctl devices | grep Device | cut -d ' ' -f 3-)
        scan=$(scan_on)
        pairable=$(pairable_on)
        discoverable=$(discoverable_on)

        # Pipe the options to dmenu
        chosen=$( (
            # Print devices only if the string is not empty
            if [ -n "$devices" ]; then
                printf '%s\n' "$devices"
            fi
            printf '%s\n' "$divider" "$power" "$scan" "$pairable" "$discoverable" "Exit"
        ) | $rofi_command "Bluetooth")
    else
        power="Power: off"
        chosen=$(printf '%s\n%s\n' "$power" "Exit" | $rofi_command "Bluetooth")
    fi

    # Match chosen option to command
    case "$chosen" in
        "" | "$divider")
            echo "No option chosen."
            ;;
        "$power")
            toggle_power
            ;;
        "$scan")
            toggle_scan
            ;;
        "$discoverable")
            toggle_discoverable
            ;;
        "$pairable")
            toggle_pairable
            ;;
        *)
            device=$(bluetoothctl devices | grep "$chosen")
            # Open a submenu if a device is selected (and not empty)
            if [ -n "$device" ]; then device_menu "$device"; fi
            ;;
    esac
}

# Dmenu command to pipe into, can add any options here
# Using "$@" is more robust than "$*" for passing arguments.
rofi_command="fuzzel --dmenu $@"

case "$1" in
    --status)
        print_status
        ;;
    *)
        show_menu
        ;;
esac
