#!/bin/sh

eval `ssh-agent`
ssh-add tunnel-key
ssh -f -N -R $REMOTE_PORT:localhost:$LOCAL_PORT $USERNAME@$REMOTE_HOST
while true; do
  sleep 30
done
