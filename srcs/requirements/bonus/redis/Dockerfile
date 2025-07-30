FROM	debian:bullseye

RUN	apt-get update && apt-get install -y \
	redis-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /var/lib/redis /var/log/redis && \
	chown -R redis:redis /var/lib/redis /var/log/redis

COPY	conf/redis.conf /etc/redis/redis.conf
RUN		chown redis:redis /etc/redis/redis.conf
RUN		echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf


EXPOSE	6379

USER	redis

CMD	["redis-server", "/etc/redis/redis.conf"]
