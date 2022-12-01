#!/bin/sh

# Builds Ubuntu CP AMI

set -e

echo " "
echo "*** Provisioning CP version  AMI ***"

packer build -color=false ubuntu-cp-scripted.json
