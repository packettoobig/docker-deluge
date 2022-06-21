FROM debian:10-slim

LABEL maintainer="pilbbq"

COPY ["root/", "/"]

RUN bash /dockerinstall/install.sh

ENTRYPOINT ["/usr/bin/deluged", "-d", "-c", "/deluge" ] 

HEALTHCHECK --start-period=1m --interval=15s --timeout=15s \
   CMD /usr/local/bin/healthcheck.sh

# Please use macvlan or host network : https://docs.docker.com/network/macvlan/
EXPOSE 58946 58946/udp
