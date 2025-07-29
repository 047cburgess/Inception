#!/bin/bash

# Colors for output (fix: no spaces around = and proper quotes)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo "Beginning the script.sh of Wordpress"

mkdir -p /run/php

echo -e "${CYAN}Setting ownership...${NC}"
chown -R www-data:www-data /var/www/wordpress

if [ ! -f /var/www/wordpress/wp-config.php ]; then
	echo "Downloading WordPress..."
	wp core download --path=/var/www/wordpress --allow-root

	echo "Creating wp-config.php..."
   	 wp config create \
        --path=/var/www/wordpress \
        --dbname=${WORDPRESS_DB_NAME} \
        --dbuser=${WORDPRESS_DB_ADMIN} \
        --dbpass=${WORDPRESS_DB_ADMIN_PASSWORD} \
        --dbhost=${WORDPRESS_DB_HOST} \
        --allow-root

    	echo "Installing WordPress..."
    	wp core install \
        --path=/var/www/wordpress \
        --url=${WORDPRESS_URL} \
        --title="${WORDPRESS_TITLE}" \
        --admin_user=${WORDPRESS_DB_ADMIN} \
        --admin_password=${WORDPRESS_DB_ADMIN_PASSWORD} \
        --admin_email=${WORDPRESS_DB_ADMIN_EMAIL} \
        --skip-email \
        --allow-root

	echo "Creating second wp user..."
    	wp user create \
	${WORDPRESS_DB_USER} \
	${WORDPRESS_DB_USER_EMAIL} \
        --path=/var/www/wordpress \
	--user_pass=${WORDPRESS_DB_USER_PASSWORD} \
	--role=editor \
	--allow-root
fi



cat /var/www/wordpress/wp-config.php

# Start PHP-FPM

echo -e "${GREEN}Starting PHP-FPM...${NC}"
exec php-fpm7.4 -F --nodaemonize
