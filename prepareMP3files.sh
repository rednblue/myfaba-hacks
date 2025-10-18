## use this script to rename all the mp3 files, and edit song title mp3 tag. be sure to install id3v2.


#!/bin/bash

# Uso: ./rename_and_tag.sh XXXX
# Dove XXXX is 4 ID number after the K
# Es: ./rename_and_tag.sh 1234  -->  K1234CP01, K1234CP02, ...

if [ -z "$1" ]; then
    echo "Uso: $0 <4numbers>"
    exit 1
fi

base="$1"
count=1

for f in *.mp3; do
    # Nome con zero padding (CP01.mp3, CP02.mp3, ...)
    new=$(printf "CP%02d.mp3" $count)

    echo "Rinomino: $f → $new"
    mv -n "$f" "$new"

    #  tag definition:  KxxxxCPyy
    song_id=$(printf "K%sCP%02d" "$base" $count)
    echo "  Updating tag: $song_id"

    id3v2 -a "" -A "" -c "" -g "" -y "" -T "" --song "$song_id" "$new"

    count=$((count + 1))
done
