#!/bin/sh

ssh -R $REMOTE_PORT:localhost:$LOCAL_PORT $USERNAME@$REMOTE_HOST &
while true; do
  sleep 1
done
