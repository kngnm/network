#!/bin/sh

eval `ssh-agent`
ssh-add backup-key
sleep 1
rm -rf repo/*
rm -rf repo/.git
echo yes | git clone $REPO repo
cd repo

while true; do
  git add *
  git commit -m "`date`"
  git push origin master
  sleep 600
done
