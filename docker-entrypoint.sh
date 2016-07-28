#!/bin/bash -xe
 # sed -i "s|executionMode.*|executionMode = \"${EXECUTION_MODE:=local}\"|" /etc/sds/sparta/application.conf
 # sed -i "s|connectionString.*|connectionString = \""${ZOOKEEPER_HOST:=localhost:2181}"\"|" /etc/sds/sparta/application.conf
 # sed -i "s|hdfsMaster.*|hdfsMaster = \"${HDFS_MASTER:=localhost}\"|" /etc/sds/sparta/application.conf
 # if [[ ! -v EXECUTION_MODE || "${EXECUTION_MODE}" == "local" ]]; then
 #   sed -i "s|spark.master.*|spark.master = \""${SPARK_MASTER:=local[4]}"\"|" /etc/sds/sparta/application.conf
 # fi
 if [[ "${EXECUTION_MODE}" == "mesos" || "${EXECUTION_MODE}" == "yarn" || "${EXECUTION_MODE}" == "standalone" ]]; then
   # wget http://tools.stratio.com/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz
   # wget http://www.apache.org/dyn/closer.lua/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz

   # wget http://192.168.0.18:8000/spark-1.5.2-bin-hadoop2.6.tgz
   mkdir -p /opt/sds/spark
   # tar xvf spark-1.5.2-bin-hadoop2.6.tgz -C /opt/sds/spark --strip-components=1
   # rm spark-1.5.2-bin-hadoop2.6.tgz

   # wget http://192.168.0.18:8000/spark-1.6.1-bin-hadoop2.6.tgz
   # wget https://www.apache.org/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz
   wget $SPARK_BINARY_URL
   mkdir -p /opt/sds/spark
   tar xvf spark-1.6.1-bin-hadoop2.6.tgz -C /opt/sds/spark --strip-components=1
   rm spark-1.6.1-bin-hadoop2.6.tgz

   echo "" >> /etc/default/sparta-variables
   echo "export HADOOP_HOME="/opt/sds/hadoop"" >> /etc/default/sparta-variables
   echo "export HADOOP_USER_NAME="stratio"" >> /etc/default/sparta-variables
   echo "export HADOOP_CONF_DIR="/opt/sds/hadoop/conf"" >> /etc/default/sparta-variables
 fi
 # if [[ "${EXECUTION_MODE}" == "mesos" ]]; then
 #   sed -i "s|sparkHome.*|sparkHome = \""${SPARK_HOME}"\"|" /etc/sds/sparta/application.conf
 #   sed -i "s|master = \"mesos.*|master = \""mesos://${MESOS_MASTER}:7077"\"|" /etc/sds/sparta/application.conf
 # fi
 # if [[ "${EXECUTION_MODE}" == "yarn" ]]; then
 #   sed -i "s|sparkHome.*|sparkHome = \""${SPARK_HOME}"\"|" /etc/sds/sparta/application.conf
 # fi
 # if [[ "${EXECUTION_MODE}" == "standalone" ]]; then
 #   sed -i "s|sparkHome.*|sparkHome = \""${SPARK_HOME}"\"|" /etc/sds/sparta/application.conf
 #   sed -i "s|master = \"spark.*|master = \"spark://"${SPARK_MASTER:=localhost}":7077\"|" /etc/sds/sparta/application.conf
 # fi
 if [[ "${SSH}" == "true" ]]; then
   /usr/sbin/sshd -e
 fi
 /etc/init.d/sparta start
 tail -F /var/log/sds/sparta/sparta.log