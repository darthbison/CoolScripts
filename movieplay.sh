MOVIE=$1 #Movie to play
MOVIE_LOOPS="1" #Number of times to play movie
MOVIE_SLEEP="3600" # Number of seconds to sleep between movie plays (1 hour by default)

tv_off() {
  if [ "$(echo "pow 0" | cec-client -d 1 -s | grep 'power status: on')" ]; then # If TV is currently on
    echo "standby 0" | cec-client -d 1 -s # Send the standby command
  fi
}

prepare_tv() {
  tv_off #Switch the TV off and on again
  sleep 5 # Give it a few seconds to shut down
  echo "on 0" | cec-client -d 1 -s # Now send the on command
  sleep 5 # And give the TV another few seconds to wake up
  echo "as" | cec-client -d 1 -s # Now set the script to be the active source
}

play_movie() {
  if [ -f ~/"$MOVIE" ]; then # Check that the creepy movie file exists
    omxplayer -o hdmi ~/"$MOVIE" # Then play it with sound going out through HDMI
  fi
  echo "Playing movie"
}

prepare_tv
play_movie
tv_off
