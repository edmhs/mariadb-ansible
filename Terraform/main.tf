variable "aws_access_key" {}
variable "aws_secret_key" {}


# Specify the provider and access details
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}


#
# Server 1 
#

data "aws_eip" "static_ip_1" {
  public_ip = "${var.reserved_ip["server1"]}"
}

resource "aws_instance" "server1" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  
  

  tags = {
    Name  = "Centos 7 - MariaDB 1"
  }

  
}

resource "aws_eip_association" "static_ip_1" {
  instance_id   = "${aws_instance.server1.id}"
  allocation_id = "${data.aws_eip.static_ip_1.id}"
}

#
# Server 2
#

data "aws_eip" "static_ip_2" {
  public_ip = "${var.reserved_ip["server2"]}"
}

resource "aws_instance" "server2" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  
   availability_zone = "${var.aws_region}a"

  tags = {
    Name  = "Centos 7 - MariaDB 2"
  }
}

resource "aws_eip_association" "static_ip_2" {
  instance_id   = "${aws_instance.server2.id}"
  allocation_id = "${data.aws_eip.static_ip_2.id}"
}

#
# Server 3
#

data "aws_eip" "static_ip_3" {
  public_ip = "${var.reserved_ip["server3"]}"
}

resource "aws_instance" "server3" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  
  availability_zone = "${var.aws_region}b"

  tags = {
    Name  = "Centos 7 - MariaDB 3"
  }
}

resource "aws_eip_association" "static_ip_3" {
  instance_id   = "${aws_instance.server3.id}"
  allocation_id = "${data.aws_eip.static_ip_3.id}"
}

#
# Server 4
#

data "aws_eip" "static_ip_4" {
  public_ip = "${var.reserved_ip["server4"]}"
}

resource "aws_instance" "server4" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  
  availability_zone = "${var.aws_region}c"

  tags = {
    Name  = "Centos 7 - MariaDB 4"
  }
}

resource "aws_eip_association" "static_ip_4" {
  instance_id   = "${aws_instance.server4.id}"
  allocation_id = "${data.aws_eip.static_ip_4.id}"
}