#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar 1st 2>&1 | tee -a /tmp/polybar.log & disown
polybar 2nd 2>&1 | tee -a /tmp/polybar.log & disown
echo "Polybar launched..."
