FROM ghcr.io/dnj/php-alpine:8.2-mysql-nginx

RUN rmdir /var/www/html && \
	ln -s /var/www/public /var/www/html && \
	(crontab -u www-data -l 2>/dev/null && echo "* * * * * /usr/local/bin/php  /var/www/artisan schedule:run > /dev/null 2>&1") | crontab -u www-data -

COPY nginx/ /etc/nginx/conf.d/default.conf.d/ 
COPY supervisor/worker.ini /etc/supervisor.d/
