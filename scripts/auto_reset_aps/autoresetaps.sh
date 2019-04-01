#!/bin/bash

# A script to reset all the aps in the house
# Effectively the same as pressing the reset button on the underside of the ap
# Sometimes they all disconnect from the unifi controller (toadserver.kingman:8080)
# After some time of being disconnected from the unifi controller, they stop working.
# Resetting them and resetting the unifi controller seems to get them back in sync
# Make sure to run this script while plugged in to ethernet, or you'll lose connection midway through
# You'll have to enter the ap password, which can be found here:
# https://toadserver.kingman:8443/manage/site/default/settings/site

prefix="10.20.96"
addrs=(6 7 8 9 10 11)

for ap in ${addrs[@]}; do
  ip="$prefix.$ap"
  echo "Reseting $ip..."
  ssh admin@$ip 'syswrapper.sh restore-default'
done
