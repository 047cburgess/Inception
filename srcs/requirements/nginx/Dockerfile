FROM	debian:bookworm

RUN		apt-get update && apt-get install -y \
		nginx \
		curl \
		sudo 

RUN		rm -f /etc/nginx/nginx.conf

COPY	./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE	443

CMD		["nginx", "-g", "daemon off;"]
