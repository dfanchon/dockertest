# Rubedo dockerfile
FROM tutum/centos:centos7
RUN yum install -y make
# Install PHP env
RUN yum install -y httpd git vim php php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel gcc php-devel php-intl
# Mount volume
#VOLUME /var/www/html/rubedo
# RUN mkdir /var/www/html/rubedo
# RUN mkdir /var/www/html/rubedo/public
# Update httpd conf
RUN cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.old
RUN rm /etc/httpd/conf.d/welcome.conf -f
RUN sed -i 's#/var/www/html#/var/www/html/rubedo/public#g' /etc/httpd/conf/httpd.conf
RUN sed -i 's#Options Indexes FollowSymLinks#Options -Indexes +FollowSymLinks#g' /etc/httpd/conf/httpd.conf
RUN sed -i 's#AllowOverride None#AllowOverride All#g' /etc/httpd/conf/httpd.conf
RUN sed -i 's#ServerName www.example.com:80#ServerName www.example.com:80\nServerName localhost:80#g' /etc/httpd/conf/httpd.conf
#Upgrade default limits for PHP
RUN pecl install mongo
ADD mongo.ini /etc/php.d/mongo.ini
RUN sed -i 's#memory_limit = 128M#memory_limit = 512M#g' /etc/php.ini
RUN sed -i 's#max_execution_time = 30#max_execution_time = 240#g' /etc/php.ini
RUN sed -i 's#upload_max_filesize = 2M#upload_max_filesize = 20M#g' /etc/php.ini
RUN sed -i 's#;date.timezone =#date.timezone = "Europe/Paris"\n#g' /etc/php.ini
# Clone Rubedo
#RUN git clone -b v3-dev https://github.com/WebTales/rubedo.git /var/www/html/rubedo
# Run web server
EXPOSE 80
#ADD install.sh /install.sh
#RUN chmod 755 /install.sh
#CMD '/install.sh'
#ENTRYPOINT httpd -D FOREGROUND
#CMD ["/var/www/html/rubedo/rubedo.sh"]