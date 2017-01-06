FROM ubuntu:16.04

ADD nginx.list /etc/apt/sources.list.d
ADD trusted.gpg /etc/apt
RUN \
	apt-get update && \
	apt-get install -y supervisor nginx nginx-module-geoip nginx-module-pagespeed nginx-module-http-headers-more php7.0-fpm php7.0-fpm php7.0-mysql php7.0-mbstring php7.0-gd php7.0-xmlrpc php7.0-mcrypt php7.0-pgsql php7.0-curl php7.0-zip && \
	rm -rf /var/lib/apt/lists/* 

ADD nginx /etc/nginx
ADD fpm /etc/php/7.0/fpm
ADD supervisor/conf.d /etc/supervisor/conf.d
ADD tools /var/www/tools
ADD run.sh /

RUN rm /etc/nginx/conf.d/default.conf
RUN chmod +x /run.sh

# Define default command.
CMD ["/run.sh"]

# Expose ports.
EXPOSE 80
EXPOSE 443
