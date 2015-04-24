#!/usr/bin/env bash

# Set up synched folder.
rm -rf /var/www
ln -fs /vagrant /var/www

ROOT=/var/www

apt-get update
apt-get install -y build-essential
apt-get install -y git

$ROOT/vagrant/nginx.sh $ROOT
$ROOT/vagrant/postgresql.sh
$ROOT/vagrant/redis.sh
$ROOT/vagrant/nodejs.sh
$ROOT/vagrant/npmpackages.sh
$ROOT/vagrant/php.sh
$ROOT/vagrant/phalcon.sh /home/vagrant
$ROOT/vagrant/xdebug.sh
