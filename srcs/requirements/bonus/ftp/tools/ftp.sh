#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}Starting FTP Server setup...${NC}"

# Create FTP user if it doesn't exist
if ! id "$FTP_USER" &>/dev/null; then
    echo -e "${YELLOW}Creating FTP user: ${FTP_USER}${NC}"
    useradd -m -d /var/www/wordpress -s /bin/bash "$FTP_USER"
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
    
    # Set WordPress directory permissions
    chown -R "$FTP_USER":www-data /var/www/wordpress
    chmod -R 755 /var/www/wordpress
    
    echo -e "${GREEN}✅ FTP user created successfully${NC}"
else
    echo -e "${YELLOW}FTP user ${FTP_USER} already exists${NC}"
fi

# Ensure WordPress directory exists and has correct permissions
if [ ! -d "/var/www/wordpress" ]; then
    echo -e "${YELLOW}Creating WordPress directory...${NC}"
    mkdir -p /var/www/wordpress
fi

# Set ownership and permissions
chown -R "$FTP_USER":www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "127.0.0.1 $PASV_ADDRESS" >> /etc/hosts

# Update pasv_address in config with container IP or hostname
if [ -n "$PASV_ADDRESS" ]; then
    echo -e "${YELLOW}Setting passive mode address to: ${PASV_ADDRESS}${NC}"
    sed -i "s/pasv_address=127.0.0.1/pasv_address=${PASV_ADDRESS}/" /etc/vsftpd.conf
fi

echo -e "${GREEN}🚀 Starting vsftpd server...${NC}"
echo -e "${CYAN}FTP server accessible at: ftp://${FTP_USER}@localhost:21${NC}"
echo -e "${CYAN}WordPress files location: /var/www/wordpress${NC}"

# Start vsftpd in foreground
exec vsftpd /etc/vsftpd.conf
