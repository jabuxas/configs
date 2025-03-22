#!/bin/bash

running="/tmp/running"
if [ -f "$running" ]; then
	pid=$(cat "$running")
	kill $pid
	rm "$running"
else
	while true; do
		# spam e
		# xdotool keydown ctrl ; xdotool keyup ctrl
		# xdotool keydown e
		# xdotool keyup e

    # glaive 
    # xdotool keydown e
    # sleep 1.1
    # xdotool keyup e
    # sleep 0.3
    # xdotool click 2
    # sleep 0.2
    # xdotool click 1
    # sleep 1
    ydotool click --next-delay 1000 0xC0

done &
echo "$!" >"$running"
fi
