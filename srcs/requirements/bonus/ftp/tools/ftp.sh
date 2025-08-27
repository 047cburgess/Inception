#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}Starting FTP Server setup...${NC}"

if ! id "$FTP_USER" &>/dev/null; then
    echo -e "${YELLOW}Creating FTP user: ${FTP_USER}${NC}"
    useradd -d /var/www/wordpress "$FTP_USER"
    usermod -g www-data ${FTP_USER}
    echo "${FTP_USER}:$(< /run/secrets/ftp_password)" | chpasswd
    echo -e "${GREEN}✅ FTP user created successfully${NC}"
else
    echo -e "${YELLOW}FTP user ${FTP_USER} already exists${NC}"
fi

echo -e "${GREEN}🚀 Starting vsftpd server...${NC}"
echo -e "${CYAN}FTP server accessible in terminal at: lftp ${FTP_USER}@localhost${NC}"

# Start vsftpd in foreground
exec vsftpd /etc/vsftpd.conf
