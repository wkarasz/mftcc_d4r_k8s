#!/bin/bash

# First argument - ip or hostname of JDBC server

# update /etc/hosts
cp /etc/hosts ~/hosts.new
sed -i -- "s/localhost.localdomain/`hostname`/g" ~/hosts.new
cp -f ~/hosts.new /etc/hosts

# install MFT CC
cd /opt/mftcc
mv /content/SilentInstall.xml .
mv /content/sqljdbc4.jar .
mv /content/keystore.jks .
sed -i -- "s/dockerhostname/`hostname`/g" SilentInstall.xml
sed -i -- "s/dockerjdbchost/$1/g" SilentInstall.xml
chmod +x /opt/mftcc/install.sh
export JAVA_HOME=/opt/java/jdk1.8.0_131
export TERM=dumb
nohup ./install.sh silent &
sleep 120

# start service in background here
sed -i -- "s/Xms512m/Xms256m/g" /opt/mftcc/server/bin/setenv.sh
sed -i -- "s/Xmx4096m/Xmx1024m/g" /opt/mftcc/server/bin/setenv.sh 
nohup /opt/mftcc/server/bin/startup.sh &
mv /content/start_mft.sh /opt/mftcc/server/bin/; chmod 755 /opt/mftcc/server/bin/start_mft.sh
mv /content/stop_mft.sh /opt/mftcc/server/bin/; chmod 755 /opt/mftcc/server/bin/stop_mft.sh
sleep 30