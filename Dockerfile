# Centos based container with Apache, PHP and MySql
FROM apache-php-mysql
MAINTAINER bingqiao <bqiaodev@gmail.com>

COPY ./binaries/vanilla/*.zip /tmp/

RUN unzip -o /tmp/*.zip -d /var/www/html

ADD init.sh /scripts/init.sh

# fix windows carriage return
RUN sed -i -e 's/\r$//' /scripts/init.sh && \
chmod u+x /scripts/init.sh

COPY ./config/httpd/httpd.conf /etc/httpd/conf/

RUN cp /var/www/html/.htaccess.dist /var/www/html/.htaccess

CMD ["./scripts/init.sh"]
