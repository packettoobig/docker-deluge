FROM debian:13-slim

LABEL maintainer="pilbbq"

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV GROUPNAME=delugegroup
ENV USERNAME=delugeusr
ENV PUID=1111
ENV PGID=1111
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR=/etc/ssl/certs

COPY ["root/", "/"]

RUN bash /dockerinstall/install.sh

ENTRYPOINT ["/entrypoint.sh", "/usr/local/bin/deluged", "-d", "-c", "/deluge" ]

HEALTHCHECK --start-period=1m --interval=15s --timeout=15s \
   CMD /usr/local/bin/healthcheck.sh

# Please use macvlan or host network : https://docs.docker.com/network/macvlan/
EXPOSE 58946 58946/udp
