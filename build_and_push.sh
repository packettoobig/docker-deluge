#!/usr/bin/env bash

# Usage:
# ./build_and_push.sh

# VARS
dailytag=$(date -I)
imagename='pilbbq/deluge'
dailyimage="$imagename:$dailytag"
latestimage="$imagename:latest"

# SCRIPT
# Build daily, latest and uuid
docker build -t $dailyimage -t $latestimage .
# Push all tags
docker push -a $imagename
# Cleanup stuff older than 2weeks
docker system prune -af --filter "until=336h"
