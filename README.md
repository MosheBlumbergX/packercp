# Packer for CP 

This is a method to build AWS AMI based on `ami-0be590cb7a2969726` :
* Base image provided by Amazon AWS	market place (which indicated the security level)
* eu-west-2	
* bionic	
* 18.04	amd64	hvm-ssd 

This packer script will create AMI which will:  
* Update/Upgrade OS 
* Install Java 
* Get repo key 
* Add key
* Apt install Confluent 7.3 (currently hard coded but can be determined)
  

```
packer build packer/ubuntu-cp-scripted.json
```

Or: 

```
./packer/packer_build_cp_ami.sh
```


Expected output:  

```
==> Wait completed after 11 minutes 48 seconds

==> Builds finished. The artifacts of successful builds are:
--> moshe-packer-cp: AMIs were created:
eu-west-2: ami-052b1e29afdc6bfc5
```

You can now build on top of this image or create ec2 out of it. 
This install method to create hte AMI is internet and repo based, we could also introduce the archive method. 


```
sudo zookeeper-server-start -daemon /etc/kafka/zookeeper.properties 
sudo kafka-server-start -daemon /etc/kafka/server.properties

kafka-topics --bootstrap-server localhost:9092 --create --partitions 3 --replication-factor 1  --topic srctopic 
Created topic srctopic.
```


This is a out of the box, single broker single zookeeper setup, which is not a good idea, this should be scaled up and configured.  

Consider adding:  
* Jolokia
* Prometheus
* Log Directory
* All Ansible setup 