# Setting up Oracle 12cR1

## install

### vagrant

```
vagrant up
vagrant ssh
sudo -i -u oracle
cd /tmp
unzip /vagrant/xxx.zip -d .
./database/runInstaller
```

## auto startup/shutdown

https://www.server-world.info/query?os=CentOS_7&p=oracle12c&f=6

[root@dlp ~]# vi /etc/sysconfig/dlp.oracledb
# 新規作成：環境変数を定義
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=/u01/app/oracle/product/12.1.0/dbhome_1
ORACLE_SID=dlp
# リスナーサービス設定
[root@dlp ~]# vi /usr/lib/systemd/system/dlp@lsnrctl.service
# 一例ですのでご自由に改変ください
 [Unit]
Description=oracle net listener
After=network.target

[Service]
Type=forking
EnvironmentFile=/etc/sysconfig/dlp.oracledb
ExecStart=/u01/app/oracle/product/12.1.0/dbhome_1/bin/lsnrctl start
ExecStop=/u01/app/oracle/product/12.1.0/dbhome_1/bin/lsnrctl stop
User=oracle

[Install]
WantedBy=multi-user.target

# データベースサービス設定
[root@dlp ~]# vi /usr/lib/systemd/system/dlp@oracledb.service
# 一例ですのでご自由に改変ください
 [Unit]
Description=oracle net listener
After=network.target lsnrctl.service

[Service]
Type=forking
EnvironmentFile=/etc/sysconfig/dlp.oracledb
ExecStart=/u01/app/oracle/product/12.1.0/dbhome_1/bin/dbstart /u01/app/oracle/product/12.1.0/dbhome_1
ExecStop=/u01/app/oracle/product/12.1.0/dbhome_1/bin/dbshut /u01/app/oracle/product/12.1.0/dbhome_1
User=oracle

[Install]
WantedBy=multi-user.target

[root@dlp ~]# systemctl daemon-reload 
[root@dlp ~]# systemctl enable dlp@lsnrctl dlp@oracledb 
