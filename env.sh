#!/usr/bin/env bash

DATE=`date +%Y%m%d_%H%M%S`

##### JBOSS Directory Setup #####
export JBOSS_HOME={{ JBOSS_HOME }}
export DOMAIN_BASE={{ DOMAIN_BASE }}
export SERVER_NAME={{ SERVER_NAME }}
export JBOSS_LOG_DIR={{ LOG_HOME }}/${SERVER_NAME}
 
##### Configration File ##### 
export CONFIG_FILE={{ CONFIGURATION }}

export HOST_NAME=`/bin/hostname`
export NODE_NAME=${SERVER_NAME}

export PORT_OFFSET={{ PORT_OFFSET }}

export JBOSS_USER={{ USER_NAME }}

##### Bind Address #####
export BIND_ADDR={{ ansible_host }}

export MULTICAST_ADDR={{ MULTICAST_ADDR }}
export MULTICAST_PORT={{ MULTICAST_PORT }}
export JMS_MULTICAST_ADDR={{ JMS_MULTICAST_ADDR }}
export MODCLUSTER_MULTICAST_ADDR={{ MODCLUSTER_MULTICAST_ADDR }}

export MGMT_ADDR={{ ansible_host }}

export CONTROLLER_IP=${MGMT_ADDR}
let CONTROLLER_PORT=9990+${PORT_OFFSET}
export CONTROLLER_PORT

let CONSOLE_PORT=9990+${PORT_OFFSET}
export CONSOLE_PORT

export LAUNCH_JBOSS_IN_BACKGROUND=true

##### JBoss System module and User module directory #####
export JBOSS_MODULEPATH=${JBOSS_HOME}/modules:${JBOSS_HOME}/modules.ext

# JVM Options : Server
export JAVA_OPTS="-server"
JAVA_OPTS="${JAVA_OPTS} -D[SERVER_NAME=${SERVER_NAME}]"

# JVM Options : Memory 
export JAVA_OPTS="${JAVA_OPTS} -Xms2048m"
export JAVA_OPTS="${JAVA_OPTS} -Xmx2048m"
export JAVA_OPTS="${JAVA_OPTS} -XX:MetaspaceSize=512m" 
export JAVA_OPTS="${JAVA_OPTS} -XX:MaxMetaspaceSize=512m"
#export JAVA_OPTS="${JAVA_OPTS} -Xss1024k"

export JAVA_OPTS="${JAVA_OPTS} -verbose:gc"
export JAVA_OPTS="${JAVA_OPTS} -XX:+PrintGCTimeStamps"
export JAVA_OPTS="${JAVA_OPTS} -XX:+PrintGCDetails"
export JAVA_OPTS="${JAVA_OPTS} -XX:+PrintGCDateStamps"
export JAVA_OPTS="${JAVA_OPTS} -XX:-TraceClassUnloading"
export JAVA_OPTS="${JAVA_OPTS} -Xloggc:${JBOSS_LOG_DIR}/gclog/${SERVER_NAME}.gc.log "

#export JAVA_OPTS="${JAVA_OPTS} -XX:+UseGCLogFileRotation" 
#export JAVA_OPTS="${JAVA_OPTS} -XX:NumberOfGCLogFiles=10" 
#export JAVA_OPTS="${JAVA_OPTS} -XX:GCLogFileSize=3M" 

#export JAVA_OPTS="${JAVA_OPTS} -XX:+UseParallelGC"
#export JAVA_OPTS="${JAVA_OPTS} -XX:+UseParallelOldGC"

#export JAVA_OPTS="${JAVA_OPTS} -XX:+UseConcMarkSweepGC"
#export JAVA_OPTS="${JAVA_OPTS} -XX:+UseG1GC"

export JAVA_OPTS="${JAVA_OPTS} -XX:+ExplicitGCInvokesConcurrent"
export JAVA_OPTS="${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
export JAVA_OPTS="${JAVA_OPTS} -XX:HeapDumpPath=${JBOSS_LOG_DIR}/heapdump"

# Linux Large Page Setting
#export JAVA_OPTS="${JAVA_OPTS} -XX:+UseLargePages"
#export JAVA_OPTS="${JAVA_OPTS} -XX:LargePageSizeInBytes=2m"

export JAVA_OPTS="${JAVA_OPTS} -Djava.net.preferIPv4Stack=true"
export JAVA_OPTS="${JAVA_OPTS} -Dorg.jboss.resolver.warning=true"
export JAVA_OPTS="${JAVA_OPTS} -Dsun.rmi.dgc.client.gcInterval=0x7FFFFFFFFFFFFFFE"
export JAVA_OPTS="${JAVA_OPTS} -Dsun.rmi.dgc.server.gcInterval=0x7FFFFFFFFFFFFFFE"
export JAVA_OPTS="${JAVA_OPTS} -Djboss.modules.system.pkgs=org.jboss.byteman"
export JAVA_OPTS="${JAVA_OPTS} -Djava.awt.headless=true"

#for darwin
export JBOSS_BASE_DIR="$DOMAIN_BASE_DIR"

export JAVA_OPTS="${JAVA_OPTS} -Djboss.server.base.dir=${DOMAIN_BASE}/${SERVER_NAME}"
export JAVA_OPTS="${JAVA_OPTS} -Djboss.socket.binding.port-offset=${PORT_OFFSET}"
export JAVA_OPTS="${JAVA_OPTS} -Djboss.node.name=${NODE_NAME}"
export JAVA_OPTS="${JAVA_OPTS} -Djboss.bind.address.management=${MGMT_ADDR}"
export JAVA_OPTS="${JAVA_OPTS} -Djboss.bind.address=${BIND_ADDR}"
export JAVA_OPTS="${JAVA_OPTS} -Djboss.default.multicast.address=${MULTICAST_ADDR}"
export JAVA_OPTS="${JAVA_OPTS} -Djboss.messaging.group.address=${JMS_MULTICAST_ADDR}"
#export JAVA_OPTS="${JAVA_OPTS} -Djboss.modcluster.multicast.address=${MODCLUSTER_MULTICAST_ADDR}"

export JAVA_OPTS="${JAVA_OPTS} -Djboss.server.log.dir=${JBOSS_LOG_DIR}"

# Use log4j in application
export JAVA_OPTS="${JAVA_OPTS} -Dorg.jboss.as.logging.per-deployment=false "

echo "============================================================="
echo "JBOSS_HOME=${JBOSS_HOME}"
echo "DOMAIN_BASE=${DOMAIN_BASE}"
echo "SERVER_NAME=${SERVER_NAME}"
echo "CONFIG_FILE=${CONFIG_FILE}"
echo "BIND_ADDR=${BIND_ADDR}"
echo "PORT_OFFSET=${PORT_OFFSET}"
echo "MULTICAST_ADDR=${MULTICAST_ADDR}"
echo "CONTROLLER=${CONTROLLER_IP}:${CONTROLLER_PORT}"
echo "CONSOLE=http://${CONTROLLER_IP}:${CONSOLE_PORT}"
echo "============================================================="

