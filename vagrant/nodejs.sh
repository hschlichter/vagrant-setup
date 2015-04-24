#!/usr/bin/env bash
pushd .

curl -sL https://deb.nodesource.com/setup | sudo bash -

apt-get install -y nodejs
apt-get install -y fontconfig

popd
