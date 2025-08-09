FROM	debian:bookworm

RUN		apt-get update && apt-get install -y \
		nginx \
		curl

RUN		rm -f /etc/nginx/nginx.conf
COPY	conf/nginx.conf /etc/nginx/nginx.conf
COPY   	./tools /var/www/html

EXPOSE 80

CMD		["nginx", "-g", "daemon off;"]