FROM	    debian:bookworm

RUN	    apt-get update && apt-get upgrade -y && \
		apt-get install -y	\
        	curl \
        	sudo \	
			mariadb-client \
			php8.2 \
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
	 	&& rm -rf /var/lib/apt/lists/* wp-cli.phar \
		&& mkdir -p /usr/src/wordpress \
		&& wp core download --path=/usr/src/wordpress --allow-root

WORKDIR /var/www/wordpress

COPY    tools/wordpress.sh /tmp/wordpress.sh

COPY    conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN     chmod +x /tmp/wordpress.sh

ENTRYPOINT ["/tmp/wordpress.sh"]
