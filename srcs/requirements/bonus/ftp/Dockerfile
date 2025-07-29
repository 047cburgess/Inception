FROM	debian:bullseye

RUN	apt-get update && apt-get install -y \
    	vsftpd \
    	&& apt-get clean \
    	&& rm -rf /var/lib/apt/lists/*

COPY	conf/vsftpd.conf /etc/vsftpd.conf

COPY	tools/ftp.sh /usr/local/bin/ftp.sh
RUN	chmod +x /usr/local/bin/ftp.sh

RUN	mkdir -p /var/run/vsftpd/empty \
    	&& mkdir -p /var/ftp \
    	&& chmod 755 /var/ftp

EXPOSE 21 21000-21010

ENTRYPOINT ["/usr/local/bin/ftp.sh"]

