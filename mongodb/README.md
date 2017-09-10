# Setting up MongoDB

## Requirements
* vagrant
* vagrant cache plugin
```
vagrant plugin install vagrant-cachier
```

## Target
* MongoDB3
* CentOS7

## Install
1. startup 2 nodes
 * It takes quite a long time to build "cassandra-driver", so wait patiently
```
vagrant up
```

## How to use

```
vagant ssh
mongo
```

## Others

## References
* http://qiita.com/SOJO/items/dc5bf9b4375eab14991b
* https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
