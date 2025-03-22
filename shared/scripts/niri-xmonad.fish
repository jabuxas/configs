#!/usr/bin/fish

# Function to get sorted monitors by their logical x-coordinate
function get_sorted_monitors
    niri msg -j outputs | jq -r 'to_entries | sort_by(.value.logical.x) | .[] | .key'
end

# Function to get the current focused workspace and its associated monitor
function get_focused_workspace_and_monitor
    set workspaces (niri msg -j workspaces)
    set focused_workspace (echo $workspaces | jq -r '.[] | select(.is_focused == true) | {id: .id, output: .output}')
    echo $focused_workspace | jq -r '.output'
end

# Function to get the index of the current monitor in the sorted list
function get_current_monitor_index
    set current_monitor (get_focused_workspace_and_monitor)
    set monitors (get_sorted_monitors)
    contains -i $current_monitor $monitors
end

# Function to move the workspace to a target monitor
function move_workspace_to_monitor
    set target_idx $argv[1]
    set current_idx (get_current_monitor_index)
    if test -z "$current_idx"
        exit 1
    end

    set delta (math $target_idx - $current_idx)
    if test $delta -eq 0
        return
    else if test $delta -lt 0
        for i in (seq 1 (math -1 * $delta))
            niri msg action move-workspace-to-monitor-left
        end
    else
        for i in (seq 1 $delta)
            niri msg action move-workspace-to-monitor-right
        end
    end
end

# Function to focus a monitor by orientation (left, center, right)
function focus_monitor
    set orientation $argv[1]
    switch $orientation
        case left   ; set target_idx 0
        case center ; set target_idx 1
        case right  ; set target_idx 2
        case '*'    ; echo "Invalid orientation"; exit 1
    end

    set monitors (get_sorted_monitors)
    if test (count $monitors) -le $target_idx
        exit
    end
    move_workspace_to_monitor $target_idx
end

# Function to send the current workspace to a target monitor
function send_to_monitor
    set orientation $argv[1]
    switch $orientation
        case left   ; set target_idx 0
        case center ; set target_idx 1
        case right  ; set target_idx 2
        case '*'    ; echo "Invalid orientation"; exit 1
    end

    set monitors (get_sorted_monitors)
    if test (count $monitors) -le $target_idx
        exit
    end

    # Capture current workspace and monitor
    set current_monitor (get_focused_workspace_and_monitor)
    set initial_monitor_idx (get_current_monitor_index)

    # Move workspace to target monitor
    move_workspace_to_monitor $target_idx

    # Restore initial workspace position if needed
    if test (get_current_monitor_index) -ne $initial_monitor_idx
        niri msg action switch-workspace (niri msg -j workspaces | jq -r '.[] | select(.is_focused == true) | .id')
        move_workspace_to_monitor $initial_monitor_idx
    end
end

# Function to switch to a workspace, handling cross-monitor moves
function switch_workspace
    set target_workspace $argv[1]

    # Get current workspace and monitor
    set current_monitor_idx (get_current_monitor_index)
    set current_workspace (niri msg -j workspaces | jq -r '.[] | select(.is_focused == true) | .id')

    if test "$target_workspace" = "$current_workspace"
        return
    end

    # Check if target exists and get its monitor
    set target_monitor_idx ""
    set workspaces (niri msg -j workspaces | jq -r '.[] | "\(.id):\(.output)"')
    for ws in $workspaces
        set split (string split ':' $ws)
        if test "$split[1]" = "$target_workspace"
            set target_monitor $split[2]
            set target_monitor_idx (contains -i $target_monitor (get_sorted_monitors))
            break
        end
    end

    # If target doesn't exist, create it
    if test -z "$target_monitor_idx"
        niri msg action switch-workspace $target_workspace
        return
    end

    # If target is on current monitor, switch
    if test "$target_monitor_idx" = "$current_monitor_idx"
        niri msg action switch-workspace $target_workspace
        return
    end

    # Swap logic
    set temp_workspace __temp__
    niri msg action switch-workspace $temp_workspace
    move_workspace_to_monitor $target_monitor_idx
    niri msg action switch-workspace $target_workspace
    move_workspace-to-monitor $current_monitor_idx
    niri msg action switch-workspace $current_workspace
    move_workspace-to-monitor $target_monitor_idx
    niri msg action switch-workspace $target_workspace
end

# Handle command-line arguments
switch $argv[1]
    case monitor
        focus_monitor $argv[2]
    case send_to_output
        send_to_monitor $argv[2]
    case workspace
        switch_workspace $argv[2]
    case '*'
        echo "Usage: $0 [monitor|send_to_output|workspace] [args]"
        exit 1
end
