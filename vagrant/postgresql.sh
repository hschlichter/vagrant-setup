#!/usr/bin/env bash
pushd .

echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update

apt-get install -y postgresql-9.4
sudo -i -u postgres <<EOF
psql -c "CREATE USER dbuser PASSWORD '123';"
psql -c "CREATE DATABASE vagranttest;"
exit
EOF
echo "listen_addresses = '*'" >> /etc/postgresql/9.4/main/postgresql.conf
cat /etc/postgresql/9.4/main/pg_hba.conf | sed 's/host    all             all             127.0.0.1\/32            md5/host    all             all             0.0.0.0\/0            md5/' > /etc/postgresql/9.4/main/pg_hba.conf2
rm -f /etc/postgresql/9.4/main/pg_hba.conf
mv /etc/postgresql/9.4/main/pg_hba.conf2 /etc/postgresql/9.4/main/pg_hba.conf
service postgresql restart

popd
