#!/bin/bash

INSTALLED_FLG=/root/passenger.configured
[ -f ${INSTALLED_FLG} ] && exit 0
set -eu

cd /tmp
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

