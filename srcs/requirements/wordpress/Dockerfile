FROM	    debian:bullseye

RUN	    apt-get update && apt-get upgrade -y && apt-get install -y	\
		wget \
        unzip \
        curl \
        vim \
        sudo \	
		php7.4 \
		php7.4-cli \
		php7.4-fpm \
		php7.4-mysql \
		mariadb-client \
		php7.4-gd \
		php7.4-curl \
		php7.4-xml \
		php7.4-mbstring \
		php7.4-json \
		php7.4-zip \
		&& rm -rf /var/lib/apt/lists/*

RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& php wp-cli.phar --info \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY        tools/init.sh /tmp/init.sh
COPY        tools/entrypoint.sh /tmp/entrypoint.sh
COPY        /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN         chmod +x /tmp/init.sh /tmp/entrypoint.sh
RUN         /tmp/init.sh

EXPOSE      9000

ENTRYPOINT ["/tmp/entrypoint.sh"]
