# My vagrant files

## Overview

This repository is the place to store the Vagrantfile for my practice

## 基本コマンド
vagrant up
vagrant halt
vagrant ssh


## OSを探す
http://www.vagrantbox.es
https://app.vagrantup.com/boxes/search?_ga=2.63661359.1041671455.1500562580-644039754.1500562580

Official Ubuntu 16.04 daily Cloud Image amd64 (Long Term Support release, No Guest Additions)
https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box

vagrant box add ubuntu-16.04 https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box

## Vagrantfile作成
cd お好きなディレクトリ
$ vagrant init box名


## GUI
http://qiita.com/kayo-tozaki/items/50ec737f01561f0ece81
Vagrantfileをいじる
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end

## VMの名前変更
http://qiita.com/udzura/items/4c5e178a96312918bd57
Vagrantfile
config.vm.provider :virtualbox do |vb|
  vb.name = "vagrant-foobarproj"
end

vagrant up
or vagrant reload

vagrant ssh
#sudo apt-get install ubuntu-desktop
sudo apt-get -y install ubuntu-mate-desktop
sudo apt-get -y install ubuntu-mate-core
#startx
sudo reboot

## ユーザー追加
sudo useradd -p $(perl -e 'print crypt("vagrant", "\$6\$");') -m vagrant
sudo usermod -G sudo vagrant
#sudo useradd -m masaru
#sudo passwd masaru
#sudo usermod -G sudo masaru

## パスワード
http://qiita.com/TKR/items/f27271c963de0033f7ff

~/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-xenial64/20170501.0.0/virtualbox/Vagrantfile

config.ssh.username = "ubuntu"
config.ssh.password = "79eee261f17ac64e2481039d"

## 削除他
http://qiita.com/kanpou_/items/08a65234355baf6da98f

boxのパス
~/.vagrant.d/boxes

http://maku77.github.io/vagrant/destroy-vm.html
確認
vagrant global-status

boxの削除
vagrant box remove [Box名]


VMのパス
~/VirtualBox VMs

## VMの削除
Vagranfileのあるディレクトリで
```
vagrant destroy
```
## スナップショット
http://bufferings.hatenablog.com/entry/2016/02/06/163333

```
vagrant snapshot list
vagrant snapshot save hoge
vagrant snapshot restore hoge
vagrant snapshot delete hoge
```

パッケージ化
vagrant package centos65base --output centos65base.box

vagrant package default --output hoge.box

boxに登録
vagrant box add {box名} package.box
vagrant box list


## guest additions
http://qiita.com/isaoshimizu/items/e217008b8f6e79eccc85
```
vagrant plugin install vagrant-vbguest
vagrant vbguest
vagrant vbguest --status
```

* clipboard
```
vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
```

## vmとvagrantのひも付けやり直し
http://elm-arata.hatenablog.com/entry/2013/09/25/175547

## provision
* http://qiita.com/ringo0321/items/38743442a9abfc3be5b2

## 日本語化

- Debian 9
apt-get install locales
sed -i -e "s/# ja_JP.*/ja_JP.UTF-8 UTF-8/" /etc/locale.gen
dpkg-reconfigure -f noninteractive locales
update-locale LANG=ja_JP.UTF-8

- CentOS
    timedatectl set-timezone Asia/Tokyo

## タイムゾーン

- centos7
timedatectl set-timezone Asia/Tokyo

- centos6
cp /usr/share/zoneinfo/Japan /etc/localtime
/etc/sysconfig/clock
ZONE="Asia/Tokyo"

- Debian
timedatectl set-timezone Asia/Tokyo


## vagrant-cachier
http://qiita.com/katsukii/items/ea9c7ae6a92eb6a4e4bd

```
vagrant plugin install vagrant-cachier
```

```
Vagrant.configure("2") do |config|
  # (snip)

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
#    config.cache.scope = :machine
  end

  # (snip)
end
```

