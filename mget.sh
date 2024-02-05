#!/bin/sh

case "$1" in
    https://*.youtube.com/*)
        # 251 is the audio only webm format using the opus codec at ~160kbps
        yt-dlp --format 251 --extract-audio "$1"
        ;;
    https://www.instagram.com/*)
        ins_profile=$(echo "$1" | cut -d'/' -f4)
        instaloader --quiet --latest-stamps latest-stamps.ini --comments --igtv "$ins_profile"
        ;;
    *)
        # TODO add more common audio formats
        # TODO support upper case extensions, e.g. *.WAV
        common_audio_format='.wav,.mp3,.ogg,.opus,.flac,.aac'
        wget --accept="$common_audio_format" --execute='robots=off' --continue --recursive --level=2 --no-directories "$1"
        ;;
esac
