#! /bin/sh

mkdir -p /opt/php-7.1
mkdir /usr/local/src/php7-build
cd /usr/local/src/php7-build
wget http://de1.php.net/get/php-7.1.0.tar.bz2/from/this/mirror -O php-7.1.0.tar.bz2
tar jxf php-7.1.0.tar.bz2

cd php-7.1.0/

apt-get install build-essential nano autoconf

apt-get install libfcgi-dev libfcgi0ldbl libjpeg62-turbo-dbg libmcrypt-dev libssl-dev libc-client2007e libc-client2007e-dev libxml2-dev libbz2-dev libcurl4-openssl-dev libjpeg-dev libpng12-dev libfreetype6-dev libkrb5-dev libpq-dev libxml2-dev libxslt1-dev

ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a

./configure --prefix=/opt/php-7.1 --with-pdo-pgsql --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-pdo-mysql --with-mysqli --with-mysql-sock=/var/run/mysqld/mysqld.sock --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=www-data --with-fpm-group=www-data --with-libdir=/lib/x86_64-linux-gnu --enable-ftp --with-imap --with-imap-ssl --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm

make
make install

cp /usr/local/src/php7-build/php-7.1.0/php.ini-production /opt/php-7.1/lib/php.ini

cp /opt/php-7.1/etc/php-fpm.conf.default /opt/php-7.1/etc/php-fpm.conf
cp /opt/php-7.1/etc/php-fpm.d/www.conf.default /opt/php-7.1/etc/php-fpm.d/www.conf

chmod 755 /etc/init.d/php-7.1-fpm
insserv php-7.1-fpm

/etc/init.d/php-7.1-fpm start
