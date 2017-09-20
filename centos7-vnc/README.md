## How to use
```
vagrant up
vagrant ssh
vncpasswd
<<Enter your vagrant password>>
sudo systemctl start vncserver@:1.service
exit
```


# install repositories
systemctl stop firewalld
yum install -y epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

#epel、remi無効化
#使うときだけ　-–enablerepo　オプションを付けて実行する
#
## vi /etc/yum.repos.d/epel.repo　←　epel設定変更
#ファイルを開いて　enabled=1　となっているところを　enabled=0　に書き換える
#
#同様にremiも設定変更する
## vi /etc/yum.repos.d/epel.remi　←　remi設定変更
#※remiは最初からenabled=0になっていた
#
#パッケージをアップグレード
yum update

# install Desktop

yum groupinstall -–enablerepo=epel “X Window System” XFCE Desktop Fonts

#ターミナル関連をインストール
#下記コマンドを実行すると私の環境では既にインストールされていると表示されました。不要かもしれません。
# yum install –-enablerepo=epel xfce4-terminal xfce-utils

#アイコンをインストール
yum install gnome-icon*



yum install tigervnc*
cp /usr/lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@\:1.service

VNC接続ユーザの作成
rootで接続する場合は必要ありませんが、セキュリティ上良くないので、VNC接続ユーザを作成します。
なお、以降の説明は全てroot以外のユーザがVNC接続をすることを前提としています。
rootユーザ用のVNCサーバを起動する設定やコマンドは異なりますが割愛致します。

# useradd nagaya　←　VNC接続ユーザ『nagaya』を作成
# passwd nagaya　←　パスワードを設定

~/.vnc/xstartup
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
#exec /etc/X11/xinit/xinitrc
exec xfce4-session &


## reference

http://n-portal.com/system/vps_1

