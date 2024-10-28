FROM ghcr.io/dnj/php-alpine:8.3-pgsql-nginx

RUN --mount=type=bind,source=fs,target=/mnt rmdir /var/www/html && \
	ln -s /var/www/public /var/www/html && \
	mkdir -p /etc/supervisor.d/ && \
	cp -v /mnt/etc/supervisor.d/worker.ini /etc/supervisor.d/worker.ini && \
	cp -v /mnt/etc/nginx/conf.d/default.conf.d/* /etc/nginx/conf.d/default.conf.d/ && \
	echo "* * * * * /usr/local/bin/php /var/www/artisan schedule:run" > /etc/crontab
