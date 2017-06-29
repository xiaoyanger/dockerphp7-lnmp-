FROM centos:6
MAINTAINER master
RUN   useradd www && usermod -u 1000 www

#auth 
RUN mkdir -p /data/soft && cd /data/soft&& yum install git -y  && \
	git clone git://github.com/xiaoyanger/lnmp.git lnmp_installer&& \
	yum clean all

WORKDIR /data/soft/lnmp_installer
# nginx 
RUN bash install.sh -s -n 1
# mysql
RUN bash install.sh -s -m 1
# php
RUN bash install.sh -s -p 3 -d 1
# 清理文件
RUN yum clean all
# nginx配置文件
RUN mv /data/server/nginx/conf/vhost/default.conf.dist /data/server/nginx/conf/vhost/default.conf

RUN service nginx start
RUN service php-fpm start
RUN service mysqld start
RUN ln -s /data/server/nginx/sbin/nginx  /usr/local/bin/nginx
RUN ln -s /data/server/php/bin/php /usr/local/bin/php
RUN ln -s /data/server/mysql/bin/mysql /usr/local/bin/mysql
# Define working directory.
WORKDIR /
ADD phpMyAdmin /data/phpMyAdmin

ADD init.sh /init.sh

CMD ["/init.sh"]

VOLUME ["/data/"]

# Expose ports.
EXPOSE 9000
