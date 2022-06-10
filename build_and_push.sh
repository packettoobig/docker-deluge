#!/usr/bin/env bash
# VARS
dailytag=$(date -I)
imagename='pilbbq/deluge'
dailyimage="$imagename:$dailytag"
latestimage="$imagename:latest"
# Build daily and latest
docker build -t $dailyimage -t $latestimage .
# Push all tags
docker push -a $imagename