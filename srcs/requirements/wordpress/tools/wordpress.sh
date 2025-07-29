#!/bin/bash
# Create directory for PHP-FPM PID file

#caburges
#mypassword
#rootpassword

# Colors for output (fix: no spaces around = and proper quotes)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo "Beginning the script.sh of Wordpress"

sleep 5
mkdir -p /run/php

echo -e "${BLUE}Replacing database name...${NC}"
sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/wordpress/wp-config-sample.php

echo -e "${RED}Replacing database username...${NC}"
sed -i "s/username_here/$MYSQL_USER/g" /var/www/wordpress/wp-config-sample.php

echo -e "${GREEN}Replacing database password...${NC}"
sed -i "s/password_here/$MYSQL_PASSWORD/g" /var/www/wordpress/wp-config-sample.php

echo -e "${YELLOW}Replacing database hostname...${NC}"

 #Replace empty DB_HOST with mariadb in wp-config-sample.php
sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', 'mariadb' );/g" /var/www/wordpress/wp-config-sample.php

echo -e "${PURPLE}Copying wp-config file...${NC}"
cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

echo -e "${CYAN}Setting ownership...${NC}"
chown -R www-data:www-data /var/www/wordpress

cat /var/www/wordpress/wp-config.php

# Start PHP-FPM

echo -e "${GREEN}Starting PHP-FPM...${NC}"
exec php-fpm7.4 -F --nodaemonize
