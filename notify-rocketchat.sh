#!/bin/bash

echo "Checking config"
if [ ! -f /etc/notify-rocketchat.conf ]; then
    echo "Please create config file"
    set -e
 fi
source /etc/notify-rocketchat.conf

#message="$(</dev/stdin)"
while read message; do

#  /usr/bin/curl -s -X POST -H 'Content-Type: application/json' --data "$(request_body)" "$url/$token"
  /usr/bin/curl -s POST -H 'Content-Type: application/json' --data '{ "username":"'$user'","text":"'"$message"'"}' "$url/$token"
  echo "$user $message $request_body"

done

request_body()
{
  cat <<EOF
{
  "username": "$user",
  "message": "$message",
    }
EOF
}

