##测试环境zookeeper、kafka部署##
###准备工作###
1，准备3台机器，IP分别是：192.168.143.114，192.168.143.115，192.168.143.116；
2，压缩包准备：zookeeper-3.4.6.tar.gz、kafka_2.11-0.9.0.1.tar.gz
3，解压到/data/svr目录下，配置软链；

![zookeeper4](http://ocr4vlwzo.bkt.clouddn.com//image/zookeeperzookeeper%20%284%29.png)

###搭建zookeeper集群###
在192.168.143.114上

1，进入/data/svr/zookeeper/conf目录下，编辑zoo.cfg文件

![zookeeper5](http://ocr4vlwzo.bkt.clouddn.com//image/zookeeperzookeeper%20%285%29.png)

2，创建zoo.cfg配置文件中指定的数据目录和日志目录

	>>mkdir -p /data/dbdat/zookeeper/
	>>mkdir -p /data/logs/zookeeper/

3， 在数据目录下创建myid文件，并写入与IP对应的id

	>>echo 1 >/data/dbdat/zookeeper/myid

注意：这个id是zookeeper的主机标示，每个主机id不同第二台是2 第三台是3。

4，启动zookeeper服务

	>>sh /data/svr/zookeeper/bin/zkServer.sh start
	
剩下两台机器的zookeeper部署姿势与上面保持一致，需要注意myid的变化，
至此，zookeeper集群部署完毕。

###搭建kafka集群###
在192.168.143.114上

1，进入/data/svr/kafka/config目录下，编辑server.properties文件

![zookeeper6](http://ocr4vlwzo.bkt.clouddn.com//image/zookeeper/zookeeper%20%286%29.png)

2，创建server.properties配置文件中指定的日志目录

	>>mkdir -p /data/logs/kafka/kafka-logs

3，启动kafka服务

	>>sh kafka-server-start.sh -daemon ../config/server.properties &

剩下两台机器的kafka部署姿势与上面保持一致，需要注意server.properties配置文件中broker.id/host.name/listeners字段的变化

###测试集群###

1，创建一个topic

	>>sh /data/svr/kafka/bin/kafka-topics.sh --create --zookeeper 192.168.143.114:2181 --replication-factor 2 --partitions 2 --topic test

2, 查看topic状态

	>>sh /data/svr/kafka/bin/kafka-topics.sh  --describe  --zookeeper 192.168.143.114:2181 --topic test

输出：

Topic:test PartitionCount:2 ReplicationFactor:2 Configs: 

Topic: test Partition: 0 Leader: 1 Replicas: 1,0 Isr: 0,1
 
Topic: test Partition: 1 Leader: 0 Replicas: 0,1 Isr: 0,1






