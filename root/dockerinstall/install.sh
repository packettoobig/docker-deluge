#!/usr/bin/env bash
# File location during build: /dockerinstall/install.sh

# Install
apt-get -qq update && \
apt-get -qq install \
    ca-certificates \
    curl \
    deluge-console=1.3.15-2 \
    deluged=1.3.15-2 \
    python-crypto \
    python-libtorrent \
    python3-crypto \
    python3-libtorrent \
    xfsprogs

# Update GeoIP
curl -o /usr/share/GeoIP/GeoIP.dat \
    -L "https://ipfs.infura.io/ipfs/QmWTWcPRRbADZcLcJeANZmcJZNrcpmuQgKYBi6hGdddtC6"

# Cleanup
apt-get -qq purge \
    curl \
    lib-*dev \
    build-essential

apt-get -qq purge --autoremove
apt-get -qq clean
rm -rf /var/lib/apt/lists/* \
    /dockerinstall/* \
    /tmp/*
