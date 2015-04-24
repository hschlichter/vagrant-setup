#!/usr/bin/env bash
ROOT=$1
pushd .
cd $ROOT

git clone --depth=1 git://github.com/phalcon/cphalcon.git cphalcon
cd cphalcon
git checkout -b tags/phalcon-v2.0.0
cd build
./install

cat << EOF > /etc/php5/mods-available/phalcon.ini
; configuration for php phalcon
; priority=20
extension=$ROOT/cphalcon/build/64bits/modules/phalcon.so
EOF
ln -s /etc/php5/mods-available/phalcon.ini /etc/php5/fpm/conf.d/20-phalcon.ini
ln -s /etc/php5/mods-available/phalcon.ini /etc/php5/cli/conf.d/20-phalcon.ini
service php5-fpm restart
popd

