variable "aws_region" {
  description = "AWS region on which we will setup the cluster"
  default = "eu-central-1"
}

variable "ami" {
  description = "AMI Centos 7"
  default = "ami-0a84197c3325910a9"
}

variable "instance_type" {
  description = "Instance type"
  default = "t3.small"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "~/Sites/Keys/Eduards_AWS.pem"
}

variable "key_name" {
  description = "Desired name of Keypair..."
  default = "Eduards_AWS"
}

# Custom public IPs for servers
variable "reserved_ip" {
	type = "map"
	default = {
		server1 = "18.194.166.4"
    server2 = "3.120.13.137"
    server3 = "52.58.96.28"
    server4 = "52.58.7.128"
	}
}