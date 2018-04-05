#!/bin/bash

echo "Checking config"
if [ ! -f /etc/notify-rocketchat.conf ]; then
    echo "Please create config file"
    set -e
 fi

# config file containing assignments for user, url, and token must be placed in /etc/
source /etc/notify-rocketchat.conf 

#message="$(</dev/stdin)"
while read message; do #its easier to handle piping to json if I don't do multiple lines, hence one line at a time because I suck at coding.

#  /usr/bin/curl -s -X POST -H 'Content-Type: application/json' --data "$(request_body)" "$url/$token"
  /usr/bin/curl -s POST -H 'Content-Type: application/json' --data '{ "username":"'$user'","text":"'"$message"'"}' "$url/$token"
  echo "$user $message $request_body"

done

#request_body()
#{
#  cat <<EOF
#{
#  "username": "$user",
#  "message": "$message",
#    }
#EOF
#}

