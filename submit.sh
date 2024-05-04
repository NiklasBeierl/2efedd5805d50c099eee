#!/usr/bin/env bash
set -e

EXP_ID_FILE=./last-exploit-id
TOKEN_FILE=./challenge-token
CHALL_ID_FILE=./challenge-id

if [ -f $TOKEN_FILE ]; then
  TOKEN=$(cat $TOKEN_FILE);
else
  echo "File $TOKEN_FILE does not exist, can't submit your solution. :(";
  exit 1;
fi

if [ -f $CHALL_ID_FILE ]; then
  CHALL=$(cat $CHALL_ID_FILE);
else
  echo "File $CHALL_ID_FILE does not exist, can't submit your solution. :(";
  exit 1;
fi

echo "Freezing deps..."
./venv/bin/pip freeze > solution/requirements.txt

TS=$(date +%Y-%m-%d-%H-%M-%S)
mkdir -p submissions
BUNDLE_PATH=./submissions/$CHALL-$TS.tar.gz

echo "Taring submission: $BUNDLE_PATH"

tar czf $BUNDLE_PATH solution/*

cd solution
tar czf ../$BUNDLE_PATH ./*
cd ..

LATEST_SUBMIT=latest-submit.tar.gz
echo "Symlinking latest submission $BUNDLE_PATH to $LATEST_SUBMIT"

ln -sf $BUNDLE_PATH $LATEST_SUBMIT

URL=https://play.livectf.com/api/challenges/$CHALL

RES=$(curl -s $URL -F exploit=@$BUNDLE_PATH -H "X-LiveCTF-Token: $TOKEN")

echo "Submitted, response:"
echo $RES | jq

EXPLOIT_ID=$(echo $RES | jq -er .exploit_id)

echo "Saving last exploit id...";
echo $EXPLOIT_ID > ./last-exploit-id
echo "Get status via: $ ./last-status.sh"
echo "Get output via: $ ./last-output.sh"
