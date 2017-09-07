#!/bin/bash

INSTALLED_FLG=/root/redmine.installed
[ -f ${INSTALLED_FLG} ] && exit 0
set -eu

cd /tmp
# install redmine
svn co https://svn.redmine.org/redmine/branches/3.4-stable /var/lib/redmine <<<"p"
cd /var/lib/redmine
/usr/local/bin/bundle install --without development test --path vendor/bundle

touch ${INSTALLED_FLG}

