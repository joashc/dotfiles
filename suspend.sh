# Need to export the display environment variable, cron env doesn't have it
export DISPLAY=:0
initial_idle=$(xprintidle | bc)

echo "Initial idle:"
echo "$initial_idle"
# Dim the screen if there's been no X activity for more than 3 minutes
if [ "$initial_idle" -gt 180000 ]; then
  echo "Dimming screen"
  xcalib -co 60 -a

  idle=$(xprintidle | bc)
  # Keep looping if we're still idle
  while [ "$idle" -gt 2000 ]
  do
    idle=$(xprintidle | bc)

    # Suspend 20 seconds after screen dims
    if [ "$idle" -gt $(($initial_idle + 20000)) ];
    then
      echo "Suspending"
      systemctl suspend
    fi
    sleep 0.1
  done

  # Reset the display contrast once user activity is detected
  xcalib -clear
fi