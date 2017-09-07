#!/bin/bash

INSTALLED_FLG=/root/ruby.installed
[ -f ${INSTALLED_FLG} ] && exit 0
set -eu

cd /tmp
# install ruby
curl -O https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz
tar xf ruby-2.4.1.tar.gz && rm -f ruby-2.4.1.tar.gz
cd ruby-2.4.1
./configure --disable-install-doc
make
make install
/usr/local/bin/gem install bundler --no-rdoc --no-ri

touch ${INSTALLED_FLG}

