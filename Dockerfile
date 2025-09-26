FROM lucee/lucee:6.0

ENV LUCEE_ADMIN_PASSWORD=admin

COPY ./config/lucee/ /opt/lucee/web/
COPY ./www /var/www

EXPOSE 8888