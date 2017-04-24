#!/bin/bash
########################################################
# This script is used to cut pieces of a video file
# and convert them to webm and merge them together.
# The input file should contain the start and end
# times for the snippets separated by space, one snippet
# per line, in mm:ss format. Example:
# 01:00 02:15
# 10:05 11:00
#########################################################

if [ $# -ne 2 ]; then
    echo "Usage: $0 INPUT_VIDEO TIMES_LIST"
    echo "Example: $0 input.avi notes.txt"
    exit 1
fi

echo -n "" > parts_list.txt
i=0
while IFS=' ' read -u 10 -r t1 t2
do
    # process input times
    IFS=: read min1 sec1 <<< "$t1"
    IFS=: read min2 sec2 <<< "$t2"
    # calculate diff
    min1=$(echo $min1 | sed 's/^0*//')
    min2=$(echo $min2 | sed 's/^0*//')
    sec2=$(echo $sec2 | sed 's/^0*//')
    sec1=$(echo $sec1 | sed 's/^0*//')
    sec1=$((min1*60 + sec1))
    sec2=$((min2*60 + sec2))
    elaps=$(date -u -d "0 $sec2 sec - $sec1 sec" +"%M:%S")

    # cut the piece from the vid and convert to webm
    echo "[#] From $t1 for $elaps"
    ffmpeg -y -threads 3 -i $1 -ss $t1 -t $elaps -crf 5 -b:v 3M -vcodec libvpx -acodec libvorbis "$2_part$i.webm"
    # add the part to the list
    echo "file '$2_part$i.webm'" >> parts_list.txt
    i=$((i + 1))
done 10< "$2"

echo "[#] merging parts together"
ffmpeg -y -f concat -i parts_list.txt -c copy "$2.webm"

echo "cleaning up"
#rm "part*.webm"
#rm parts_list.txt
