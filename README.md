# Updated transcoder service

## --- THIS IS A REALLY BAD BETA ---- 
Caveat Emptor: I am not a coder, I just hack together other peoples stuff for my own needs. I updated the transcode.py script to work with Don's latest scripts and removed the vagrant/virtualbox wrapper around Andy's python transcode script.  Finally this handles the service using systemd instead of supervisord

## So what does it do?
The short version: This sets up a watch folder at /media/transcoder/input and will compress any video file placed in that folder down to a smaller size and spit it out to /media/transcoder/output.  At this point I know it adds all audio tracks but I do not know if the subtitle tracks are included.  I'll be tweaking it to my specific needs but don't have plans to take it any further.

If you're into writing web GUI's for status and monitoring I'd love the help!

I directly pulled this python script from https://github.com/andymccurdy/tested-transcoder and all credit for the script belongs to him.
The actual video transcode is done by Handbrake-CLI, ffmpeg is also used.  All credit for the video transcode scripts belongs to https://github.com/donmelton/video-transcoding-scripts 


## Prerequisites
* Ubuntu 16.04 (I used server edition)
* Git - http://git-scm.com/downloads
* MakeMKV - http://www.makemkv.com/download/

## Installation Instructions
 1. clone this repository
 2. chmod +x install.sh
 3. put video files in /media/transcoder/input and wait :)

## Usage

1. Starting your encodes is as easy as dragging a video from MakeMKV into the 'input' folder.
2. When the encode is in progress, you can check in on its progress by looking at the end of the log in the 'work' folder.
3. When the encodes are complete, the new, better compressed video will be in the 'output' folder and the original source MKV will be in the 'completed-originals' folder. After you've confirmed subtitles and audio tracks are correct, you can safely delete the large original file.
4. Enjoy your new, much smaller MKV in your favorite media player.

---
