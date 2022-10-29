#!/usr/bin/env bash 

TEMP=${TEMP:-$(sensors | grep 'edge: ' | awk '{print $2}' | sed 's/+//' | sed 's/.0°C//')}
TEMP=${TEMP%???}

echo "$TEMP°C"