# Setting up Cassandra

## Requirements
* vagrant
* vagrant cache plugin
```
vagrant plugin install vagrant-cachier
```

## Install
1. startup 2 nodes
 * It takes quite a long time to build "cassandra-driver", so wait patiently
```
vagrant up
```

2. Setup the cluster
/etc/cassandra/cassandra.yaml
node1
seeds         listen        rpc
192.168.56.41	192.168.56.41	192.168.56.41

node2
seeds         listen        rpc
192.168.56.41	192.168.56.42	192.168.56.42

3. Confirm the cluster
```
nodetool status
```

## How to use

```
export CQLSH_NO_BUNDLED=TRUE
cqlsh localhost
CREATE KEYSPACE IF NOT EXISTS test_keyspace WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor': 3 };
USE test_keyspace;
CREATE TABLE book ( isbn text PRIMARY KEY, title text, price int);
INSERT INTO book ( isbn, title, price ) VALUES ('978-4873115290', 'Cassandra', 3672);
INSERT INTO book ( isbn, title, price ) VALUES ('978-1449358549', 'Elasticsearch: The Definitive Guide', 5432);
INSERT INTO book ( isbn, title, price ) VALUES ('978-1449305048', 'Redis Cookbook', 2505);
SELECT * FROM book;
```




## Others
* Set Nodes Number
 - Modify Vagrantfile
 - Change the following line 2 to your value
```
(1..2).each do |i|
```

## References
* http://qiita.com/noralife/items/db876cf4b9d8b229aaa3
* http://cassandra.apache.org/doc/latest/getting_started/installing.html
* http://d.hatena.ne.jp/Kazuhira/20170111/1484145162
* https://stackoverflow.com/questions/39703374/cqlsh-typeerrorref-does-not-take-keyword-arguments

