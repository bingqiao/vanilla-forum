FROM centos:7
MAINTAINER bingqiao <bqiaodev@gmail.com>

# update and install packages
RUN yum -y update && \
yum -y install wget tar unzip && \
yum -y install lsof && \
yum -y install epel-release yum-utils && \
yum -y install httpd && \
yum -y install python36 && \
yum -y install python36-setuptools && \
easy_install-3.6 pip && pip3 install requests

RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
yum-config-manager --enable remi-php73 && \
yum -y install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd php-mbstring

RUN wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm && \
rpm --force -ivh mysql-community-release-el7-5.noarch.rpm && \
yum -y update && \
yum -y install mysql-server

# install vanilla forum
RUN wget https://github.com/vanilla/vanilla/releases/download/Vanilla_2.8/vanilla-2.8.zip -O /tmp/vanilla.zip

RUN unzip -o /tmp/vanilla.zip -d /var/www/html

ADD init.sh /scripts/init.sh

RUN chmod u+x /scripts/init.sh

COPY ./config/httpd/httpd.conf /etc/httpd/conf/

RUN cp /var/www/html/.htaccess.dist /var/www/html/.htaccess

CMD ["./scripts/init.sh"]
