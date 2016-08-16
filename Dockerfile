FROM teenak/centos-cdh-hadoop-datanode
MAINTAINER Taishun Nakatani <teenak77@gmail.com>

ENV HADOOP_CONF_DIR /etc/hadoop/conf
ENV YARN_CONF_DIR /etc/hadoop/conf

ADD conf/core-site.xml /etc/hadoop/conf/core-site.xml
ADD conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml
ADD conf/yarn-site.xml /etc/hadoop/conf/yarn-site.xml

# update boot script
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh


EXPOSE   50010 50020 50075 8040 8041 8042 13562 48484

#define HDFS volume to enable to persist namenode fsimage between restart
VOLUME /hadoop

ENTRYPOINT ["/etc/bootstrap.sh"]

