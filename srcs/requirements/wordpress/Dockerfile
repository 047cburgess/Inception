FROM	    debian:bookworm

RUN	    apt-get update && apt-get upgrade -y && \
		apt-get install -y	\
        	curl \
        	sudo \	
			mariadb-client 

RUN     apt-get install -y \
			php8.2 

RUN     apt-get install -y \
			php8.2-cli \
			php8.2-fpm \
			php8.2-mysql \
			php8.2-gd \
			php8.2-curl \
			php8.2-xml \
			php8.2-redis 

RUN     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& php wp-cli.phar --info \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp \
	 	&& rm -rf /var/lib/apt/lists/* wp-cli.phar

# Copy the WordPress configuration script
COPY        tools/wordpress.sh /tmp/wordpress.sh

COPY        /conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf


# Make script executable
RUN         chmod +x /tmp/wordpress.sh

ENTRYPOINT ["/tmp/wordpress.sh"]
