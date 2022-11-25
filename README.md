# Attempt to packer 

Since we know that we have validation for the cp-demo images, and they use the [ubi8](https://catalog.redhat.com/software/containers/ubi8/ubi-minimal/5c359a62bed8bd75a2c3fba8) . we can attempt packer which the prospect can run on his own. 

Since we know that on the market place (aws) we can get Red Hat Enterprise Linux 8 ami-035c5dc086849b5de [which is supported by us](https://docs.confluent.io/platform/current/installation/versions-interoperability.html#operating-systems) 

The other thing we might think of is just to use the [Amazon EC2 Image Builder](https://aws.amazon.com/blogs/security/quickly-build-stig-compliant-amazon-machine-images-using-amazon-ec2-image-builder/) 


To think about: 
* Build image
* Packer to run the collection and just create the images 




## Copy from other places 

Files for the post, '[Baking AWS AMI with new Docker CE Using Packer Packer](https://programmaticponderings.com/2017/03/06/baking-aws-ami-with-new-docker-ce-using-packer/)'.

Partially bake an existing Amazon Machine Image (Amazon AMI) with the new Docker CE, preparing it as a base for the creation of Amazon Elastic Compute Cloud (Amazon EC2) compute instances.

Docker just announced the release of Docker Enterprise Edition (EE), a new version of the Docker platform optimized for business-critical deployments. As part of the release, Docker also renamed the free Docker products to Docker Community Edition (CE). Both products are adopting a new time-based versioning scheme for both Docker EE and CE. The initial release of Docker CE and EE, the 17.03 release, is the first to use the new scheme.

Adding Docker and similar tooling to an AMI is referred to as partially baking an AMI, often referred to as a hybrid AMI. According to AWS, ‘_hybrid AMIs provide a subset of the software needed to produce a fully functional instance, falling in between the fully baked and JeOS (just enough operating system) options on the AMI design spectrum._’

Installing Docker CE on an AWS AMI should not be confused with Docker’s also recently announced Docker Community Edition (CE) for AWS. Docker for AWS offers multiple CloudFormation templates for Docker EE and CE. According to Docker, Docker for AWS ‘_provides a Docker-native solution that avoids operational complexity and adding unneeded additional APIs to the Docker stack._’

## Helpful Commands

### Packer

```
bash
source <your_aws_creds>.env

packer build ubuntu_docker_ce_ami.json.json
```

### Terraform

```bash
terraform remote config \
  -backend=s3 \
  -backend-config="bucket=<your_bucket_name>" \
  -backend-config="key=terraform-test-docker-ce.tfstate" \
  -backend-config="region=us-east-1"

terraform validate
terraform plan
terraform apply
terraform show
```

### AWS CLI Queries

```bash
# Returns AMI Image ID
aws ec2 describe-images \
  --filters Name=tag-key,Values=ami Name=tag-value,Values=ubuntu-xenial-docker-ce-base \
  --query 'Images[*].{ID:ImageId}'

# Returns EC2 Image ID
aws ec2 describe-instances \
  --filters Name='tag:Name,Values=tf-instance-test-docker-ce' \
  --output text --query 'Reservations[*].Instances[*].ImageId'

# Returns EC2 Private IP
aws ec2 describe-instances \
  --filters Name='tag:Name,Values=tf-instance-test-docker-ce' \
  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress'

# Returns EC2 Public IP
aws ec2 describe-instances \
  --filters Name='tag:Name,Values=tf-instance-test-docker-ce' \
  --output text --query 'Reservations[*].Instances[*].PublicIpAddress'
```



ref:  
[Baking AWS AMI with new Docker CE Using Packer](https://programmaticponderings.com/2017/03/06/baking-aws-ami-with-new-docker-ce-using-packer/)  
[Repo](https://github.com/garystafford/ami-docker-ce-packer)