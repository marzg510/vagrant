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

