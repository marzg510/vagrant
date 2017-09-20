Setting up Redmine
==============


## Requirements
* vagrant

## install

http://redmine.jp/install/
### install on centos
http://blog.redmine.jp/articles/3_4/install/centos/

### mail
http://redmine.jp/faq/general/mail_notification/

### postfix
* https://centossrv.com/postfix.shtml
* http://www.geekpage.jp/technology/ip-base/mail-2.php
* http://tech.matchy.net/archives/35
* http://qiita.com/tachitechi/items/895bf9c63356ee0751b5

```
yum install -y mailx
```

for gmail
```
yum install -y cyrus-sasl cyrus-sasl-plain cyrus-sasl-md5
```
* https://accounts.google.com/DisplayUnlockCaptcha

/etc/postfix/main.cf
```
myhostname = redmine.private.m510.net
myorigin = $myhostname
inet_interfaces = localhost
mydestination = $myhostname, localhost.localdomain, localhost.$mydomain, localhost
# for gmail
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_tls_security_options = noanonymous
smtp_sasl_mechanism_filter = plain
smtp_tls_CApath = /etc/pki/tls/certs/ca-bundle.crt
```
/etc/postfix/sasl_passwd
```
sudo cat >/etc/postfix/sasl_passwd <<EOF
[smtp.gmail.com]:587 foo@gmail.com:your_password
EOF
sudo chown root:root /etc/postfix/sasl_passwd
sudo chmod 600 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd
```

* テスト方法その1
```
echo "test mail" | mail -s "test" -r vagrant@m510.net hoge.hoge@gmail.com
```

* テスト方法その2
```
sendmail foo@foo.com
From:vagrant@m510.net
To:foo@m510.net
Subject: test

test mail

.
```

* テスト方法その3
```
telnet localhost 25
HELO localhost.localdomain
MAIL FROM: vagrant@localhost.localdomain
RCPT TO: hoge.hoge@gmail.com
DATA
To: masaru.gotou@gmail.com
Subject: test
From: vagrant@localhost.localdomain

test mail

.

QUIT
```

* ログ確認
```
sudo tail /var/log/mailog
```


### subversion
http://redmine.jp/tech_note/subversion/
http://www.yukun.info/blog/2011/12/linux-redmine-subversion-install.html#11_Subversion
http://park1.wakwak.com/~ima/centos4_subversion0001_2.html

## build on vagrant
1. vagrant up
```
vagrant up
vagrant ssh
/vagrant/install.sh
```

2. access by browser
http://192.168.56.10/

## build on docker
```
cd redmine
docker build -t m510.net/redmine-standalone .
docker run -it --rm --name myredmine m510.net/redmine-standalone bash
```

## Initialize
http://redmine.jp/tech_note/first-step/admin/

## backup
https://redmine.jp/faq/system_management/backup/
https://www.postgresql.jp/document/9.4/html/backup.html

### postgresql
* pg_dump dbname > outfile
```
sudo -u postgres pg_dump -Z9 redmine >~/backup/redmine_db.dmp.gz
```

### files
```
cd /var/lib/redmine && tar zcf ~/backup/redmine_files.tgz files
```

