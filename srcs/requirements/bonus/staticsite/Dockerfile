FROM	debian:bullseye


RUN		apt-get update && apt-get install -y \
		openssl \
		nginx \
		curl \
		sudo 

RUN		rm -f /etc/nginx/nginx.conf
RUN     rm -f /var/www/staticsite/index.html
COPY	conf/nginx.conf /etc/nginx/nginx.conf

COPY    conf/index.html /var/www/staticsite/index.html

EXPOSE 6667

CMD		["nginx", "-g", "daemon off;"]
