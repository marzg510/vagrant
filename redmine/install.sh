#!/bin/bash

INSTALLED_FLG=/root/redmine.installed
[ -f ${INSTALLED_FLG} ] && exit 0
set -eu

cd /tmp
# postgreSQL setting
postgresql-setup initdb
sed -i -E '/# Put your actual configuration here/a host    redmine         redmine         127.0.0.1/32            trust' /var/lib/pgsql/data/pg_hba.conf
sed -i -E '/# Put your actual configuration here/a host    redmine         redmine         ::1/128                 trust' /var/lib/pgsql/data/pg_hba.conf
systemctl start postgresql.service
systemctl enable postgresql.service
cd /var/lib/pgsql
sudo -u postgres createuser redmine
sudo -u postgres createdb -E UTF-8 -l ja_JP.UTF-8 -O redmine -T template0 redmine
cd ~
# setting redmine
cat >/var/lib/redmine/config/database.yml <<EOF
production:
  adapter: postgresql
  database: redmine
  host: localhost
  username: redmine
  password: ""
  encoding: utf8
EOF
cat >/var/lib/redmine/config/configuration.yml <<EOF
production:
  email_delivery:
    delivery_method: :smtp
    smtp_settings:
      address: "localhost"
      port: 25
      domain: "localdomain"
  rmagick_font_path: /usr/share/fonts/ipa-pgothic/ipagp.ttf
EOF
cd /var/lib/redmine
/usr/local/bin/bundle install --without development test --path vendor/bundle
/usr/local/bin/bundle exec rake generate_secret_token
RAILS_ENV=production /usr/local/bin/bundle exec rake db:migrate
RAILS_ENV=production REDMINE_LANG=ja /usr/local/bin/bundle exec rake redmine:load_default_data
# configure passenger
cat >/etc/httpd/conf.d/redmine.conf <<EOF
# allow Redmine files
<Directory "/var/lib/redmine/public">
  Require all granted
</Directory>
EOF
echo "# Basic setting for Passenger" >>/etc/httpd/conf.d/redmine.conf
/usr/local/bin/passenger-install-apache2-module --snippet >>/etc/httpd/conf.d/redmine.conf
cat >>/etc/httpd/conf.d/redmine.conf <<EOF
# tuning for passenger(option)
# show Phusion Passenger users guide(https://www.phusionpassenger.com/library/config/apache/reference/)
PassengerMaxPoolSize 20
PassengerMaxInstancesPerApp 4
PassengerPoolIdleTime 864000
PassengerStatThrottleRate 10

Header always unset "X-Powered-By"
Header always unset "X-Runtime"
EOF
# configure for apache
chown -R apache:apache /var/lib/redmine
#sed -i -e '/^DocumentRoot/c DocumentRoot "/var/lib/redmine/public"' /etc/httpd/conf/httpd.conf
cat >>/etc/httpd/conf.d/redmine.conf <<EOF
Alias /redmine /var/lib/redmine/public
<Location /redmine>
  PassengerBaseURI /redmine
  PassengerAppRoot /var/lib/redmine
</Location>
EOF
systemctl start httpd.service
systemctl enable httpd.service

touch ${INSTALLED_FLG}

