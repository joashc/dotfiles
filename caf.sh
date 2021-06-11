#!/usr/bin/sh

if [ $(cat ~/dotfiles/suspend.sh | wc -c | bc) -eq 0 ] || [ $(grep -r "RUNNING" /proc/asound | wc -l | bc) -gt 0 ]; then
  echo 
else
  echo ""
fi
