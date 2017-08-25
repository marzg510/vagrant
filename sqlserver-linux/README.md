SQL Server on Linux
==============

## install on centos
https://docs.microsoft.com/ja-jp/sql/linux/quickstart-install-connect-red-hat

## build on vagrant
1. vagrant up
```
vagrant up
vagrant ssh
sudo /opt/mssql/bin/mssql-conf setup
systemctl status mssql-server
```

## build on docker

