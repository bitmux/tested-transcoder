
#!/bin/bash

# must be run as root
echo off 

echo "Removing previously installed version"
systemctl stop transcoder.service
rm /usr/local/bin/transcoder.py
rm /etc/systemd/system/transcoder.service
rm /media/transcoder/transcoder.log

#echo "pulling git repo"
#git clone https://github.com/bitmux/video_transcoding.git ./tested-transcoder
cd tested-transcoder
echo "updating apt repository..."
apt update 
echo "installing all kinds of stuff..." 
apt install -y handbrake-cli mp4v2-utils mkvtoolnix ffmpeg ruby python git samba samba-common-bin
echo "installing Don Melton's scripts via ruby gem..."
gem install video_transcoding
echo "making lots of directories..."
mkdir /media/transcoder
mkdir /media/transcoder/input
mkdir /media/transcoder/output
mkdir /media/transcoder/completed-originals
mkdir /media/transcoder/work
chown -R $USER /media/transcoder

echo "installing transcoder script and service.."
cp transcoder.py /usr/local/bin/transcoder.py
cp transcoder.service /etc/systemd/system/transcoder.service
cp notify-rocketchat.sh /usr/local/bin/notify-rocketchat.sh
chmod +x /usr/local/bin/transcoder.py
chmod +x /usr/local/bin/notify-rocketchat.sh
if [ ! -f /etc/notify-rocketchat.conf ] 
  then
  cp notify-rocketchat.conf /etc/notify-rocketchat.conf
fi

echo "enabling and starting services..."
systemctl enable transcoder.service
systemctl start transcoder.service
while [ ! -f /media/transcoder/transcoder.log ]
  do
  sleep 1
  done 
tail -n1 /media/transcoder/transcoder.log

echo "[public]

comment = public share, no need to enter username and password
path = /media/transcoder/
browseable = yes
writable = yes
guest ok = yes" >> /etc/samba/smb.conf
