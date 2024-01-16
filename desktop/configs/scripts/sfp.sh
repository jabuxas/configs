#!/bin/bash

sfp="/tmp/sfp"
if [ -f "$sfp" ]; then
  rm $sfp
else
  /yang/docs/SFP_UI-linux-x64-SelfContained/SFP_UI &
  echo "$!" > "$sfp"
  sleep 1
fi
steam --noverifyfiles -cef-enable-debugging &

