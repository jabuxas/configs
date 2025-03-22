#!/bin/bash
cd ~/.config/xmonad
./update
stack-bin setup
stack-bin install
./build
