#!/bin/bash
sudo yum -y update
sudo yum -y install git
sudo yum -y install httpd
sudo systemctl start httpd
sudo yum install -y java
sudo yum install -y java-devel
export JAVA_HOME=(/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-2.el8_5.x86_64/jre)
sudo yum install -y openssh-server
mkdir ~/jenkins