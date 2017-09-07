# Setting up Oracle 12cR1

## Requirements
* vagrant

## install

### pre-installation

* startup os
```
vagrant up
```

### installation
1. console login by oracle
2. start GUI
```
export LANG=ja_JP.UTF8
startx
```
3. Open Terminal and unzip install archive
```
cd /tmp
unzip /vagrant/linuxx54_12201_database.zip -d .
```
4. Install
```
./database/runInstaller
/u01/app/oraInventory/orainstRoot.sh
/u01/app/oracle/product/12.2.0/dbhome_1/root.sh 
 #=> TFA install = Yes
```

5. Create database
```
export LANG=ja_JP.UTF8
export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1
export PATH=${PATH}:${ORACLE_HOME}/bin
dbca
netca
```

### post installation

1. setup oracle user
```
cat >>~/.bashrc <<EOF
export LANG=ja_JP.UTF8
export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1
export PATH=\${PATH}:\${ORACLE_HOME}/bin
export ORACLE_SID=orcl
export NLS_LANG=japanese_japan.AL32UTF8
EOF
```
2. manualy startup/shutdown

* https://www.server-world.info/query?os=CentOS_7&p=oracle12c&f=6

* edit /etc/oratab
```
sed -i -e 's/:N$/:Y/g' /etc/oratab
```

* startup
```
sudo -i -u oracle
dbstart $ORACLE_HOME
```
* shutdown
```
sudo -i -u oracle
dbshut $ORACLE_HOME
```

*

```
cat >/etc/sysconfig/dlp.oracledb <<EOF
# set environment
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=/u01/app/oracle/product/12.1.0/dbhome_1
ORACLE_SID=orcl
EOF
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
```
