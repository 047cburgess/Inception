FROM debian:bookworm

RUN	apt-get update && apt-get install -y \
    php8.2 \
	php8.2-cli \
	php8.2-mysqli \
	curl \
	tini \
	&& rm -rf /var/lib/apt/lists/*

# Create directory and download adminer
RUN mkdir -p /var/www/html
RUN curl -L -o /var/www/html/adminer.php https://www.adminer.org/latest.php

# Copy start up scripts into the container
COPY  tools/adminer.sh /tmp/adminer.sh
RUN   chmod +x /tmp/adminer.sh

EXPOSE 8080

ENTRYPOINT ["/usr/bin/tini", "--", "/tmp/adminer.sh"]