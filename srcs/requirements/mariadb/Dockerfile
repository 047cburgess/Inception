FROM	debian:bookworm

RUN	apt-get update && apt-get install -y \
	mariadb-server \
	tini \
	gettext-base

RUN	mkdir -p /var/lib/mysql /var/run/mysqld && \
    	chown -R mysql:mysql /var/run/mysqld && \
    	chmod 755 /var/run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sql /tmp/init.sql
COPY ./tools/mariadb.sh /tmp/mariadb.sh
COPY ./tools/healthcheck.sh /tmp/healthcheck.sh

RUN chmod +x /tmp/mariadb.sh /tmp/init.sql /tmp/healthcheck.sh
RUN chmod +x /tmp/init.sql

ENTRYPOINT ["/usr/bin/tini", "--", "/tmp/mariadb.sh"]
