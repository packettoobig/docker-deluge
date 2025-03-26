#!/usr/bin/env bash
# File location during build: /dockerinstall/install.sh

# Install
apt-get -qq update && \
apt-get -qq --no-install-recommends install \
    ca-certificates \
    curl \
    net-tools \
    python3-pip \
    geoip-database \
    xfsprogs \
    dirmngr \
    gnupg \
    apt-transport-https
# Last 3 apt lines are for filebot

# https://deluge.readthedocs.io/en/latest/depends.html
pip3 install --no-input \
    deluge \
    libtorrent \
    distro \
    ifaddr

# Equivalent command : apt-key adv --fetch-keys https://get.filebot.net/filebot/KEYS
apt-key adv --fetch-keys https://raw.githubusercontent.com/filebot/plugins/master/gpg/maintainer.pub

echo "deb [arch=all] https://get.filebot.net/deb/ universal main" | tee /etc/apt/sources.list.d/filebot.list
apt-get -qq update

apt-get -qq --no-install-recommends install \
    filebot \
    default-jre-headless \
    libjna-java \
    mediainfo \
    libchromaprint-tools \
    p7zip-full \
    xz-utils \
    mkvtoolnix \
    atomicparsley \
    sudo \
    gnupg \
    curl \
    file \
    six

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
chmod +x /entrypoint.sh
