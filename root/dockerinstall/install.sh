#!/usr/bin/env bash
# File location during build: /dockerinstall/install.sh

# Install
apt-get -qq update && \
apt-get -qq --no-install-recommends install \
    ca-certificates \
    curl \
    net-tools \
    deluge-console=1.3.15-2 \
    deluged=1.3.15-2 \
    python-crypto \
    python-libtorrent \
    python3-crypto \
    python3-libtorrent \
    xfsprogs

# Cleanup
apt-get -qq --auto-remove purge \
    curl \
    lib-*dev \
    build-essential

apt-get -qq purge --autoremove
apt-get -qq clean
rm -rf /var/lib/apt/lists/* \
    /dockerinstall/* \
    /tmp/*

# Post-install
chmod +x /usr/local/bin/*.sh /usr/local/bin/healthcheck.sh 