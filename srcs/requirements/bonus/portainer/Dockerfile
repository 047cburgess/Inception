FROM debian:bookworm

RUN apt-get update && apt-get install -y wget tar && apt-get clean

RUN cd /opt \
    && wget "https://github.com/portainer/portainer/releases/download/2.16.2/portainer-2.16.2-linux-amd64.tar.gz" -O "portainer.tar.gz" \
    && tar xvpfz "portainer.tar.gz" \
    && rm portainer.tar.gz

EXPOSE 9000

ENTRYPOINT ["/opt/portainer/portainer", "-H", "unix:///var/run/docker.sock"]