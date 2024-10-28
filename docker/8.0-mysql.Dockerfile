FROM ghcr.io/dnj/php-alpine:8.0-mysql

COPY --from=qpod/supervisord:alpine /opt/supervisord/supervisord /usr/bin/supervisord
RUN --mount=type=bind,source=fs,target=/mnt \
	cp -v /mnt/etc/supervisord.conf /etc/supervisord.conf && \
	mkdir /etc/supervisor.d/ && \
	cp -v /mnt/etc/supervisor.d/worker.ini /etc/supervisor.d/worker.ini && \
	echo "* * * * * /usr/local/bin/php /var/www/artisan schedule:run" > /etc/crontab
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]