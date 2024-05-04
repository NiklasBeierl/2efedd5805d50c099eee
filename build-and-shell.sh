#!/usr/bin/env bash

set -e

CHALL_ID_FILE=./challenge-id

if [ -f $CHALL_ID_FILE ]; then
  CHALL=$(cat $CHALL_ID_FILE);
else
  echo "File $CHALL_ID_FILE does not exist, can't build your stuff. :(";
  exit 1;
fi

TS=$(date +%Y-%m-%d-%H-%M-%S)
NAME=livectf-$CHALL

cd solution
docker build --tag $NAME:$TS .
docker tag $NAME:$TS $NAME:latest

echo
echo "Built: $NAME:$TS, dropping you into a shell!"
echo "Files challenge-id and challenge-token and id are in /root !"
echo
docker run --rm -it \
-v ./challenge-id:/root/challenge-id \
-v ./challenge-token:/root/challenge-token \
$NAME:$TS /bin/bash
