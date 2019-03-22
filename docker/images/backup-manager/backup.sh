#!/bin/sh

eval `ssh-agent`
ssh-add /backup-key
sleep 1
rm -rf repo/*
rm -rf repo/.git
git clone git@bitbucket.org:kngnm/mediaserver.git repo
cd repo

while true; do
  ls -a
  git add *
  git commit -m "`date`"
  git push origin master
  sleep 10
done
