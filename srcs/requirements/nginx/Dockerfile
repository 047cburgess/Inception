FROM	debian:bullseye

RUN		apt-get update && apt-get upgrade -y && apt-get install -y \
		openssl \
		nginx \
		curl \
		vim \
		sudo 

RUN		rm -f /etc/nginx/nginx.conf

# create the ssl directory
RUN		mkdir -p /etc/nginx/ssl

# generate the ssl certificate
RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    	/etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=caburges/CN=caburges.42.fr"


COPY	./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE	443

CMD		["nginx", "-g", "daemon off;"]
