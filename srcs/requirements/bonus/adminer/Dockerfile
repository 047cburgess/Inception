FROM debian:bullseye

RUN	apt-get update && apt-get install -y \
    php7.4 \
	php7.4-cli \
	php7.4-mysqli \
	curl \
	&& rm -rf /var/lib/apt/lists/*

# Create directory and download adminer
RUN mkdir -p /var/www/html
RUN curl -L -o /var/www/html/adminer.php https://www.adminer.org/latest.php

# Set permissions in Dockerfile
RUN chown -R www-data:www-data /var/www/html
RUN chmod 644 /var/www/html/adminer.php


COPY  tools/adminer.sh /tmp/adminer.sh
RUN   chmod +x /tmp/adminer.sh

EXPOSE 8080

ENTRYPOINT ["/tmp/adminer.sh"]