FROM	    debian:bullseye

RUN	    apt-get update && apt-get upgrade -y && \
		apt-get install -y	\
        	curl \
        	sudo \	
			mariadb-client \
			php7.4 \
			php7.4-cli \
			php7.4-fpm \
			php7.4-mysql \
			php7.4-gd \
			php7.4-curl \
			php7.4-xml \
			php7.4-mbstring \
			php7.4-json \
			php7.4-redis \
		&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& php wp-cli.phar --info \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp \
	 	&& rm -rf /var/lib/apt/lists/* wp-cli.phar

# Copy the WordPress configuration script
COPY        tools/wordpress.sh /tmp/wordpress.sh

COPY        /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf


# Make script executable
RUN         chmod +x /tmp/wordpress.sh

EXPOSE      9000

ENTRYPOINT ["/tmp/wordpress.sh"]
