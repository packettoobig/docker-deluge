#!/usr/bin/env bash
# File location during build: /dockerinstall/install.sh

# Install
apt-get -qq update && \
apt-get -qq --no-install-recommends install \
    sudo \
    ca-certificates \
    curl \
    net-tools \
    python3-pip \
    python3-dev \
    build-essential \
    geoip-database \
    xfsprogs \
    dirmngr \
    gnupg \
    apt-transport-https
# Last 3 apt lines are for filebot

# https://deluge.readthedocs.io/en/latest/depends.html
pip3 install --no-input --break-system-packages \
    deluge \
    libtorrent \
    distro \
    ifaddr \
    six

curl -fsSL "https://raw.githubusercontent.com/filebot/plugins/master/gpg/maintainer.pub" | gpg --dearmor --output "/usr/share/keyrings/filebot.gpg"
echo "deb [arch=all signed-by=/usr/share/keyrings/filebot.gpg] https://get.filebot.net/deb/ universal main" > /etc/apt/sources.list.d/filebot.list

apt-get -qq update

apt-get -qq --install-recommends install \
    filebot \
    default-jre-headless \
    libjna-java \
    mediainfo \
    libchromaprint-tools \
    unzip \
    unrar-free \
    p7zip-full \
    xz-utils \
    ffmpeg \
    mkvtoolnix \
    atomicparsley \
    imagemagick \
    webp \
    libjxl-tools \
    sudo \
    gnupg \
    curl \
    file \
    inotify-tools \
    rsync \
    jdupes \
    duperemove

# Cleanup
apt-get -qq --auto-remove purge \
    curl \
    lib-*dev \
    python3-dev \
    build-essential

apt-get -qq purge --autoremove
apt-get -qq clean
rm -rf /var/lib/apt/lists/* \
    /dockerinstall/* \
    /tmp/*

# Post-install
chmod +x /usr/local/bin/*.sh /usr/local/bin/healthcheck.sh
chmod +x /entrypoint.sh
