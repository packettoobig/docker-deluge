#!/usr/bin/env bash
# File location during build: /dockerinstall/install.sh

set -eo pipefail

# Install
apt-get -qq update && \
apt-get -qq --no-install-recommends install \
    sudo \
    ca-certificates \
    curl \
    gzip \
    net-tools \
    python3-pip \
    python3-dev \
    build-essential \
    xfsprogs \
    dirmngr \
    gnupg \
    apt-transport-https
# Last 3 apt lines are for filebot

# https://deluge.readthedocs.io/en/latest/depends.html
pip3 install --no-input --break-system-packages -r requirements-py3.txt

# GeoIP Database Setup
mkdir -p /usr/share/GeoIP/
geoip_dat_path="/usr/share/GeoIP/GeoIP.dat"
# downlad latest GeoIP.dat from linuxserver.io
# Inspired from https://github.com/linuxserver/docker-deluge/blob/9658bd613c16e41edc5582db67ca58bc34f75a69/root/app/update-geoip.sh
curl -s -L --retry 3 --retry-max-time 30 --retry-all-errors \
    "https://geoip.linuxserver.io/GeoIP.dat.gz" |
    gunzip > /tmp/GeoIP.dat && \
    mv /tmp/GeoIP.dat "${geoip_dat_path}" && \
    chmod 644 "${geoip_dat_path}"

ls -l "${geoip_dat_path}"

# FileBot Repository Setup
curl -fsSL "https://raw.githubusercontent.com/filebot/plugins/master/gpg/maintainer.pub" | gpg --dearmor --output "/usr/share/keyrings/filebot.gpg"
echo "deb [arch=all signed-by=/usr/share/keyrings/filebot.gpg] https://get.filebot.net/deb/ universal main" > /etc/apt/sources.list.d/filebot.list

# Filebot install itself
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
