#!/bin/bash

INSTALLED_FLG=/root/packages.installed
[ -f ${INSTALLED_FLG} ] && exit 0
set -eu

cd /tmp
# install packages
yum -y groupinstall "Development Tools"
yum -y install openssl-devel readline-devel zlib-devel curl-devel libyaml-devel libffi-devel \
postgresql-server postgresql-devel \
httpd httpd-devel \
ImageMagick ImageMagick-devel ipa-pgothic-fonts

touch ${INSTALLED_FLG}

