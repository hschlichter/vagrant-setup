#!/usr/bin/env bash
cat << EOF > /etc/php5/mods-available/xdebug.ini
zend_extension=xdebug.so

[XDEBUG]
xdebug.remote_connect_back=1
xdebug.default_enable=1
xdebug.remote_autostart=0
xdebug.remote_enable=1
xdebug.remote_port=9000
xdebug.remote_handler=dbgp
EOF
