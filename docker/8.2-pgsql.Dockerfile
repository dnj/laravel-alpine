FROM ghcr.io/dnj/php-alpine:8.2-pgsql

RUN apk add --update --no-cache supervisor && \
	(crontab -u www-data -l 2>/dev/null && echo "* * * * * /usr/local/bin/php  /var/www/artisan schedule:run > /dev/null 2>&1") | crontab -u www-data -

COPY supervisor/ /etc/supervisor.d/
CMD ["/usr/bin/supervisord"]