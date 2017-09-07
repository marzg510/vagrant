#!/bin/bash

INSTALLED_FLG=/root/passenger.installed
[ -f ${INSTALLED_FLG} ] && exit 0
set -eu

cd /tmp
# install passenger
/usr/local/bin/gem install passenger --no-rdoc --no-ri
/usr/local/bin/passenger-install-apache2-module --auto --languages ruby

touch ${INSTALLED_FLG}

