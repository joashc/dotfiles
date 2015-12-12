sleep 3
# Check idle time
initial_idle=$(xprintidle | bc)

# Dim the screen if there's been no X activity for more than 3 minutes
if [ "$initial_idle" -gt 18000 ]; then
  xcalib -co 60 -a

  idle=$(xprintidle | bc)
  # Keep looping if we're still idle
  while [ "$idle" -gt 2000 ]
  do
    idle=$(xprintidle | bc)

    # Suspend 20 seconds after screen dims
    if [ "$idle" -gt $(($initial_idle + 20000)) ];
    then
      systemctl suspend
    fi
    sleep 0.1
  done

  # Reset the display contrast once user activity is detected
  xcalib -clear
fi
