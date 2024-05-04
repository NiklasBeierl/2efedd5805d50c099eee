#!/usr/bin/env bash

set -e

TOKEN_FILE=./challenge-token
CHALL_ID_FILE=./challenge-id

if [ -f $CHALL_ID_FILE ]; then
  echo "Seems like you already have a $CHALL_ID_FILE";
else
  read -p 'Challenge id pls: ' CHALLENGE_ID;
  echo $CHALLENGE_ID > $CHALL_ID_FILE;
fi

if [ -f $TOKEN_FILE ]; then
  echo "Seems like you already have a $TOKEN_FILE";
else
  read -p "Token please: " TOKEN
  echo $TOKEN > $TOKEN_FILE;
fi

echo "Setting up venv..."
python3 -m venv venv
venv/bin/pip install -r ./initial-requirements.txt

echo
echo "Make sure to use the venv while developing your exploit!"
echo "$ . venv/bin/activate"
