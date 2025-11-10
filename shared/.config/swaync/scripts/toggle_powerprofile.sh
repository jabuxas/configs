#!/bin/bash

if powerprofilesctl get | grep -q "power-saver";
then
    powerprofilesctl set performance
else
    powerprofilesctl set power-saver
fi
