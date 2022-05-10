FROM debian:10-slim

LABEL maintainer="pilbbq"

COPY ["root/", "/"]

RUN bash /dockerinstall/install.sh

# ports and volumes
#EXPOSE 8112 58846 58946 58946/udp
#VOLUME /config /downloads
