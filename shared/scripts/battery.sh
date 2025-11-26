#!/bin/bash
notify_levels=(3 5 10 20 30 50)
BAT=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' -printf '%f\n' -quit 2>/dev/null)
last_notify=100

while true; do
    bat_lvl=$(<"/sys/class/power_supply/${BAT}/capacity")
    if [ $bat_lvl -gt $last_notify ]; then
            last_notify=$bat_lvl
    fi
    for notify_level in ${notify_levels[@]}; do
        if [ $bat_lvl -le $notify_level ]; then
            if [ $notify_level -lt $last_notify ]; then
                notify-send -u critical "low battery" "$bat_lvl% battery remaining."
                last_notify=$bat_lvl
            fi
        fi
    done
sleep 60
done
