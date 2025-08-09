FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y golang git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --branch 2.20.2 https://github.com/portainer/portainer.git .

RUN go build -o portainer .

CMD ["./portainer"]
