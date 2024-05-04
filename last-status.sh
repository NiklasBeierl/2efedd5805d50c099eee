#!/usr/bin/env bash

EXP_ID_FILE=./last-exploit-id
TOKEN_FILE=./challenge-token

if [ -f $EXP_ID_FILE ]; then
  EXP_ID=$(cat $EXP_ID_FILE)
else
  echo "File $EXP_ID_FILE does not exist, can't get status. :("
  exit 1
fi

if [ -f $TOKEN_FILE ]; then
  TOKEN=$(cat $TOKEN_FILE)
else
  echo "File $TOKEN_FILE does not exist, can't get status. :("
  exit 1
fi

curl -s https://play.livectf.com/api/exploits/$EXP_ID -H "X-LiveCTF-Token: $TOKEN" | jq
