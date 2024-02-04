#!/bin/bash
# i adapted this script from maze, a dear friend of mine
# maze42d/dotfiles on github

firefox_binary="firefox-bin"

if [[ -z $1 ]]; then
  echo "Usage: $0 <profile> <workspace>"
  exit 1
fi

firefox_profile=$1
workspace=$2

echo "$firefox_profile to $workspace"

$firefox_binary -p $firefox_profile &> /dev/null &
PID=$!

command="hyprctl dispatch movetoworkspacesilent ${workspace},pid:$PID"
echo $command

until hyprctl clients | grep "pid: $PID" > /dev/null #wait till window opens
  do
    sleep 0
done
$command
disown
exit 0


