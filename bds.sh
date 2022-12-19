#/bin/bash
set -e

echo connecting...
#bluetoothctl -- connect 08:BF:A0:B2:26:1E
bluetoothctl -- connect 14:22:3B:DE:4B:CD
echo waiting for bt card...
until [ $(pactl list | ag 'Name: bluez_card.' | wc -c) -gt 0 ]
do
  sleep 1
done

echo bt card found. setting to msbc...
card=$(pactl list | ag 'Name: bluez_card.' | awk '{print $2}')
pactl set-card-profile $card headset-head-unit-msbc
