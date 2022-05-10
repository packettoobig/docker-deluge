#!/usr/bin/env bash
# File location during build: /dockerinstall/install.sh

# Install
apt-get -qq update && \
apt-get -qq install \
    ca-certificates \
    deluged=1.3.15-2

# Cleanup
apt-get -qq purge lib-*dev build-essential
apt-get -qq purge --autoremove
apt-get -qq clean
rm -rf /var/lib/apt/lists/* \
    /dockerinstall/* \
    /tmp/*
