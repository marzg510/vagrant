#!/bin/bash

INSTALLED_FLG=/root/subversion.installed
[ -f ${INSTALLED_FLG} ] && exit 0
set -eu

cd /tmp

# install subversion
yum -y install subversion mod_dav_svn
mkdir -p /var/lib/svn
svnadmin create /var/lib/svn/repos01
chown -R apache:apache /var/lib/svn/repos01
#touch /etc/httpd/conf/svn_auth_file
cat >/etc/httpd/conf.d/svn.conf <<EOF
<Location /svn>
        DAV svn
        SVNParentPath /var/lib/svn
#        AuthType Basic
#        AuthName "svn repository"
#        AuthUserFile /etc/httpd/conf/svn_auth_file
#        Require valid-user
</Location>
EOF
systemctl restart httpd.service
svn mkdir file://localhost/var/lib/svn/repos01/trunk -m "create"
svn mkdir file://localhost/var/lib/svn/repos01/branches -m "create"
svn mkdir file://localhost/var/lib/svn/repos01/tags -m "create"

touch ${INSTALLED_FLG}

