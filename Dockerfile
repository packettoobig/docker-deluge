FROM debian:10-slim

LABEL maintainer="pilbbq"

COPY ["root/", "/"]

RUN bash /dockerinstall/install.sh

ENTRYPOINT /usr/bin/deluged -d -c /deluge

# Please use macvlan or host network : https://docs.docker.com/network/macvlan/