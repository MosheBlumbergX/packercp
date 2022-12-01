#!/bin/bash

set -e
version="7.3"

echo "Using var version ${version}"



## This is an option monitoring setup we will need to add config files as well and export into KAFKA_OPTS 
# ### Version of Jolokia Agent Jar to Download
# jolokia_version="1.6.2"
# ### Full URL used for Jolokia Agent Jar Download. 
# jolokia_jar_url="http://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/${jolokia_version}/jolokia-jvm-${jolokia_version}-agent.jar"
# wget jolokia_jar_url
# chmod 0755 "jolokia-jvm-${jolokia_version}-agent.jar"

# ### Version of JmxExporter Agent Jar to Donwload
# jmxexporter_version="0.12.0"
# ### Full URL used for Prometheus Exporter Jar Download. 
# jmxexporter_jar_url="https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${jmxexporter_version}/jmx_prometheus_javaagent-${jmxexporter_version}.jar"

# wget jmxexporter_jar_url
# chmod 0755 "jmx_prometheus_javaagent-${jmxexporter_version}.jar"

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
sudo apt-get upgrade -y
sudo apt-get update -y
sudo apt-get install -y wget
sudo apt-get install -y apt-transport-https
sudo apt-get install -y gnupg2
wget -qO - https://packages.confluent.io/deb/${version}/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/${version} stable main"
sudo add-apt-repository "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main"
sudo apt-get -y update
sudo sudo apt -y install default-jdk
sudo apt-get install -y confluent-platform
sudo apt-get install -y confluent-security
sleep 10
