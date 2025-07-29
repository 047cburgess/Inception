FROM	    debian:bullseye

RUN	        apt-get update && apt-get upgrade -y && apt-get install -y	\
						wget \
                        unzip

RUN         apt-get install -y php7.4\
						php-fpm\
						php-mysql\
						mariadb-client\
                        curl\
                        vim	\
                        sudo	

RUN         wget https://wordpress.org/wordpress-6.8.zip -P /var/www
RUN         cd /var/www && unzip wordpress-6.8.zip && rm wordpress-6.8.zip
RUN		    chown -R www-data:www-data /var/www/wordpress


# Copy the WordPress configuration script
COPY        tools/wordpress.sh /tmp/wordpress.sh

COPY        /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf


# Make script executable
RUN         chmod +x /tmp/wordpress.sh

EXPOSE      9000

ENTRYPOINT ["/tmp/wordpress.sh"]
