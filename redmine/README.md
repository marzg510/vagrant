Setting up Redmine
==============

## install

http://redmine.jp/install/
## install on centos
http://blog.redmine.jp/articles/3_4/install/centos/


## build on vagrant
1. vagrant up
```
vagrant up
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
