#!/bin/bash
cd ~/
URL=`xclip -o -selection clipboard`
twid=`sed 's/[^0-9]//g' <<<$URL`
twitchfn=`youtube-dl --get-filename -o "%(uploader)s - %(upload_date)s - %(title)s" $URL`
youtube-dl $URL &  PIDVD=$! 
tcd --video $twid --format ssa --output Movies/ &  PIDCH=$!
wait $PIDVD
wait $PIDCH
ffmpeg -i "Movies/${twitchfn}.mp4" -i "Movies/${twid}.ssa" -c:v copy -c:a copy -c:s copy "Movies/${twitchfn}.mkv"
rm "Movies/${twid}.ssa" | rm "Movies/${twitchfn}.mp4"
