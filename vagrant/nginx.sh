#!/usr/bin/env bash
ROOT=$1

apt-key add $ROOT/vagrant/nginx_signing.key
echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list
echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list
apt-get update

apt-get install -y nginx
service nginx stop

cat << EOF > /etc/nginx/conf.d/app.conf
server {
	listen 80 default_server;
	index index.php;
	root $ROOT;
	try_files \$uri \$uri/ @rewrite;

	location @rewrite {
		rewrite ^/(.*)\$ /index.php?_url=/\$1 last;
	}

	location /api {
		rewrite ^/(.*)\$ /index.php?_url=/\$1;
	}

	location ~ \.php {
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index /index.php;

		include /etc/nginx/fastcgi_params;

		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_param PATH_INFO \$fastcgi_path_info;
		fastcgi_param PATH_TRANSLATED \$document_root\$fastcgi_path_info;
		fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
		fastcgi_read_timeout 3000;
		fastcgi_send_timeout 3000;
	}
}
EOF

# Disable sendfile... Virtualbox hates it.
cat /etc/nginx/nginx.conf | sed 's/sendfile.*on;/sendfile off;/' > /etc/nginx/nginx.conf2
rm -f /etc/nginx/nginx.conf
mv /etc/nginx/nginx.conf2 /etc/nginx/nginx.conf
service nginx start
