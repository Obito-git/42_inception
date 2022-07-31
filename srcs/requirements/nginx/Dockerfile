FROM	alpine:3.14

#nginx
RUN apk update
RUN apk upgrade
RUN apk add nginx

RUN mkdir -p /var/www/html/
COPY conf/default.conf /etc/nginx/http.d/default.conf

#open ssl
RUN		apk add openssl
RUN		mkdir -p /etc/nginx/ssl
RUN		openssl req \
		-newkey rsa:4096 \
		-x509 \
		-sha256 \
		-days 365 \
		-nodes \
		-subj "/C=FR/ST=IDF/L=PARIS/O=42/OU=amyroshn/CN=localhost" \
		-keyout /etc/nginx/ssl/inception.key \
		-out /etc/nginx/ssl/inception.cert

#openrc nginx dependency
RUN		apk add openrc
RUN		rc-update add nginx default

EXPOSE	443
CMD		["nginx", "-g", "daemon off;"]
