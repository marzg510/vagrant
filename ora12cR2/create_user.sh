#!/bin/bash -x
groupadd -fg 54321 oinstall
groupadd -fg 54322 dba
groupadd -fg 54323 backupdba
groupadd -fg 54324 oper
groupadd -fg 54325 dgdba
groupadd -fg 54326 kmdba
getent passwd oracle >/dev/null || useradd -u 1200 -g oinstall -m -p $(perl -e 'print crypt("oracle", "\$6\$");') oracle
usermod -G dba,oper,backupdba,dgdba,kmdba oracle

