FROM debian:10-slim

LABEL maintainer="pilbbq"

ENV LANG C.UTF-8
ENV GROUPNAME delugegroup
ENV USERNAME delugeusr
ENV PUID 1111
ENV PGID 1111

COPY ["root/", "/"]

RUN bash /dockerinstall/install.sh

ENTRYPOINT ["/entrypoint.sh", "/usr/bin/deluged", "-d", "-c", "/deluge" ] 

HEALTHCHECK --start-period=1m --interval=15s --timeout=15s \
   CMD /usr/local/bin/healthcheck.sh

# Please use macvlan or host network : https://docs.docker.com/network/macvlan/
EXPOSE 58946 58946/udp
