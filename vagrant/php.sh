#!/usr/bin/env bash
pushd .

add-apt-repository -y ppa:ondrej/php5-5.6
apt-get update

apt-get install -y --force-yes php5-cli
apt-get install -y --force-yes php5-intl
apt-get install -y --force-yes php5-mcrypt
apt-get install -y --force-yes php5-xdebug
apt-get install -y --force-yes php5-fpm
apt-get install -y --force-yes php5-curl
apt-get install -y --force-yes php5-pgsql
apt-get install -y --force-yes php5-xsl
apt-get install -y --force-yes php5-dev

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Set php5-fpm port to 9000 in www.conf
cat /etc/php5/fpm/pool.d/www.conf | sed 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/' > /etc/php5/fpm/pool.d/www.conf2
rm -f /etc/php5/fpm/pool.d/www.conf
mv /etc/php5/fpm/pool.d/www.conf2 /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart

popd
