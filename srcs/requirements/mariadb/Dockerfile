FROM	debian:bullseye

RUN	apt-get update && apt-get install -y \
	mariadb-server \
	tini \
	gettext-base

# Create and set proper permissions for MySQL directory
RUN	mkdir -p /var/lib/mysql /var/run/mysqld && \
    	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    	chmod 755 /var/lib/mysql && \
    	chmod 755 /var/run/mysqld

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sql /tmp/init.sql
COPY ./tools/mariadb.sh /tmp/mariadb.sh

RUN chmod +x /tmp/mariadb.sh
RUN chmod +x /tmp/init.sql

EXPOSE		3306

ENTRYPOINT ["/usr/bin/tini", "--", "/tmp/mariadb.sh"]
